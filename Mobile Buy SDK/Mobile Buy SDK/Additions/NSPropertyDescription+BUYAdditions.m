//
//  NSPropertyDescription+BUYAdditions.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSPropertyDescription+BUYAdditions.h"

#import "BUYModelManagerProtocol.h"
#import "BUYObjectProtocol.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSArray+BUYAdditions.h"
#import "NSException+BUYAdditions.h"
#import "NSEntityDescription+BUYAdditions.h"

#import "BUYDateTransformer.h"
#import "BUYDecimalNumberTransformer.h"
#import "BUYIdentityTransformer.h"
#import "BUYURLTransformer.h"


// User Info Keys
NSString * const BUYJSONValueTransformerUserInfoKey = @"JSONValueTransformer";
NSString * const BUYJSONPropertyKeyUserInfoKey = @"JSONPropertyKey";

// This is defined by mogenerator
static NSString * const BUYAttributeValueClassNameKey = @"attributeValueClassName";

static NSString * const BUYDateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";

#pragma mark -

@interface NSObject (BUYValueTransforming)
- (BOOL)buy_isValidObject;
+ (NSString *)buy_JSONValueTransformerName;
@end

#pragma mark -

@implementation NSPropertyDescription (BUYAdditions)

- (NSString *)buy_JSONValueTransformerName
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		// default transformer
		[NSValueTransformer setValueTransformer:[[BUYIdentityTransformer alloc] init] forName:BUYIdentityTransformerName];
		
		// attribute type transformers
		[NSValueTransformer setValueTransformer:[[BUYDateTransformer alloc] init] forName:BUYDateTransformerName];
		[NSValueTransformer setValueTransformer:[[BUYDecimalNumberTransformer alloc] init] forName:BUYDecimalNumberTransformerName];
		
		// value type transformers
		[NSValueTransformer setValueTransformer:[[BUYURLTransformer alloc] init] forName:BUYURLTransformerName];
	});
	return self.userInfo[BUYJSONValueTransformerUserInfoKey];
}

- (NSString *)buy_JSONPropertyKey
{
	return self.userInfo[BUYJSONPropertyKeyUserInfoKey];
}

- (NSValueTransformer *)buy_JSONValueTransformer
{
	return [NSValueTransformer valueTransformerForName:self.JSONValueTransformerName];
}

- (id)buy_valueForJSON:(id)JSON object:(id<BUYObject>)object
{
	@throw BUYAbstractMethod();
}

- (id)buy_JSONForValue:(id)object
{
	@throw BUYAbstractMethod();
}

@end

#pragma mark -

static NSString *JSONValueTransformerNameForAttributeType(NSAttributeType type)
{
	NSString *name = nil;
	switch (type) {
		case NSDateAttributeType:
			name = BUYDateTransformerName;
			break;
			
		case NSDecimalAttributeType:
			name = BUYDecimalNumberTransformerName;
			break;
			
		default:
			break;
	}
	return name;
}

@implementation NSAttributeDescription (BUYAdditions)

- (NSString *)buy_attributeValueClassName
{
	return self.userInfo[BUYAttributeValueClassNameKey];
}

- (Class)buy_attributeValueClass
{
	return NSClassFromString([self buy_attributeValueClassName]);
}

- (NSString *)buy_JSONValueTransformerName
{
	NSString *name = [super buy_JSONValueTransformerName];
	if (name == nil) {
		name = JSONValueTransformerNameForAttributeType(self.attributeType);
	}
	if (name == nil) {
		name = [[self buy_attributeValueClass] buy_JSONValueTransformerName];
	}
	if (name == nil) {
		name = BUYIdentityTransformerName;
	}
	return name;
}

- (id)buy_valueForJSON:(id)JSON object:(id<BUYObject>)object
{
	// An attribute's value is determined by the specified transformer.
	// An Identity transform returns the same value. `nil` is converted into `NSNull`.
	id transformedValue = [JSON buy_isValidObject] ? [self.JSONValueTransformer reverseTransformedValue:JSON] : [NSNull null];
	return transformedValue ?: [NSNull null];
}

- (id)buy_JSONForValue:(id)object
{
	// An attribute's JSON is determined by the specified transformer.
	// An identify transform returns the same value.
	return [self.JSONValueTransformer transformedValue:object];
}

@end

#pragma mark -

@implementation NSRelationshipDescription (BUYAdditions)

#pragma mark - Helpers

- (NSString *)encodesIdSuffix
{
	return (self.isToMany ? @"_ids" : @"_id");
}

// array -> (ordered)set
- (id)buy_transformArray:(NSArray<id<BUYObject>> *)array
{
	return self.isOrdered ? [NSOrderedSet orderedSetWithArray:array] : [NSSet setWithArray:array];
}

// (ordered)set -> array
- (NSArray *)buy_arrayForCollection:(id)collection
{
	return self.ordered ? [collection array] : [collection allObjects];
}

// JSON -> model
- (id)buy_objectForJSON:(id)JSON object:(id<BUYObject>)object
{
	id result;
	NSString *entityName = self.destinationEntity.name;
	// If we are expecting an object `id` the object should already exist.
	// Otherwise let the object context decide how to resolve the object and update it.
	if (self.encodesIdInJSON) {
		result = [object.modelManager buy_objectWithEntityName:entityName identifier:JSON];
	}
	else {
		result = [object.modelManager buy_objectWithEntityName:entityName JSONDictionary:JSON];
	}
#if !CORE_DATA_PERSISTENCE
	if (self.inverseRelationship && !self.inverseRelationship.isToMany) {
		[result setValue:object forKey:self.inverseRelationship.name];
	}
#endif
	return result;
}

// model -> JSON
- (id)buy_JSONForObject:(NSObject<BUYObject> *)object
{
	id json = nil;
	if (!self.inverseRelationship || self.inverseRelationship.allowsInverseEncoding) {
		json = [self.destinationEntity buy_JSONForObject:object];
	}
	return json;
}

// JSON -> (ordered)set (of models)
- (id)buy_collectionForJSON:(NSArray *)JSON object:(id<BUYObject>)object
{
	NSString *entityName = self.destinationEntity.name;
	NSArray<id<BUYObject>> *array;
	
	// If we are expecting an array of object `ids`, the objects should already exist.
	// Otherwise, let the object context decide how to resolve the objects and update them.
	// If device caching is not provided, this will return nothing.
	if (self.encodesIdInJSON) {
		array = [object.modelManager buy_objectsWithEntityName:entityName identifiers:JSON];
	}
	else {
		array = [object.modelManager buy_objectsWithEntityName:entityName JSONArray:JSON];
#if !CORE_DATA_PERSISTENCE
		if (self.inverseRelationship && !self.inverseRelationship.isToMany) {
			NSString *inverseKey = self.inverseRelationship.name;
			for (id related in array) {
				[related setValue:object forKey:inverseKey];
			}
		}
#endif
	}
	
	// Transform the array to the correct container type (`NSSet` or `NSOrderedSet`).
	return [self buy_transformArray:array];
}

// (ordered)set (of models) -> JSON
- (NSArray *)buy_JSONForCollection:(id)collection
{
	return [self.destinationEntity buy_JSONForArray:[self buy_arrayForCollection:collection]];
}

#pragma mark - Property Additions Overrides

- (id)buy_valueForJSON:(id)JSON object:(id<BUYObject>)object
{
	// A relationship's value is provided by the object context.
	// The logic for decoding JSON is slightly different for to-one and to-many relationships.
	
	// NOTE: by default, without a caching system, inverse relationships are not supported.
	id value = nil;
	if ([JSON buy_isValidObject]) {
		if (self.isToMany) {
			value = [self buy_collectionForJSON:JSON object:object];
		}
		else {
			value = [self buy_objectForJSON:JSON object:object];
		}
	}
	return value;
}

- (id)buy_JSONForValue:(id)value
{
	// JSON generation for a relationship depends on the rules defined in the model.
	// The model can explicitly specify using an `id` encoding.
	// Alternately, if the relationship is compatible, encode the entire object.
	// We do not encode related objects unless three conditions are satisfied:
	// 1. the relationship is not many-to-many
	// 2. the inverse relationship is not an ownership relationship
	//    (this is inferred from the `NSCascadeDeleteRule` used by owning objects)
	// 3. the relationship is to a "private" entity (not known to the API)
	id json = nil;
	if (self.encodesIdInJSON) {
		json = [value valueForKey:NSStringFromSelector(@selector(identifier))];
	}
	else if (!self.toMany) {
		json = [self buy_JSONForObject:value];
	}
	else if (!self.manyToMany) {
		json = [self buy_JSONForCollection:value];
	}
	return json;
}

#pragma mark - Properties

- (BOOL)buy_encodesIdInJSON
{
	return [self.JSONPropertyKey hasSuffix:[self encodesIdSuffix]];
}

- (BOOL)buy_isManyToMany
{
	return self.toMany && self.inverseRelationship.toMany;
}

- (BOOL)buy_allowsInverseEncoding
{
	return self.deleteRule != NSCascadeDeleteRule && ![self.entity buy_isPrivate];
}

@end

#pragma mark -

@implementation NSFetchedPropertyDescription (BUYAdditions)

- (id)buy_valueForJSON:(id)JSON object:(id<BUYObject>)object
{
	return nil;
}

- (id)buy_JSONForValue:(id)value
{
	return nil;
}

@end

#pragma mark -

@implementation NSObject (BUYValueTransforming)

+ (NSString *)buy_JSONValueTransformerName
{
	return BUYIdentityTransformerName;
}

- (BOOL)buy_isValidObject
{
	return YES;
}

@end

@implementation NSNull (BUYValueTransforming)

- (BOOL)buy_isValidObject
{
	return NO;
}

@end

@implementation NSURL (BUYValueTransforming)

+ (NSString *)buy_JSONValueTransformerName
{
	return BUYURLTransformerName;
}

@end

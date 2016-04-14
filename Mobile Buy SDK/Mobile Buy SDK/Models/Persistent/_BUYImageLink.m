//
//  _BUYImageLink.h
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
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BUYImageLink.m instead.

#import "_BUYImageLink.h"

const struct BUYImageLinkAttributes BUYImageLinkAttributes = {
	.createdAt = @"createdAt",
	.identifier = @"identifier",
	.position = @"position",
	.sourceURL = @"sourceURL",
	.updatedAt = @"updatedAt",
	.variantIds = @"variantIds",
};

const struct BUYImageLinkRelationships BUYImageLinkRelationships = {
	.collection = @"collection",
	.product = @"product",
};

const struct BUYImageLinkUserInfo BUYImageLinkUserInfo = {
	.documentation = @"A link to an image representing a product or collection.",
};

@implementation _BUYImageLink

+ (NSString *)entityName {
	return @"ImageLink";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"positionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"position"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
- (NSDate*)createdAt {
    [self willAccessValueForKey:@"createdAt"];
    id value = [self primitiveValueForKey:@"createdAt"];
    [self didAccessValueForKey:@"createdAt"];
    return value;
}

- (void)setCreatedAt:(NSDate*)value_ {
    [self willChangeValueForKey:@"createdAt"];
    [self setPrimitiveValue:value_ forKey:@"createdAt"];
    [self didChangeValueForKey:@"createdAt"];
}

- (NSNumber*)identifier {
    [self willAccessValueForKey:@"identifier"];
    id value = [self primitiveValueForKey:@"identifier"];
    [self didAccessValueForKey:@"identifier"];
    return value;
}

- (void)setIdentifier:(NSNumber*)value_ {
    [self willChangeValueForKey:@"identifier"];
    [self setPrimitiveValue:value_ forKey:@"identifier"];
    [self didChangeValueForKey:@"identifier"];
}

- (NSNumber*)position {
    [self willAccessValueForKey:@"position"];
    id value = [self primitiveValueForKey:@"position"];
    [self didAccessValueForKey:@"position"];
    return value;
}

- (void)setPosition:(NSNumber*)value_ {
    [self willChangeValueForKey:@"position"];
    [self setPrimitiveValue:value_ forKey:@"position"];
    [self didChangeValueForKey:@"position"];
}

- (NSURL*)sourceURL {
    [self willAccessValueForKey:@"sourceURL"];
    id value = [self primitiveValueForKey:@"sourceURL"];
    [self didAccessValueForKey:@"sourceURL"];
    return value;
}

- (void)setSourceURL:(NSURL*)value_ {
    [self willChangeValueForKey:@"sourceURL"];
    [self setPrimitiveValue:value_ forKey:@"sourceURL"];
    [self didChangeValueForKey:@"sourceURL"];
}

- (NSDate*)updatedAt {
    [self willAccessValueForKey:@"updatedAt"];
    id value = [self primitiveValueForKey:@"updatedAt"];
    [self didAccessValueForKey:@"updatedAt"];
    return value;
}

- (void)setUpdatedAt:(NSDate*)value_ {
    [self willChangeValueForKey:@"updatedAt"];
    [self setPrimitiveValue:value_ forKey:@"updatedAt"];
    [self didChangeValueForKey:@"updatedAt"];
}

- (NSArray*)variantIds {
    [self willAccessValueForKey:@"variantIds"];
    id value = [self primitiveValueForKey:@"variantIds"];
    [self didAccessValueForKey:@"variantIds"];
    return value;
}

- (void)setVariantIds:(NSArray*)value_ {
    [self willChangeValueForKey:@"variantIds"];
    [self setPrimitiveValue:value_ forKey:@"variantIds"];
    [self didChangeValueForKey:@"variantIds"];
}

#endif

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (int32_t)positionValue {
	NSNumber *result = [self position];
	return [result intValue];
}

- (void)setPositionValue:(int32_t)value_ {
	[self setPosition:@(value_)];
}

#if defined CORE_DATA_PERSISTENCE
@dynamic collection;
#endif

#if defined CORE_DATA_PERSISTENCE
@dynamic product;
#endif

@end

#pragma mark -

@implementation BUYModelManager (BUYImageLinkInserting)

- (BUYImageLink *)insertImageLinkWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYImageLink *)[self buy_objectWithEntityName:@"ImageLink" JSONDictionary:dictionary];
}

- (NSArray<BUYImageLink *> *)insertImageLinksWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYImageLink *> *)[self buy_objectsWithEntityName:@"ImageLink" JSONArray:array];
}

- (NSArray<BUYImageLink *> *)allImageLinkObjects
{
	return (NSArray<BUYImageLink *> *)[self buy_objectsWithEntityName:@"ImageLink" identifiers:nil];
}

- (BUYImageLink *)fetchImageLinkWithIdentifierValue:(int64_t)identifier
{
    return (BUYImageLink *)[self buy_objectWithEntityName:@"ImageLink" identifier:@(identifier)];
}

@end

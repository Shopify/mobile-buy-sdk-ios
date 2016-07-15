//
//  NSEntityDescription+BUYAdditions.m
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

#import "BUYAssert.h"
#import "NSEntityDescription+BUYAdditions.h"

#import "BUYModelManagerProtocol.h"
#import "BUYObjectProtocol.h"

#import "NSDictionary+BUYAdditions.h"
#import "NSPropertyDescription+BUYAdditions.h"
#import "NSString+BUYAdditions.h"

@interface NSEntityDescription ()

/**
 * Returns a block that maps JSON keys into a property name.
 * Used when updating model objects from JSON.
 */
@property (nonatomic, readonly, getter=buy_JSONKeyEncodingMap) BUYStringMap JSONKeyEncodingMap;

/**
 * Returns a block that maps property names into JSON keys.
 * Used when generating JSON data from model objects.
 */
@property (nonatomic, readonly, getter=buy_JSONKeyDecodingMap) BUYStringMap JSONKeyDecodingMap;

@end

@implementation NSEntityDescription (BUYAdditions)

#pragma mark - Derived Properties

- (Class)buy_managedObjectClass
{
	return NSClassFromString(self.managedObjectClassName);
}

- (BOOL)buy_isPrivate
{
	return [self.userInfo[@"private"] boolValue];
}

#pragma mark - Property Lookup Conveniences

- (NSDictionary *)buy_JSONEncodedProperties
{
	NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:[self attributesByName]];
	[properties addEntriesFromDictionary:[self relationshipsByName]];
	return properties;
}

- (NSPropertyDescription *)buy_propertyWithName:(NSString *)name
{
	return self.propertiesByName[name];
}

#pragma mark - JSON <-> Property key mapping

// TODO: profile and optimize if necessary

- (BUYStringMap)buy_JSONKeyEncodingMap
{
	NSDictionary *mapping = [self buy_PropertyNameMapping];
	return ^(NSString *name) {
		return mapping[name] ?: [name buy_snakeCaseString];
	};
}

- (BUYStringMap)buy_JSONKeyDecodingMap
{
	NSDictionary *mapping = [self buy_JSONKeyMapping];
	return ^(NSString *key) {
		return mapping[key] ?: [key buy_camelCaseString];
	};
}

#pragma mark - Property lookup

+ (NSDictionary *)buy_defaultPropertyNameMapping
{
	return @{ @"identifier" : @"id" };
}

// json key -> property name
- (NSDictionary *)buy_JSONKeyMapping
{
	return [[self buy_PropertyNameMapping] buy_reverseDictionary];
}

// property name -> json key
- (NSDictionary *)buy_PropertyNameMapping
{
	return [self.propertiesByName buy_dictionaryByMappingValuesWithBlock:^(NSPropertyDescription *property) {
		return [self buy_JSONKeyForPropertyName:property.name];
	}];
}

- (NSString *)buy_JSONKeyForPropertyName:(NSString *)name
{
	return [self buy_propertyWithName:name].JSONPropertyKey ?: [NSEntityDescription buy_defaultPropertyNameMapping][name];
}

#pragma mark - Object-Plist transformation

- (NSDictionary *)buy_JSONForObject:(NSObject<BUYObject> *)object
{
	BUYAssert([self isEqual:[object entity]], @"%@ entity cannot decode %@ objects", self.name, [object entity].name);
	
	// The encoding map is a block which converts property names into JSON keys.
	BUYStringMap encodingMap = self.JSONKeyEncodingMap;
	
	NSMutableDictionary *results = [NSMutableDictionary dictionary];
	[object.JSONEncodedProperties enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSPropertyDescription *property, BOOL *stop) {
		id value = [object valueForKey:propertyName];
		if (value) {
			// Each property is responsible for knowing how to generate JSON for its value
			// Some properties do not encode themselves in JSON, so we mut check for nil
			id JSONValue = [property buy_JSONForValue:value];
			if (JSONValue) {
				NSString *JSONKey = encodingMap(propertyName) ?: propertyName;
				results[JSONKey] = JSONValue;
			}
		}
	}];
	
	return results;
}

- (NSArray *)buy_JSONForArray:(NSArray<NSObject<BUYObject> *> *)array
{
	return [array buy_map:^(NSObject<BUYObject> *object) {
		return [self buy_JSONForObject:object];
	}];
}

- (void)buy_updateObject:(NSObject<BUYObject> *)object withJSON:(NSDictionary *)JSON
{
	BUYAssert([self isEqual:[object entity]], @"%@ entity cannot decode %@ objects", self.name, [object entity].name);
	
	NSDictionary *properties = self.propertiesByName;
	// The decoding map is a block which converts the key in the JSON into a property name.
	BUYStringMap decodingMap = self.JSONKeyDecodingMap;
	
	// Iterate through the JSON, and generate the native value using the property object.
	NSMutableDictionary *results = [NSMutableDictionary dictionary];
	[JSON enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL * stop) {
		NSString *propertyName = decodingMap(key) ?: key;
		NSPropertyDescription *property = properties[propertyName];
		// Each property is responsible for knowing how to parse JSON for its value
		results[propertyName] = [property buy_valueForJSON:value object:object];
	}];
	
	[object setValuesForKeysWithDictionary:results];
}


- (NSString *)JSONIdentifierKey
{
	NSAttributeDescription *attributeDescription = self.attributesByName[@"identifier"];
	return attributeDescription.JSONPropertyKey ?: @"id";
}

@end

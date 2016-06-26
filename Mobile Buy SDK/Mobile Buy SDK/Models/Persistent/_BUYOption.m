//
//  _BUYOption.h
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
// Make changes to BUYOption.m instead.

#import "_BUYOption.h"

const struct BUYOptionAttributes BUYOptionAttributes = {
	.identifier = @"identifier",
	.name = @"name",
	.position = @"position",
};

const struct BUYOptionRelationships BUYOptionRelationships = {
	.product = @"product",
};

const struct BUYOptionUserInfo BUYOptionUserInfo = {
	.documentation = @"The associated product for this option.",
};

@implementation _BUYOption

+ (NSString *)entityName {
	return @"Option";
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
@dynamic identifier;
@dynamic name;
@dynamic position;
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
@dynamic product;
#endif

@end

#pragma mark -

@implementation BUYModelManager (BUYOptionInserting)

- (BUYOption *)insertOptionWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYOption *)[self buy_objectWithEntityName:@"Option" JSONDictionary:dictionary];
}

- (NSArray<BUYOption *> *)insertOptionsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYOption *> *)[self buy_objectsWithEntityName:@"Option" JSONArray:array];
}

- (NSArray<BUYOption *> *)allOptionObjects
{
	return (NSArray<BUYOption *> *)[self buy_objectsWithEntityName:@"Option" identifiers:nil];
}

- (BUYOption *)fetchOptionWithIdentifierValue:(int64_t)identifier
{
    return (BUYOption *)[self buy_objectWithEntityName:@"Option" identifier:@(identifier)];
}

@end

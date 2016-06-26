//
//  _BUYOptionValue.h
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
// Make changes to BUYOptionValue.m instead.

#import "_BUYOptionValue.h"

const struct BUYOptionValueAttributes BUYOptionValueAttributes = {
	.name = @"name",
	.optionId = @"optionId",
	.value = @"value",
};

const struct BUYOptionValueRelationships BUYOptionValueRelationships = {
	.variants = @"variants",
};

@implementation _BUYOptionValue

+ (NSString *)entityName {
	return @"OptionValue";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"optionIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"optionId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic name;
@dynamic optionId;
@dynamic value;
#endif

- (int64_t)optionIdValue {
	NSNumber *result = [self optionId];
	return [result longLongValue];
}

- (void)setOptionIdValue:(int64_t)value_ {
	[self setOptionId:@(value_)];
}

#if defined CORE_DATA_PERSISTENCE
@dynamic variants;
#endif

- (NSMutableSet *)variantsSet {
	[self willAccessValueForKey:@"variants"];

	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"variants"];

	[self didAccessValueForKey:@"variants"];
	return result;
}

@end

#pragma mark -

@implementation BUYModelManager (BUYOptionValueInserting)

- (BUYOptionValue *)insertOptionValueWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYOptionValue *)[self buy_objectWithEntityName:@"OptionValue" JSONDictionary:dictionary];
}

- (NSArray<BUYOptionValue *> *)insertOptionValuesWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYOptionValue *> *)[self buy_objectsWithEntityName:@"OptionValue" JSONArray:array];
}

- (NSArray<BUYOptionValue *> *)allOptionValueObjects
{
	return (NSArray<BUYOptionValue *> *)[self buy_objectsWithEntityName:@"OptionValue" identifiers:nil];
}

- (BUYOptionValue *)fetchOptionValueWithIdentifierValue:(int64_t)identifier
{
    return (BUYOptionValue *)[self buy_objectWithEntityName:@"OptionValue" identifier:@(identifier)];
}

@end

//
//  _BUYDiscount.h
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
// Make changes to BUYDiscount.m instead.

#import "_BUYDiscount.h"

const struct BUYDiscountAttributes BUYDiscountAttributes = {
	.amount = @"amount",
	.applicable = @"applicable",
	.code = @"code",
};

const struct BUYDiscountRelationships BUYDiscountRelationships = {
	.checkout = @"checkout",
};

const struct BUYDiscountUserInfo BUYDiscountUserInfo = {
	.documentation = @"BUYDiscount represents a discount that is applied to the BUYCheckout.",
};

@implementation _BUYDiscount

+ (NSString *)entityName {
	return @"Discount";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"applicableValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"applicable"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

- (BOOL)applicableValue {
	NSNumber *result = [self applicable];
	return [result boolValue];
}

- (void)setApplicableValue:(BOOL)value_ {
	[self setApplicable:@(value_)];
}

@end

#pragma mark -

@implementation BUYModelManager (BUYDiscountInserting)

- (BUYDiscount *)insertDiscountWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYDiscount *)[self buy_objectWithEntityName:@"Discount" JSONDictionary:dictionary];
}

- (NSArray<BUYDiscount *> *)insertDiscountsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYDiscount *> *)[self buy_objectsWithEntityName:@"Discount" JSONArray:array];
}

- (NSArray<BUYDiscount *> *)allDiscountObjects
{
    return (NSArray<BUYDiscount *> *)[self buy_objectsWithEntityName:@"Discount" identifiers:nil];
}

- (BUYDiscount *)fetchDiscountWithIdentifierValue:(int64_t)identifier
{
    return (BUYDiscount *)[self buy_objectWithEntityName:@"Discount" identifier:@(identifier)];
}

@end

//
//  _BUYShippingRate.h
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
// Make changes to BUYShippingRate.m instead.

#import "_BUYShippingRate.h"

const struct BUYShippingRateAttributes BUYShippingRateAttributes = {
	.deliveryRange = @"deliveryRange",
	.price = @"price",
	.shippingRateIdentifier = @"shippingRateIdentifier",
	.title = @"title",
};

const struct BUYShippingRateRelationships BUYShippingRateRelationships = {
	.checkout = @"checkout",
};

const struct BUYShippingRateUserInfo BUYShippingRateUserInfo = {
	.Transient = @"YES",
	.documentation = @"BUYShippingRate represents the amount that the merchant is charging a customer for shipping to the specified address.",
};

@implementation _BUYShippingRate

+ (NSString *)entityName {
	return @"ShippingRate";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@end

#pragma mark -

@implementation BUYModelManager (BUYShippingRateInserting)

- (BUYShippingRate *)insertShippingRateWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYShippingRate *)[self buy_objectWithEntityName:@"ShippingRate" JSONDictionary:dictionary];
}

- (NSArray<BUYShippingRate *> *)insertShippingRatesWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYShippingRate *> *)[self buy_objectsWithEntityName:@"ShippingRate" JSONArray:array];
}

- (NSArray<BUYShippingRate *> *)allShippingRateObjects
{
    return (NSArray<BUYShippingRate *> *)[self buy_objectsWithEntityName:@"ShippingRate" identifiers:nil];
}

- (BUYShippingRate *)fetchShippingRateWithIdentifierValue:(int64_t)identifier
{
    return (BUYShippingRate *)[self buy_objectWithEntityName:@"ShippingRate" identifier:@(identifier)];
}

@end

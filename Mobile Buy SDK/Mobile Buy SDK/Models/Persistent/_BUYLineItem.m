//
//  _BUYLineItem.h
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
// Make changes to BUYLineItem.m instead.

#import "_BUYLineItem.h"

const struct BUYLineItemAttributes BUYLineItemAttributes = {
	.compareAtPrice = @"compareAtPrice",
	.fulfilled = @"fulfilled",
	.fulfillmentService = @"fulfillmentService",
	.grams = @"grams",
	.identifier = @"identifier",
	.linePrice = @"linePrice",
	.price = @"price",
	.productId = @"productId",
	.properties = @"properties",
	.quantity = @"quantity",
	.requiresShipping = @"requiresShipping",
	.sku = @"sku",
	.taxable = @"taxable",
	.title = @"title",
	.variantId = @"variantId",
	.variantTitle = @"variantTitle",
};

const struct BUYLineItemRelationships BUYLineItemRelationships = {
	.checkout = @"checkout",
	.order = @"order",
};

const struct BUYLineItemUserInfo BUYLineItemUserInfo = {
	.documentation = @"This represents a BUYLineItem on a BUYCart or on a BUYCheckout.",
};

@implementation _BUYLineItem

+ (NSString *)entityName {
	return @"LineItem";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"fulfilledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fulfilled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"productIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"productId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"requiresShippingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"requiresShipping"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"taxableValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"taxable"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"variantIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"variantId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic compareAtPrice;
@dynamic fulfilled;
@dynamic fulfillmentService;
@dynamic grams;
@dynamic identifier;
@dynamic linePrice;
@dynamic price;
@dynamic productId;
@dynamic properties;
@dynamic quantity;
@dynamic requiresShipping;
@dynamic sku;
@dynamic taxable;
@dynamic title;
@dynamic variantId;
@dynamic variantTitle;
#endif

- (BOOL)fulfilledValue {
	NSNumber *result = [self fulfilled];
	return [result boolValue];
}

- (void)setFulfilledValue:(BOOL)value_ {
	[self setFulfilled:@(value_)];
}

- (int64_t)productIdValue {
	NSNumber *result = [self productId];
	return [result longLongValue];
}

- (void)setProductIdValue:(int64_t)value_ {
	[self setProductId:@(value_)];
}

- (BOOL)requiresShippingValue {
	NSNumber *result = [self requiresShipping];
	return [result boolValue];
}

- (void)setRequiresShippingValue:(BOOL)value_ {
	[self setRequiresShipping:@(value_)];
}

- (BOOL)taxableValue {
	NSNumber *result = [self taxable];
	return [result boolValue];
}

- (void)setTaxableValue:(BOOL)value_ {
	[self setTaxable:@(value_)];
}

- (int64_t)variantIdValue {
	NSNumber *result = [self variantId];
	return [result longLongValue];
}

- (void)setVariantIdValue:(int64_t)value_ {
	[self setVariantId:@(value_)];
}

#if defined CORE_DATA_PERSISTENCE
@dynamic checkout;
#endif

#if defined CORE_DATA_PERSISTENCE
@dynamic order;
#endif

@end

#pragma mark -

@implementation BUYModelManager (BUYLineItemInserting)

- (BUYLineItem *)insertLineItemWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYLineItem *)[self buy_objectWithEntityName:@"LineItem" JSONDictionary:dictionary];
}

- (NSArray<BUYLineItem *> *)insertLineItemsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYLineItem *> *)[self buy_objectsWithEntityName:@"LineItem" JSONArray:array];
}

- (NSArray<BUYLineItem *> *)allLineItemObjects
{
	return (NSArray<BUYLineItem *> *)[self buy_objectsWithEntityName:@"LineItem" identifiers:nil];
}

- (BUYLineItem *)fetchLineItemWithIdentifierValue:(int64_t)identifier
{
    return (BUYLineItem *)[self buy_objectWithEntityName:@"LineItem" identifier:@(identifier)];
}

@end

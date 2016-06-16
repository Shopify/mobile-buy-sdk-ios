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
- (NSDecimalNumber*)compareAtPrice {
    [self willAccessValueForKey:@"compareAtPrice"];
    id value = [self primitiveValueForKey:@"compareAtPrice"];
    [self didAccessValueForKey:@"compareAtPrice"];
    return value;
}

- (void)setCompareAtPrice:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"compareAtPrice"];
    [self setPrimitiveValue:value_ forKey:@"compareAtPrice"];
    [self didChangeValueForKey:@"compareAtPrice"];
}

- (NSNumber*)fulfilled {
    [self willAccessValueForKey:@"fulfilled"];
    id value = [self primitiveValueForKey:@"fulfilled"];
    [self didAccessValueForKey:@"fulfilled"];
    return value;
}

- (void)setFulfilled:(NSNumber*)value_ {
    [self willChangeValueForKey:@"fulfilled"];
    [self setPrimitiveValue:value_ forKey:@"fulfilled"];
    [self didChangeValueForKey:@"fulfilled"];
}

- (NSString*)fulfillmentService {
    [self willAccessValueForKey:@"fulfillmentService"];
    id value = [self primitiveValueForKey:@"fulfillmentService"];
    [self didAccessValueForKey:@"fulfillmentService"];
    return value;
}

- (void)setFulfillmentService:(NSString*)value_ {
    [self willChangeValueForKey:@"fulfillmentService"];
    [self setPrimitiveValue:value_ forKey:@"fulfillmentService"];
    [self didChangeValueForKey:@"fulfillmentService"];
}

- (NSDecimalNumber*)grams {
    [self willAccessValueForKey:@"grams"];
    id value = [self primitiveValueForKey:@"grams"];
    [self didAccessValueForKey:@"grams"];
    return value;
}

- (void)setGrams:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"grams"];
    [self setPrimitiveValue:value_ forKey:@"grams"];
    [self didChangeValueForKey:@"grams"];
}

- (NSString*)identifier {
    [self willAccessValueForKey:@"identifier"];
    id value = [self primitiveValueForKey:@"identifier"];
    [self didAccessValueForKey:@"identifier"];
    return value;
}

- (void)setIdentifier:(NSString*)value_ {
    [self willChangeValueForKey:@"identifier"];
    [self setPrimitiveValue:value_ forKey:@"identifier"];
    [self didChangeValueForKey:@"identifier"];
}

- (NSDecimalNumber*)linePrice {
    [self willAccessValueForKey:@"linePrice"];
    id value = [self primitiveValueForKey:@"linePrice"];
    [self didAccessValueForKey:@"linePrice"];
    return value;
}

- (void)setLinePrice:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"linePrice"];
    [self setPrimitiveValue:value_ forKey:@"linePrice"];
    [self didChangeValueForKey:@"linePrice"];
}

- (NSDecimalNumber*)price {
    [self willAccessValueForKey:@"price"];
    id value = [self primitiveValueForKey:@"price"];
    [self didAccessValueForKey:@"price"];
    return value;
}

- (void)setPrice:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"price"];
    [self setPrimitiveValue:value_ forKey:@"price"];
    [self didChangeValueForKey:@"price"];
}

- (NSNumber*)productId {
    [self willAccessValueForKey:@"productId"];
    id value = [self primitiveValueForKey:@"productId"];
    [self didAccessValueForKey:@"productId"];
    return value;
}

- (void)setProductId:(NSNumber*)value_ {
    [self willChangeValueForKey:@"productId"];
    [self setPrimitiveValue:value_ forKey:@"productId"];
    [self didChangeValueForKey:@"productId"];
}

- (NSDictionary*)properties {
    [self willAccessValueForKey:@"properties"];
    id value = [self primitiveValueForKey:@"properties"];
    [self didAccessValueForKey:@"properties"];
    return value;
}

- (void)setProperties:(NSDictionary*)value_ {
    [self willChangeValueForKey:@"properties"];
    [self setPrimitiveValue:value_ forKey:@"properties"];
    [self didChangeValueForKey:@"properties"];
}

- (NSDecimalNumber*)quantity {
    [self willAccessValueForKey:@"quantity"];
    id value = [self primitiveValueForKey:@"quantity"];
    [self didAccessValueForKey:@"quantity"];
    return value;
}

- (void)setQuantity:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"quantity"];
    [self setPrimitiveValue:value_ forKey:@"quantity"];
    [self didChangeValueForKey:@"quantity"];
}

- (NSNumber*)requiresShipping {
    [self willAccessValueForKey:@"requiresShipping"];
    id value = [self primitiveValueForKey:@"requiresShipping"];
    [self didAccessValueForKey:@"requiresShipping"];
    return value;
}

- (void)setRequiresShipping:(NSNumber*)value_ {
    [self willChangeValueForKey:@"requiresShipping"];
    [self setPrimitiveValue:value_ forKey:@"requiresShipping"];
    [self didChangeValueForKey:@"requiresShipping"];
}

- (NSString*)sku {
    [self willAccessValueForKey:@"sku"];
    id value = [self primitiveValueForKey:@"sku"];
    [self didAccessValueForKey:@"sku"];
    return value;
}

- (void)setSku:(NSString*)value_ {
    [self willChangeValueForKey:@"sku"];
    [self setPrimitiveValue:value_ forKey:@"sku"];
    [self didChangeValueForKey:@"sku"];
}

- (NSNumber*)taxable {
    [self willAccessValueForKey:@"taxable"];
    id value = [self primitiveValueForKey:@"taxable"];
    [self didAccessValueForKey:@"taxable"];
    return value;
}

- (void)setTaxable:(NSNumber*)value_ {
    [self willChangeValueForKey:@"taxable"];
    [self setPrimitiveValue:value_ forKey:@"taxable"];
    [self didChangeValueForKey:@"taxable"];
}

- (NSString*)title {
    [self willAccessValueForKey:@"title"];
    id value = [self primitiveValueForKey:@"title"];
    [self didAccessValueForKey:@"title"];
    return value;
}

- (void)setTitle:(NSString*)value_ {
    [self willChangeValueForKey:@"title"];
    [self setPrimitiveValue:value_ forKey:@"title"];
    [self didChangeValueForKey:@"title"];
}

- (NSNumber*)variantId {
    [self willAccessValueForKey:@"variantId"];
    id value = [self primitiveValueForKey:@"variantId"];
    [self didAccessValueForKey:@"variantId"];
    return value;
}

- (void)setVariantId:(NSNumber*)value_ {
    [self willChangeValueForKey:@"variantId"];
    [self setPrimitiveValue:value_ forKey:@"variantId"];
    [self didChangeValueForKey:@"variantId"];
}

- (NSString*)variantTitle {
    [self willAccessValueForKey:@"variantTitle"];
    id value = [self primitiveValueForKey:@"variantTitle"];
    [self didAccessValueForKey:@"variantTitle"];
    return value;
}

- (void)setVariantTitle:(NSString*)value_ {
    [self willChangeValueForKey:@"variantTitle"];
    [self setPrimitiveValue:value_ forKey:@"variantTitle"];
    [self didChangeValueForKey:@"variantTitle"];
}

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

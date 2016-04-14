//
//  _BUYProductVariant.h
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
// Make changes to BUYProductVariant.m instead.

#import "_BUYProductVariant.h"

const struct BUYProductVariantAttributes BUYProductVariantAttributes = {
	.available = @"available",
	.compareAtPrice = @"compareAtPrice",
	.grams = @"grams",
	.identifier = @"identifier",
	.position = @"position",
	.price = @"price",
	.requiresShipping = @"requiresShipping",
	.sku = @"sku",
	.taxable = @"taxable",
	.title = @"title",
};

const struct BUYProductVariantRelationships BUYProductVariantRelationships = {
	.cartLineItems = @"cartLineItems",
	.options = @"options",
	.product = @"product",
};

const struct BUYProductVariantUserInfo BUYProductVariantUserInfo = {
	.documentation = @"A BUYProductVariant is a different version of a product, such as differing sizes or differing colours.",
};

@implementation _BUYProductVariant

+ (NSString *)entityName {
	return @"ProductVariant";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"availableValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"available"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
- (NSNumber*)available {
    [self willAccessValueForKey:@"available"];
    id value = [self primitiveValueForKey:@"available"];
    [self didAccessValueForKey:@"available"];
    return value;
}

- (void)setAvailable:(NSNumber*)value_ {
    [self willChangeValueForKey:@"available"];
    [self setPrimitiveValue:value_ forKey:@"available"];
    [self didChangeValueForKey:@"available"];
}

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

#endif

- (BOOL)availableValue {
	NSNumber *result = [self available];
	return [result boolValue];
}

- (void)setAvailableValue:(BOOL)value_ {
	[self setAvailable:@(value_)];
}

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

#if defined CORE_DATA_PERSISTENCE
@dynamic cartLineItems;
#endif

- (NSMutableSet *)cartLineItemsSet {
	[self willAccessValueForKey:@"cartLineItems"];

	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"cartLineItems"];

	[self didAccessValueForKey:@"cartLineItems"];
	return result;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic options;
#endif

- (NSMutableSet *)optionsSet {
	[self willAccessValueForKey:@"options"];

	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"options"];

	[self didAccessValueForKey:@"options"];
	return result;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic product;
#endif

@end

#pragma mark -

@implementation BUYModelManager (BUYProductVariantInserting)

- (BUYProductVariant *)insertProductVariantWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYProductVariant *)[self buy_objectWithEntityName:@"ProductVariant" JSONDictionary:dictionary];
}

- (NSArray<BUYProductVariant *> *)insertProductVariantsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYProductVariant *> *)[self buy_objectsWithEntityName:@"ProductVariant" JSONArray:array];
}

- (NSArray<BUYProductVariant *> *)allProductVariantObjects
{
	return (NSArray<BUYProductVariant *> *)[self buy_objectsWithEntityName:@"ProductVariant" identifiers:nil];
}

- (BUYProductVariant *)fetchProductVariantWithIdentifierValue:(int64_t)identifier
{
    return (BUYProductVariant *)[self buy_objectWithEntityName:@"ProductVariant" identifier:@(identifier)];
}

@end

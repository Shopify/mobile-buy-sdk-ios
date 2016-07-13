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
@dynamic available;
@dynamic compareAtPrice;
@dynamic grams;
@dynamic identifier;
@dynamic position;
@dynamic price;
@dynamic requiresShipping;
@dynamic sku;
@dynamic taxable;
@dynamic title;
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

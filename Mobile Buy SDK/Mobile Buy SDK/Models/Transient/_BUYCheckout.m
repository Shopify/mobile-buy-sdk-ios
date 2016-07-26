//
//  _BUYCheckout.h
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
// Make changes to BUYCheckout.m instead.

#import "_BUYCheckout.h"

const struct BUYCheckoutAttributes BUYCheckoutAttributes = {
	.cartToken = @"cartToken",
	.channelId = @"channelId",
	.createdAt = @"createdAt",
	.currency = @"currency",
	.customerId = @"customerId",
	.email = @"email",
	.includesTaxes = @"includesTaxes",
	.marketingAttribution = @"marketingAttribution",
	.note = @"note",
	.partialAddresses = @"partialAddresses",
	.paymentDue = @"paymentDue",
	.paymentURL = @"paymentURL",
	.privacyPolicyURL = @"privacyPolicyURL",
	.refundPolicyURL = @"refundPolicyURL",
	.requiresShipping = @"requiresShipping",
	.reservationTime = @"reservationTime",
	.reservationTimeLeft = @"reservationTimeLeft",
	.shippingRateId = @"shippingRateId",
	.sourceIdentifier = @"sourceIdentifier",
	.sourceName = @"sourceName",
	.subtotalPrice = @"subtotalPrice",
	.termsOfServiceURL = @"termsOfServiceURL",
	.token = @"token",
	.totalPrice = @"totalPrice",
	.totalTax = @"totalTax",
	.updatedAt = @"updatedAt",
	.webCheckoutURL = @"webCheckoutURL",
	.webReturnToLabel = @"webReturnToLabel",
	.webReturnToURL = @"webReturnToURL",
};

const struct BUYCheckoutRelationships BUYCheckoutRelationships = {
	.attributes = @"attributes",
	.billingAddress = @"billingAddress",
	.creditCard = @"creditCard",
	.discount = @"discount",
	.giftCards = @"giftCards",
	.lineItems = @"lineItems",
	.order = @"order",
	.shippingAddress = @"shippingAddress",
	.shippingRate = @"shippingRate",
	.taxLines = @"taxLines",
};

const struct BUYCheckoutUserInfo BUYCheckoutUserInfo = {
	.discussion = @"Do not create a BUYCheckout object directly. Use initWithCart: to transform a BUYCart into a BUYCheckout.",
	.documentation = @"The checkout object. This is the main object that you will interact with when creating orders on Shopify.",
};

@implementation _BUYCheckout

+ (NSString *)entityName {
	return @"Checkout";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"customerIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"customerId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"includesTaxesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"includesTaxes"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"partialAddressesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"partialAddresses"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"requiresShippingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"requiresShipping"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"reservationTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reservationTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"reservationTimeLeftValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reservationTimeLeft"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

- (int64_t)customerIdValue {
	NSNumber *result = [self customerId];
	return [result longLongValue];
}

- (void)setCustomerIdValue:(int64_t)value_ {
	[self setCustomerId:@(value_)];
}

- (BOOL)includesTaxesValue {
	NSNumber *result = [self includesTaxes];
	return [result boolValue];
}

- (void)setIncludesTaxesValue:(BOOL)value_ {
	[self setIncludesTaxes:@(value_)];
}

- (BOOL)partialAddressesValue {
	NSNumber *result = [self partialAddresses];
	return [result boolValue];
}

- (void)setPartialAddressesValue:(BOOL)value_ {
	[self setPartialAddresses:@(value_)];
}

- (BOOL)requiresShippingValue {
	NSNumber *result = [self requiresShipping];
	return [result boolValue];
}

- (void)setRequiresShippingValue:(BOOL)value_ {
	[self setRequiresShipping:@(value_)];
}

- (int32_t)reservationTimeValue {
	NSNumber *result = [self reservationTime];
	return [result intValue];
}

- (void)setReservationTimeValue:(int32_t)value_ {
	[self setReservationTime:@(value_)];
}

- (int64_t)reservationTimeLeftValue {
	NSNumber *result = [self reservationTimeLeft];
	return [result longLongValue];
}

- (void)setReservationTimeLeftValue:(int64_t)value_ {
	[self setReservationTimeLeft:@(value_)];
}

- (NSMutableSet*)attributesSet {

	return (NSMutableSet*)[self mutableSetValueForKey:@"attributes"];

}

- (NSMutableOrderedSet*)giftCardsSet {

	return (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"giftCards"];

}

- (NSMutableOrderedSet*)lineItemsSet {

	return (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"lineItems"];

}

- (NSMutableSet*)taxLinesSet {

	return (NSMutableSet*)[self mutableSetValueForKey:@"taxLines"];

}

@end

@implementation _BUYCheckout (GiftCardsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYGiftCard*)value inGiftCardsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"giftCards"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self giftCards]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setValue:tmpOrderedSet forKey:@"giftCards"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"giftCards"];
}
- (void)removeObjectFromGiftCardsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"giftCards"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self giftCards]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setValue:tmpOrderedSet forKey:@"giftCards"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"giftCards"];
}
- (void)insertGiftCards:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"giftCards"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self giftCards]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setValue:tmpOrderedSet forKey:@"giftCards"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"giftCards"];
}
- (void)removeGiftCardsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"giftCards"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self giftCards]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setValue:tmpOrderedSet forKey:@"giftCards"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"giftCards"];
}
- (void)replaceObjectInGiftCardsAtIndex:(NSUInteger)idx withObject:(BUYGiftCard*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"giftCards"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self giftCards]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setValue:tmpOrderedSet forKey:@"giftCards"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"giftCards"];
}
- (void)replaceGiftCardsAtIndexes:(NSIndexSet *)indexes withGiftCards:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"giftCards"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self giftCards]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setValue:tmpOrderedSet forKey:@"giftCards"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"giftCards"];
}
@end

@implementation _BUYCheckout (LineItemsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYLineItem*)value inLineItemsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lineItems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lineItems]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setValue:tmpOrderedSet forKey:@"lineItems"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lineItems"];
}
- (void)removeObjectFromLineItemsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lineItems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lineItems]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setValue:tmpOrderedSet forKey:@"lineItems"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lineItems"];
}
- (void)insertLineItems:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lineItems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lineItems]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setValue:tmpOrderedSet forKey:@"lineItems"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"lineItems"];
}
- (void)removeLineItemsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lineItems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lineItems]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setValue:tmpOrderedSet forKey:@"lineItems"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"lineItems"];
}
- (void)replaceObjectInLineItemsAtIndex:(NSUInteger)idx withObject:(BUYLineItem*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lineItems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lineItems]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setValue:tmpOrderedSet forKey:@"lineItems"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lineItems"];
}
- (void)replaceLineItemsAtIndexes:(NSIndexSet *)indexes withLineItems:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lineItems"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self lineItems]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setValue:tmpOrderedSet forKey:@"lineItems"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"lineItems"];
}
@end

#pragma mark -

@implementation BUYModelManager (BUYCheckoutInserting)

- (BUYCheckout *)insertCheckoutWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYCheckout *)[self buy_objectWithEntityName:@"Checkout" JSONDictionary:dictionary];
}

- (NSArray<BUYCheckout *> *)insertCheckoutsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYCheckout *> *)[self buy_objectsWithEntityName:@"Checkout" JSONArray:array];
}

- (NSArray<BUYCheckout *> *)allCheckoutObjects
{
    return (NSArray<BUYCheckout *> *)[self buy_objectsWithEntityName:@"Checkout" identifiers:nil];
}

- (BUYCheckout *)fetchCheckoutWithIdentifierValue:(int64_t)identifier
{
    return (BUYCheckout *)[self buy_objectWithEntityName:@"Checkout" identifier:@(identifier)];
}

@end

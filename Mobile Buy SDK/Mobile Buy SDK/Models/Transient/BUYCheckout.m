//
//  _BUYCheckout.m
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

#import "BUYCheckout.h"

#import "BUYAddress.h"
#import "BUYCart.h"
#import "BUYCheckoutAttribute.h"
#import "BUYGiftCard.h"
#import "BUYLineItem.h"
#import "BUYShippingRate.h"

#import "NSArray+BUYAdditions.h"
#import "NSEntityDescription+BUYAdditions.h"

@implementation BUYCheckout

+ (NSSet *)keyPathsForValuesAffectingAttributesDictionary
{
	return [NSSet setWithObject:BUYCheckoutRelationships.attributes];
}

- (NSDictionary *)attributesDictionary
{
	NSArray *attributesArray = [self.attributes allObjects];
	NSArray *objects = [attributesArray valueForKey:BUYCheckoutAttributeAttributes.value];
	NSArray *keys = [attributesArray valueForKey:BUYCheckoutAttributeAttributes.name];
	return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

+ (BOOL)tracksDirtyProperties
{
	return YES;
}

- (BOOL)hasToken
{
	return [self.token length] > 0;
}

- (void)setShippingRate:(BUYShippingRate *)shippingRate
{
	[super setShippingRate:shippingRate];
	self.shippingRateId = shippingRate.shippingRateIdentifier;
}

- (void)setPartialAddresses:(NSNumber *)partialAddresses
{
	if (partialAddresses.boolValue == NO) {
		@throw [NSException exceptionWithName:@"partialAddress" reason:@"partialAddresses can only be set to true and should never be set to false on a complete address" userInfo:nil];
	}
	[ super setPartialAddresses:partialAddresses];
}

#pragma mark - Init -

/**
 * We must initialize to-many relationships to ensure that
 * -mutableSetValueForKey: works properly. e.g. -giftCardsSet
 */
#if !defined CORE_DATA_PERSISTENCE
- (instancetype)init
{
	self = [super init];
	if (self) {
		self.attributes = [NSSet set];
		self.giftCards = [NSOrderedSet orderedSet];
		self.lineItems = [NSOrderedSet orderedSet];
		self.taxLines = [NSSet set];
		[self markAsClean];
	}
	return self;
}
#endif

- (instancetype)initWithModelManager:(id<BUYModelManager>)modelManager cart:(BUYCart *)cart
{
	self = [self initWithModelManager:modelManager JSONDictionary:nil];
	if (self) {
		[self updateWithCart:cart];
	}
	return self;
}

- (instancetype)initWithModelManager:(id<BUYModelManager>)modelManager cartToken:(NSString *)token
{
	self = [self initWithModelManager:modelManager JSONDictionary:nil];
	if (self) {
		self.cartToken = token;
	}
	return self;
}

#pragma mark - Accessors -

- (NSArray<BUYGiftCard *> *)giftCardsArray
{
	return self.giftCards.array ?: @[];
}

- (NSArray<BUYCartLineItem *> *)lineItemsArray
{
	return self.lineItems.array ?: @[];
}

#pragma mark - Update -

- (void)updateWithCart:(BUYCart *)cart
{
	NSArray *lineItems = [[cart.lineItems array] buy_map:^id(BUYCartLineItem *cartLineItem) {
		BUYLineItem *lineItem = [self.modelManager buy_objectWithEntityName:[BUYLineItem entityName] JSONDictionary:nil];
		[lineItem updateWithLineItem:cartLineItem];
		return lineItem;
	}];
	self.lineItems = [NSOrderedSet orderedSetWithArray:lineItems];
}

#pragma mark - BUYObject -

- (NSDictionary *)JSONEncodedProperties
{
	//We only need the dirty properties
	return [[super JSONEncodedProperties] dictionaryWithValuesForKeys:[self.dirtyProperties allObjects]];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [self.JSONDictionary mutableCopy];
	if (self.attributes.count > 0) {
		json[@"attributes"] = self.attributesDictionary;
	}
	return @{ @"checkout" : json };
}

#pragma mark - Gift Card management -

- (BUYGiftCard *)giftCardWithIdentifier:(NSNumber *)identifier
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
	return [[self.giftCards filteredOrderedSetUsingPredicate:predicate] firstObject];
}

- (void)addGiftCard:(BUYGiftCard *)giftCard
{
	[self.giftCardsSet addObject:giftCard];
}

- (void)removeGiftCardWithIdentifier:(NSNumber *)identifier
{
	BUYGiftCard *giftCard = [self giftCardWithIdentifier:identifier];
	if (giftCard) {
		[self.giftCardsSet removeObject:giftCard];
	}
}

@end

@implementation BUYModelManager (BUYCheckoutCreating)

- (BUYCheckout *)checkout
{
	return [self checkoutWithCart:[self insertCartWithJSONDictionary:nil]];
}

- (BUYCheckout *)checkoutWithCart:(BUYCart *)cart
{
	BUYCheckout *checkout = [self insertCheckoutWithJSONDictionary:nil];
	[checkout updateWithCart:cart];
	return checkout;
}

- (BUYCheckout *)checkoutWithVariant:(BUYProductVariant *)productVariant
{
	BUYCheckout *checkout = [self insertCheckoutWithJSONDictionary:nil];
	
	BUYLineItem *lineItem = [self lineItemWithVariant:productVariant];
	checkout.lineItems = [NSOrderedSet orderedSetWithObject:lineItem];
	
	return checkout;
}

- (BUYCheckout *)checkoutwithCartToken:(NSString *)token
{
	BUYCheckout *checkout = [self insertCheckoutWithJSONDictionary:nil];
	checkout.cartToken = token;
	return checkout;
}

@end

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
// Make changes to BUYCheckout.h instead.

#import <Buy/BUYObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYCheckoutAttributes {
	__unsafe_unretained NSString *cartToken;
	__unsafe_unretained NSString *channelId;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *currency;
	__unsafe_unretained NSString *customerId;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *includesTaxes;
	__unsafe_unretained NSString *marketingAttribution;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *partialAddresses;
	__unsafe_unretained NSString *paymentDue;
	__unsafe_unretained NSString *paymentURL;
	__unsafe_unretained NSString *privacyPolicyURL;
	__unsafe_unretained NSString *refundPolicyURL;
	__unsafe_unretained NSString *requiresShipping;
	__unsafe_unretained NSString *reservationTime;
	__unsafe_unretained NSString *reservationTimeLeft;
	__unsafe_unretained NSString *shippingRateId;
	__unsafe_unretained NSString *sourceIdentifier;
	__unsafe_unretained NSString *sourceName;
	__unsafe_unretained NSString *subtotalPrice;
	__unsafe_unretained NSString *termsOfServiceURL;
	__unsafe_unretained NSString *token;
	__unsafe_unretained NSString *totalPrice;
	__unsafe_unretained NSString *totalTax;
	__unsafe_unretained NSString *updatedAt;
	__unsafe_unretained NSString *webCheckoutURL;
	__unsafe_unretained NSString *webReturnToLabel;
	__unsafe_unretained NSString *webReturnToURL;
} BUYCheckoutAttributes;

extern const struct BUYCheckoutRelationships {
	__unsafe_unretained NSString *attributes;
	__unsafe_unretained NSString *billingAddress;
	__unsafe_unretained NSString *creditCard;
	__unsafe_unretained NSString *discount;
	__unsafe_unretained NSString *giftCards;
	__unsafe_unretained NSString *lineItems;
	__unsafe_unretained NSString *order;
	__unsafe_unretained NSString *shippingAddress;
	__unsafe_unretained NSString *shippingRate;
	__unsafe_unretained NSString *taxLines;
} BUYCheckoutRelationships;

extern const struct BUYCheckoutUserInfo {
	__unsafe_unretained NSString *discussion;
	__unsafe_unretained NSString *documentation;
} BUYCheckoutUserInfo;

@class BUYCheckoutAttribute;
@class BUYAddress;
@class BUYMaskedCreditCard;
@class BUYDiscount;
@class BUYGiftCard;
@class BUYLineItem;
@class BUYOrder;
@class BUYAddress;
@class BUYShippingRate;
@class BUYTaxLine;

@class NSDictionary;

@class NSURL;

@class NSURL;

@class NSURL;

@class NSURL;

@class NSURL;

@class NSURL;

@class BUYCheckout;
@interface BUYModelManager (BUYCheckoutInserting)
- (NSArray<BUYCheckout *> *)allCheckoutObjects;
- (BUYCheckout *)fetchCheckoutWithIdentifierValue:(int64_t)identifier;
- (BUYCheckout *)insertCheckoutWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYCheckout *> *)insertCheckoutsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * The checkout object. This is the main object that you will interact with when creating orders on Shopify.
 *
 * Do not create a BUYCheckout object directly. Use initWithCart: to transform a BUYCart into a BUYCheckout.
 */
@interface _BUYCheckout : BUYObject

+ (NSString *)entityName;

/**
 * Unique token for a cart which can be used to convert to a checkout
 */
@property (nonatomic, strong) NSString* cartToken;

/**
 * Channel ID where the checkout was created.
 */
@property (nonatomic, strong) NSString* channelId;

@property (nonatomic, strong) NSDate* createdAt;

/**
 * The three letter code (ISO 4217) for the currency used for the payment.
 */
@property (nonatomic, strong) NSString* currency;

/**
 * Customer ID associated with the checkout.
 */
@property (nonatomic, strong) NSNumber* customerId;

@property (atomic) int64_t customerIdValue;
- (int64_t)customerIdValue;
- (void)setCustomerIdValue:(int64_t)value_;

/**
 * The customer's email address.
 */
@property (nonatomic, strong) NSString* email;

/**
 * States whether or not the taxes are included in the price.
 *
 * Maps to "taxes_included" in JSON.
 */
@property (nonatomic, strong) NSNumber* includesTaxes;

@property (atomic) BOOL includesTaxesValue;
- (BOOL)includesTaxesValue;
- (void)setIncludesTaxesValue:(BOOL)value_;

/**
 * Attributions for the checkout.
 *
 * Contains the application name and platform (defaults to applicationName set on the BUYClient, and "iOS" respectively.
 */
@property (nonatomic, strong) NSDictionary* marketingAttribution;

/**
 * An optional note attached to the order.
 */
@property (nonatomic, strong) NSString* note;

/**
 * Informs server that the shipping address is partially filled with address info provided by PKPaymentAuthorizationViewController. Should only ever be YES. Setting to NO will throw an exception.
 *
 * Suitable to retrieve shipping rates.
 */
@property (nonatomic, strong) NSNumber* partialAddresses;

@property (atomic) BOOL partialAddressesValue;
- (BOOL)partialAddressesValue;
- (void)setPartialAddressesValue:(BOOL)value_;

/**
 * Amount of payment due on the checkout.
 */
@property (nonatomic, strong) NSDecimalNumber* paymentDue;

/**
 * URL to the payment gateway.
 */
@property (nonatomic, strong) NSURL* paymentURL;

/**
 * The website URL for the privacy policy for the checkout.
 */
@property (nonatomic, strong) NSURL* privacyPolicyURL;

/**
 * The website URL for the refund policy for the checkout.
 */
@property (nonatomic, strong) NSURL* refundPolicyURL;

/**
 * States whether or not the fulfillment requires shipping
 */
@property (nonatomic, strong) NSNumber* requiresShipping;

@property (atomic) BOOL requiresShippingValue;
- (BOOL)requiresShippingValue;
- (void)setRequiresShippingValue:(BOOL)value_;

/**
 * Reservation time on the checkout in seconds.
 *
 * Setting to zero and updating the checkout will release inventory reserved by the checkout (when product inventory is not infinite). 300 seconds is default and maximum. `reservationTime` is reset to @300 on every `updateCheckout:completion:` call. This can also be done with  `removeProductReservationsFromCheckout:completion` found in the BUYClient.
 */
@property (nonatomic, strong) NSNumber* reservationTime;

@property (atomic) int32_t reservationTimeValue;
- (int32_t)reservationTimeValue;
- (void)setReservationTimeValue:(int32_t)value_;

/**
 * Reservation time remaining on the checkout in seconds.
 */
@property (nonatomic, strong) NSNumber* reservationTimeLeft;

@property (atomic) int64_t reservationTimeLeftValue;
- (int64_t)reservationTimeLeftValue;
- (void)setReservationTimeLeftValue:(int64_t)value_;

@property (nonatomic, strong) NSString* shippingRateId;

/**
 * The unique identifier for the source: the channelId.
 */
@property (nonatomic, strong) NSString* sourceIdentifier;

/**
 * The name of the source of the checkout: "mobile_app".
 */
@property (nonatomic, strong) NSString* sourceName;

/**
 * Price of the order before shipping and taxes.
 */
@property (nonatomic, strong) NSDecimalNumber* subtotalPrice;

/**
 * The website URL for the terms of service for the checkout.
 */
@property (nonatomic, strong) NSURL* termsOfServiceURL;

/**
 * Unique token for the checkout on Shopify.
 */
@property (nonatomic, strong) NSString* token;

/**
 * The sum of all the prices of all the items in the order, taxes and discounts included.
 */
@property (nonatomic, strong) NSDecimalNumber* totalPrice;

/**
 * The sum of all the taxes applied to the line items in the order.
 */
@property (nonatomic, strong) NSDecimalNumber* totalTax;

@property (nonatomic, strong) NSDate* updatedAt;

/**
 * URL which is used for completing checkout.
 *
 * It is recommended to open the URL in Safari to take advantage of its autocompletion and credit card capture capabilities.
 */
@property (nonatomic, strong) NSURL* webCheckoutURL;

/**
 * The button title that will appear after checkout to return to the host app.
 *
 * Defaults to "Return to 'application'", where 'application' is the `applicationName` set on the BUYClient.
 */
@property (nonatomic, strong) NSString* webReturnToLabel;

/**
 * The URL Scheme of the host app.
 *
 * Used to return to the app from the web checkout.
 */
@property (nonatomic, strong) NSURL* webReturnToURL;

@property (nonatomic, strong) NSSet *attributes;

- (NSMutableSet*)attributesSet;

@property (nonatomic, strong) BUYAddress *billingAddress;

/**
 * Credit card stored on the checkout.
 */
@property (nonatomic, strong) BUYMaskedCreditCard *creditCard;

/**
 * A discount added to the checkout.
 *
 * Only one discount can be added to a checkout. Call `updateCheckout:completion:` after adding a discount to apply the discount code to the checkout.
 */
@property (nonatomic, strong) BUYDiscount *discount;

/**
 * An array of BUYGiftCard objects applied to the checkout.
 */
@property (nonatomic, strong) NSOrderedSet *giftCards;

- (NSMutableOrderedSet*)giftCardsSet;

/**
 * Array of BUYLineItem objects in the checkout.
 *
 * These are different from BUYCartLineItems in that the line item objects do not include the BUYProductVariant.
 */
@property (nonatomic, strong) NSOrderedSet *lineItems;

- (NSMutableOrderedSet*)lineItemsSet;

/**
 * The BUYOrder for a completed checkout.
 */
@property (nonatomic, strong) BUYOrder *order;

@property (nonatomic, strong) BUYAddress *shippingAddress;

/**
 * The shipping rate chosen for the checkout.
 */
@property (nonatomic, strong) BUYShippingRate *shippingRate;

/**
 * Array of tax line objects on the checkout.
 */
@property (nonatomic, strong) NSSet *taxLines;

- (NSMutableSet*)taxLinesSet;

@end

@interface _BUYCheckout (AttributesCoreDataGeneratedAccessors)

@end

@interface _BUYCheckout (GiftCardsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYGiftCard*)value inGiftCardsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGiftCardsAtIndex:(NSUInteger)idx;
- (void)insertGiftCards:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGiftCardsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGiftCardsAtIndex:(NSUInteger)idx withObject:(BUYGiftCard*)value;
- (void)replaceGiftCardsAtIndexes:(NSIndexSet *)indexes withGiftCards:(NSArray *)values;

@end

@interface _BUYCheckout (LineItemsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYLineItem*)value inLineItemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLineItemsAtIndex:(NSUInteger)idx;
- (void)insertLineItems:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLineItemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLineItemsAtIndex:(NSUInteger)idx withObject:(BUYLineItem*)value;
- (void)replaceLineItemsAtIndexes:(NSIndexSet *)indexes withLineItems:(NSArray *)values;

@end

@interface _BUYCheckout (TaxLinesCoreDataGeneratedAccessors)

@end


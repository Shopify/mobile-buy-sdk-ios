//
//  CHKCheckout.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"
#import "CHKSerializable.h"

@class CHKCreditCard;
@class CHKAddress;
@class CHKShippingRate;
@class CHKCart;
@class CHKDiscount;

/**
 *  The checkout object. This is the main object that you will interact with when creating orders on Shopify.
 *  
 *  Note: Do not create a CHKCheckout object directly. Use initWithCart: to transform a CHKCart into a CHKCheckout.
 */
@interface CHKCheckout : CHKObject <CHKSerializable>

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSNumber *orderId;
@property (nonatomic, assign) BOOL requiresShipping;
@property (nonatomic, assign) BOOL taxesIncluded;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, strong) NSDecimalNumber *subtotalPrice;
@property (nonatomic, strong) NSDecimalNumber *totalTax;
@property (nonatomic, strong) NSDecimalNumber *totalPrice;

@property (nonatomic, strong) NSString *paymentSessionId;
@property (nonatomic, strong) NSURL *paymentURL;
@property (nonatomic, strong) NSNumber *reservationTime;
@property (nonatomic, strong) NSNumber *reservationTimeLeft;
@property (nonatomic, strong) NSDecimalNumber *paymentDue;

@property (nonatomic, readonly, copy) NSArray *lineItems;
@property (nonatomic, readonly, copy) NSArray *taxLines;

@property (nonatomic, strong) CHKAddress *billingAddress;
@property (nonatomic, strong) CHKAddress *shippingAddress;

@property (nonatomic, strong) CHKShippingRate *shippingRate;
@property (nonatomic, readonly) NSString *shippingRateId;

@property (nonatomic, strong) CHKDiscount *discount;
@property (nonatomic, strong) NSURL *orderStatusURL;
@property (nonatomic, strong) NSString *channel;

- (instancetype)initWithCart:(CHKCart *)cart NS_DESIGNATED_INITIALIZER;
- (BOOL)hasToken;

@end

/**
 * CHKTaxLine represents a single tax line on a checkout. Use this to display an itemized list of taxes that a customer is being charged for.
 */
@interface CHKTaxLine : CHKObject

@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *rate;
@property (nonatomic, copy) NSString *title;

@end

/**
 * A CHKAddress represents a shipping or billing address on an order. This will be associated with the customer upon completion.
 */
@interface CHKAddress : CHKObject <CHKSerializable>

@property (nonatomic, copy) NSString *address1;
@property (nonatomic, copy) NSString *address2;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *provinceCode;
@property (nonatomic, copy) NSString *zip;

@end

/**
 * CHKShippingRate represents the amount that the merchant is charging a customer for shipping to the specified address.
 */
@interface CHKShippingRate : CHKObject <CHKSerializable>

@property (nonatomic, strong) NSString *shippingRateIdentifier;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, copy) NSString *title;

@end

/**
 * CHKDiscount represents a discount that is applied to the CHKCheckout.
 */
@interface CHKDiscount : CHKObject <CHKSerializable>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, assign) BOOL applicable;

- (instancetype)initWithCode:(NSString *)code;

@end

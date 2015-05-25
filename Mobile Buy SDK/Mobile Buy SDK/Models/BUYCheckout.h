//
//  BUYCheckout.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"
#import "BUYSerializable.h"

@class BUYAddress;
@class BUYCart;
@class BUYCreditCard;
@class BUYDiscount;
@class BUYShippingRate;
@class BUYTaxLine;

/**
 *  The checkout object. This is the main object that you will interact with when creating orders on Shopify.
 *
 *  Note: Do not create a BUYCheckout object directly. Use initWithCart: to transform a BUYCart into a BUYCheckout.
 */
@interface BUYCheckout : BUYObject <BUYSerializable>

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

@property (nonatomic, strong) BUYAddress *billingAddress;
@property (nonatomic, strong) BUYAddress *shippingAddress;

@property (nonatomic, strong) BUYShippingRate *shippingRate;
@property (nonatomic, readonly) NSString *shippingRateId;

@property (nonatomic, strong) BUYDiscount *discount;
@property (nonatomic, strong) NSURL *orderStatusURL;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSDictionary *marketingAttribution;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCart:(BUYCart *)cart NS_DESIGNATED_INITIALIZER;
- (BOOL)hasToken;

@end

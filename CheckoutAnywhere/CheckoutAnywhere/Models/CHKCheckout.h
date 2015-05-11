//
//  CHKCheckout.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"
#import "CHKSerializable.h"

@class CHKAddress;
@class CHKCart;
@class CHKCreditCard;
@class CHKDiscount;
@class CHKShippingRate;
@class CHKTaxLine;

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

- (instancetype)initWithCart:(CHKCart *)cart NS_DESIGNATED_INITIALIZER;
- (BOOL)hasToken;

@end

//
//  BUYCheckout_Private.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

@interface BUYCheckout ()

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *cartToken;
@property (nonatomic, copy) NSNumber *orderId;
@property (nonatomic, assign) BOOL requiresShipping;
@property (nonatomic, assign) BOOL taxesIncluded;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, strong) NSString *paymentSessionId;
@property (nonatomic, strong) NSNumber *reservationTimeLeft;
@property (nonatomic, strong) NSDecimalNumber *paymentDue;
@property (nonatomic, strong) NSURL *webCheckoutURL;
@property (nonatomic, strong) NSURL *paymentURL;
@property (nonatomic, strong) NSDecimalNumber *subtotalPrice;
@property (nonatomic, strong) NSDecimalNumber *totalTax;
@property (nonatomic, strong) NSDecimalNumber *totalPrice;
@property (nonatomic, strong) NSURL *orderStatusURL;
@end

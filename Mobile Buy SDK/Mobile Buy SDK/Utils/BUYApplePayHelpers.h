//
//  BUYApplePayHelpers.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-05-27.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import PassKit;

@class BUYClient;
@class BUYCheckout;

@interface BUYApplePayHelpers : NSObject

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout;

- (void)updateAndCompleteCheckoutWithPayment:(PKPayment *)payment
								  completion:(void (^)(PKPaymentAuthorizationStatus status))completion;

- (void)updateCheckoutWithShippingMethod:(PKShippingMethod *)shippingMethod
							  completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *methods))completion;

- (void)updateCheckoutWithAddress:(ABRecordRef)address
					   completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems))completion;

@property (nonatomic, strong, readonly) BUYCheckout *checkout;
@property (nonatomic, strong, readonly) BUYClient *client;

@property (nonatomic, strong, readonly) NSError *lastError;

@end

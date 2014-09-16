//
//  CHKAnywhereController.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;
#import <Stripe/Stripe.h>

@class CHKCart;
@class CHKCheckout;
@class MERShop;
@class CHKCreditCard;

typedef void (^CHKDataCheckoutBlock)(CHKCheckout *checkout, NSError *error);

/**
 * Single use controller. Do not reuse this for multiple checkouts.
 *
 * 1. Create a new CHKAnywhereController
 * 2. Initiate the checkout with a cart using `createCheckoutWithCart:block:`
 * 3. Append information if you need to using `updateCheckoutWithCart:block:`
 * 4. Process the payment using one of the `processPayment...` methods.
 */
@interface CHKAnywhereController : NSObject

- (instancetype)initWithShop:(MERShop *)shop;
- (NSURLSessionTask *)createCheckoutWithCart:(CHKCart *)cart block:(CHKDataCheckoutBlock)block;
- (NSURLSessionTask *)updateCheckoutWithCart:(CHKCart *)cart block:(CHKDataCheckoutBlock)block;

#pragma mark - Credit Card Support

- (void)processPaymentWithCreditCard:(CHKCreditCard *)creditCard block:(CHKDataCheckoutBlock)block;

#pragma mark - Stripe Support

- (void)processPaymentWithStripeToken:(STPToken *)stripeToken forCheckout:(CHKCheckout *)checkout block:(CHKDataCheckoutBlock)block;

@end

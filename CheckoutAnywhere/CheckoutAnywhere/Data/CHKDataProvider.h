//
//  CHKDataProvider.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-17.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import <Stripe/Stripe.h>

@class CHKCreditCard;
@class CHKCart;
@class CHKCheckout;

typedef void (^CHKDataCreditCardBlock)(CHKCheckout *checkout, NSString *paymentSessionId, NSError *error);
typedef void (^CHKDataCheckoutBlock)(CHKCheckout *checkout, NSError *error);

@interface CHKDataProvider : NSObject

/**
 * Builds a checkout object with this cart. The checkout will be used to prepare an order.
 */
- (NSURLSessionDataTask *)createCheckoutWithCart:(CHKCart *)cart completion:(CHKDataCheckoutBlock)block;

/**
 * Prepares a stripe token for usage during the checkout process. This sends it to Shopify's secure servers.
 * 
 * Note: Storing the token does not charge the associated card (credit or otherwise).
 *       The card will be charged upon finalizing the checkout.
 */
- (NSURLSessionDataTask *)storeStripeToken:(STPToken *)stripeToken checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block;

/**
 * Prepares a credit card for usage during the checkout process. This sends it to Shopify's secure servers.
 *
 * Note: Storing the token does not charge the associated card (credit or otherwise).
 *       The card will be charged upon finalizing the checkout.
 */
- (NSURLSessionDataTask *)storeCreditCard:(CHKCreditCard *)creditCard checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block;

/**
 * Updates the checkout with the latest information added to it.
 */
- (NSURLSessionDataTask *)updateCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block;

@end

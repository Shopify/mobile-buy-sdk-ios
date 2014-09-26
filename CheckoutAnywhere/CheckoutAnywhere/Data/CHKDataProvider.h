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

typedef NS_ENUM(NSUInteger, CHKStatus) {
	CHKStatusComplete = 200,
	CHKStatusProcessing = 202,
	CHKStatusFailed = 424,
	CHKStatusUnknown
};

typedef void (^CHKDataCreditCardBlock)(CHKCheckout *checkout, NSString *paymentSessionId, NSError *error);
typedef void (^CHKDataCheckoutBlock)(CHKCheckout *checkout, NSError *error);
typedef void (^CHKDataCheckoutStatusBlock)(CHKCheckout *checkout, CHKStatus status, NSError *error);
typedef void (^CHKDataShippingRatesBlock)(NSArray *shippingRates, NSError *error);

@interface CHKDataProvider : NSObject

- (instancetype)initWithShopDomain:(NSString *)shopDomain;

#pragma mark - Checkout

/**
 * Builds a checkout object on Shopify. The checkout will be used to prepare an order.
 */
- (NSURLSessionDataTask *)createCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block;

/**
 * Fetches the updated version of this checkout.
 *
 * Note: There is no guarantee that the checkout returned will be the same as the one that is passed in. You are recommended to use the one returned in the block.
 */
- (NSURLSessionDataTask *)getCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block;

/**
 * Updates the checkout with the latest information added to it.
 *
 * Note: There is no guarantee that the checkout returned will be the same as the one that is passed in. You are recommended to use the one returned in the block.
 */
- (NSURLSessionDataTask *)updateCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block;

/**
 * Finalizes the checkout and charges the credit card. This only enqueues a completion job, and will return immediately.
 * You are responsible to call `checkCompletionStatusOfCheckout:block` to get the job's status.
 *
 * Note: There is no guarantee that the checkout returned will be the same as the one that is passed in. You are recommended to use the one returned in the block.
 */
- (NSURLSessionDataTask *)completeCheckout:(CHKCheckout *)checkout block:(CHKDataCheckoutBlock)block;

/**
 * This checks the status of the current payment processing job for the provided checkout.
 *
 * Once the job is complete, you can use the `order_id` property on CHKCheckout to fetch the actual order.
 *
 * Note: There is no guarantee that the checkout returned will be the same as the one that is passed in. You are recommended to use the one returned in the block.
 */
- (NSURLSessionDataTask *)getCompletionStatusOfCheckout:(CHKCheckout *)checkout block:(CHKDataCheckoutStatusBlock)block;

#pragma mark - Shipping Rates

/**
 * Fetches a list of applicable shipping rates for this order. The shipping rate should be added to the checkout and the checkout should then be updated.
 */
- (NSURLSessionDataTask *)getShippingRatesForCheckout:(CHKCheckout *)checkout block:(CHKDataShippingRatesBlock)block;

#pragma mark - Payment Management

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
 * Detail: This will use the billingAddress stored on the CHKCheckout object. This is not a required field, but
 *         helps with fraud checking. Again, including it is recommended, but not required.
 *
 * Note: Storing the token does not charge the associated card (credit or otherwise).
 *       The card will be charged upon finalizing the checkout.
 */
- (NSURLSessionDataTask *)storeCreditCard:(CHKCreditCard *)creditCard checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block;

@end

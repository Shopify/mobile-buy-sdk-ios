//
//  CHKDataProvider.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-17.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKSerializable.h"
#import <PassKit/PassKit.h>

@class CHKCreditCard;
@class CHKCart;
@class CHKCheckout;
@class CHKShop;
@class CHKCollection;
@class CHKProduct;
@class CHKProductVariant;

typedef NS_ENUM(NSUInteger, CHKStatus) {
	CHKStatusComplete = 200,
	CHKStatusProcessing = 202,
	CHKStatusNotFound = 404,
	CHKStatusPreconditionFailed = 412,
	CHKStatusFailed = 424,
	CHKStatusUnknown
};

typedef void (^CHKDataCreditCardBlock)(CHKCheckout *checkout, NSString *paymentSessionId, NSError *error);
typedef void (^CHKDataCheckoutBlock)(CHKCheckout *checkout, NSError *error);
typedef void (^CHKDataCheckoutStatusBlock)(CHKCheckout *checkout, CHKStatus status, NSError *error);
typedef void (^CHKDataShippingRatesBlock)(NSArray *shippingRates, CHKStatus status, NSError *error);
typedef void (^CHKDataShopBlock)(CHKShop *shop, NSError *error);
typedef void (^CHKDataCollectionBlock)(CHKCollection *collection, NSError *error);
typedef void (^CHKDataCollectionListBlock)(NSArray *collections, NSUInteger page, BOOL reachedEnd, NSError *error);
typedef void (^CHKDataProductBlock)(CHKProduct *product, NSError *error);
typedef void (^CHKDataProductListBlock)(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error);
typedef void (^CHKDataImagesListBlock)(NSArray *images, NSError *error);

@interface CHKDataProvider : NSObject

- (instancetype)initWithShopDomain:(NSString *)shopDomain apiKey:(NSString *)apiKey;

/**
 * The page size for any paged request. This can range from 1-250.
 */
@property (nonatomic, assign) NSUInteger pageSize;

#pragma mark - Storefront

/**
 * Fetches the shop's metadata (from /meta.json).
 */
- (NSURLSessionDataTask *)getShop:(CHKDataShopBlock)block;

/**
 * Fetches a single page of collections for the shop by page number. Pages start at 1.
 */
- (NSURLSessionDataTask *)getCollectionsPage:(NSUInteger)page completion:(CHKDataCollectionListBlock)block;

/**
 * Fetches a single page of products for the shop. Pages start at 1.
 */
- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page completion:(CHKDataProductListBlock)block;

/**
 * Fetches a single product by the name of the product. For example, if the product url is:
 * http://_________.myshopify.com/products/BANANA
 *
 * Then the handle is BANANA and you would invoke [provider getProductByHandle:@"BANANA" completion:...];
 */
- (NSURLSessionDataTask *)getProductByHandle:(NSString *)handle completion:(CHKDataProductBlock)block;

/**
 * Fetches a single page of products for the shop.
 */
- (NSURLSessionDataTask *)getProductsInCollection:(CHKCollection*)collection page:(NSUInteger)page completion:(CHKDataProductListBlock)block;

#pragma mark - Checkout

/**
 * Builds a checkout object on Shopify using a Cart Token. The checkout will be used to prepare an order.
 */
- (NSURLSessionDataTask *)createCheckoutWithCartToken:(NSString *)cartToken completion:(CHKDataCheckoutBlock)block;

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
- (NSURLSessionDataTask *)completeCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block;

/**
 * Finalizes the checkout and charges the credit card associated with the payment token. This only enqueues a completion job, and will return immediately.
 * You are responsible to call `checkCompletionStatusOfCheckout:block` to get the job's status.
 *
 * Note: There is no guarantee that the checkout returned will be the same as the one that is passed in. You are recommended to use the one returned in the block.
 */
- (NSURLSessionDataTask *)completeCheckout:(CHKCheckout *)checkout withApplePayToken:(PKPaymentToken *)token completion:(CHKDataCheckoutBlock)block;

/**
 * This checks the status of the current payment processing job for the provided checkout.
 *
 * Once the job is complete, you can use the `order_id` property on CHKCheckout to fetch the actual order.
 *
 * Note: There is no guarantee that the checkout returned will be the same as the one that is passed in. You are recommended to use the one returned in the block.
 */
- (NSURLSessionDataTask *)getCompletionStatusOfCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutStatusBlock)block;

#pragma mark - Shipping Rates

/**
 * Fetches a list of applicable shipping rates for this order. The shipping rate should be added to the checkout and the checkout should then be updated.
 */
- (NSURLSessionDataTask *)getShippingRatesForCheckout:(CHKCheckout *)checkout completion:(CHKDataShippingRatesBlock)block;

#pragma mark - Payment Management

/**
 * Prepares a credit card for usage during the checkout process. This sends it to Shopify's secure servers.
 *
 * Detail: This will use the billingAddress stored on the CHKCheckout object. This is not a required field, but
 *         helps with fraud checking. Again, including it is recommended, but not required.
 *
 * Note: Storing the token does not charge the associated card (credit or otherwise).
 *       The card will be charged upon finalizing the checkout.
 */
- (NSURLSessionDataTask *)storeCreditCard:(id <CHKSerializable>)creditCard checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block;

@end

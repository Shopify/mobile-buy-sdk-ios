//
//  BUYDataClient.h
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

@import Foundation;
@import PassKit;
#import "BUYSerializable.h"

@class BUYCart;
@class BUYCheckout;
@class BUYCreditCard;
@class BUYGiftCard;
@class BUYProduct;
@class BUYProductVariant;
@class BUYShop;
@class BUYCollection;

/**
 *  The sort order for products in a collection
 */
typedef NS_ENUM(NSUInteger, BUYCollectionSort) {
	/**
	 *  Sort products by best selling using the order set in the shop's admin
	 */
	BUYCollectionSortCollectionDefault,
	/**
	 *  Sort products by best selling
	 */
	BUYCollectionSortBestSelling,
	/**
	 *  Sort products by title, ascending
	 */
	BUYCollectionSortTitleAscending,
	/**
	 *  Sort products by title, descending
	 */
	BUYCollectionSortTitleDescending,
	/**
	 *  Sort products by price (first variant), ascending
	 */
	BUYCollectionSortPriceAscending,
	/**
	 *  Sort products by price (first variant), descending
	 */
	BUYCollectionSortPriceDescending,
	/**
	 *  Sort products by creation date, ascending
	 */
	BUYCollectionSortCreatedAscending,
	/**
	 *  Sort products by creation date, descending
	 */
	BUYCollectionSortCreatedDescending
};

extern NSString * const BUYVersionString;

/**
 *  A BUYStatus is associated with the completion of an enqueued job on Shopify.
 *  BUYStatus is equal is HTTP status codes returned from the server
 */
typedef NS_ENUM(NSUInteger, BUYStatus) {
	/**
	 *  The job is complete
	 */
	BUYStatusComplete = 200,
	/**
	 *  The job is still processing
	 */
	BUYStatusProcessing = 202,
	/**
	 *  The job is not found, please check the identifier
	 */
	BUYStatusNotFound = 404,
	/**
	 *  The precondition given in one or more of the request-header fields evaluated to false when it was tested on the server.
	 */
	BUYStatusPreconditionFailed = 412,
	/**
	 *  The request failed, refer to an NSError for details
	 */
	BUYStatusFailed = 424,
	/**
	 *  The status is unknown
	 */
	BUYStatusUnknown
};

/**
 *  Return block containing a BUYCheckout, Payment Session ID and/or an NSError
 *
 *  @param checkout         The returned BUYCheckout
 *  @param paymentSessionId The Payment Session ID associated with a credit card transaction
 *  @param error            Optional NSError
 */
typedef void (^BUYDataCreditCardBlock)(BUYCheckout *checkout, NSString *paymentSessionId, NSError *error);

/**
 *  Return block containing a BUYCheckout and/or an NSError
 *
 *  @param checkout The returned BUYCheckout
 *  @param error    Optional NSError
 */
typedef void (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);

/**
 *  Return block containing a BUYCheckout, a BUYStatus and/or an NSError
 *
 *  @param status   A BUYStatus specifying the requested job's completion status
 *  @param error    Optional NSError
 */
typedef void (^BUYDataCheckoutStatusBlock)(BUYStatus status, NSError *error);

/**
 *  Return block containing BUYShippingRate objects, a BUYStatus and/or an NSError
 *
 *  @param shippingRates Array of SHKShippingRates
 *  @param status        A BUYStatus specifying the requested job's completion status
 *  @param error         Optional NSError
 */
typedef void (^BUYDataShippingRatesBlock)(NSArray *shippingRates, BUYStatus status, NSError *error);

/**
 *  Return block containing a BUYShop and/or an NSError
 *
 *  @param shop  A BUYShop object
 *  @param error Optional NSError
 */
typedef void (^BUYDataShopBlock)(BUYShop *shop, NSError *error);

/**
 *  Return block containing a BUYProduct and/or an NSError
 *
 *  @param product A BUYProduct
 *  @param error   Optional NSError
 */
typedef void (^BUYDataProductBlock)(BUYProduct *product, NSError *error);

/**
 *  Return block containing a list of BUYProduct objects and/or an NSError
 *
 *  @param products An array of BUYProduct objects
 *  @param error    Optional NSError
 */
typedef void (^BUYDataProductsBlock)(NSArray *products, NSError *error);

/**
 *  Return block containing list of collections
 *
 *  @param collections An array of BUYCollection objects
 *  @param error       Optional NSError
 */
typedef void (^BUYDataCollectionsBlock)(NSArray *collections, NSError *error);

/**
 *  Return block containing a list of BUYProduct objects, the page requested, a boolean to determine whether the end of the list has been reach and/or an optional NSError
 *
 *  @param products   An array of BUYProduct objects
 *  @param page       Index of the page requested
 *  @param reachedEnd Boolean indicating whether additional pages exist
 *  @param error      An optional NSError
 */
typedef void (^BUYDataProductListBlock)(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error);

/**
 *  Return block containing a list of BUYProductImage objects and/or an NSError
 *
 *  @param images An array of BUYProductImage objects
 *  @param error  An optional NSError
 */
typedef void (^BUYDataImagesListBlock)(NSArray *images, NSError *error);

/**
 *  Return block containing a BUYGiftCard
 *
 *  @param giftCard A BUYGiftCard
 *  @param error    An optional NSError
 */
typedef void (^BUYDataGiftCardBlock)(BUYGiftCard *giftCard, NSError *error);

/**
 The BUYDataClient provides all requests needed to perform request on the Shopify Checkout API.
 Use this class to perform tasks such as getting a shop, products for a shop, creating a Checkout on Shopify
 and completing Checkouts.
 */
@interface BUYClient : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Initialize a BUYDataClient using a shop's domain, API key and the Channel ID.
 *
 *  @param shopDomain The Shop Domain i.e. abetterlookingshop.myshopify.com
 *  @param apiKey     The API key provided via the Mobile SDK Channel on Shopify Admin
 *  @param channelId  The Channel ID provided on Shopify Admin
 *
 *  @return An instance of BUYDataClient
 */
- (instancetype)initWithShopDomain:(NSString *)shopDomain apiKey:(NSString *)apiKey channelId:(NSString *)channelId NS_DESIGNATED_INITIALIZER;

/**
 *  Queue where callbacks will be called
 *  defaults to main queue
 */
@property (nonatomic, strong) dispatch_queue_t queue;

/**
 *  The page size for any paged request. This can range from 1-250.  Default is 25
 */
@property (nonatomic, assign) NSUInteger pageSize;

/**
 *  The shop domain set using the initializer
 */
@property (nonatomic, strong, readonly) NSString *shopDomain;

/**
 *  The API Key set using the initializer
 */
@property (nonatomic, strong, readonly) NSString *apiKey;

/**
 *  The Channel ID set using the initializer
 */
@property (nonatomic, strong, readonly) NSString *channelId;

/**
 *  The Merchant ID is used for Apple Pay and set using `enableApplePayWithMerchantId:`
 */
@property (nonatomic, strong, readonly) NSString *merchantId __attribute__((deprecated));

/**
 *  Application name to attribute orders to.  Defaults to app bundle name (CFBundleName)
 */
@property (nonatomic, strong) NSString *applicationName;

/**
 * The applications URLScheme, used to return to the application after a complete web checkout. Ex. @"storeApp://"
 */
@property (nonatomic, strong) NSString *urlScheme;


#pragma mark - Storefront

/**
 *  Fetches the shop's metadata (from /meta.json).
 *
 *  @param block (^BUYDataShopBlock)(BUYShop *shop, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getShop:(BUYDataShopBlock)block;

/**
 *  Fetches a single page of products for the shop.
 *
 *  @param page  Page to request. Pages start at 1.
 *  @param block (^BUYDataProductListBlock)(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page completion:(BUYDataProductListBlock)block;

/**
 *  Fetches a single product by the ID of the product.
 *
 *  @param productId Product ID
 *  @param block     (^BUYDataProductBlock)(BUYProduct *product, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getProductById:(NSString *)productId completion:(BUYDataProductBlock)block;

/**
 *  Fetches a list of product by the ID of each product.
 *
 *  @param productIds An array of `NSString` objects with Product IDs to fetch
 *  @param block      (^BUYDataProductsBlock)(NSArray *products, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getProductsByIds:(NSArray *)productIds completion:(BUYDataProductsBlock)block;

/**
 *  Fetches the collections on the shop
 *
 *  @param block (^BUYDataCollectionsBlock)(NSArray *collections, NSError *error)
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getCollections:(BUYDataCollectionsBlock)block;

/**
 *  Fetches the products in the given collection with the collection's 
 *  default sort order set in the shop's admin
 *
 *  @param page         Index of the page requested
 *  @param collectionId The `collectionId` found in the BUYCollection object to fetch the products from
 *  @param block        (NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error)
 *
 *  @return the associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId completion:(BUYDataProductListBlock)block;

/**
 *  Fetches the products in the given collection with a given sort order
 *
 *  @param page         Index of the page requested
 *  @param collectionId The `collectionId` found in the BUYCollection object to fetch the products from
 *  @param sortOrder    The sort order that overrides the default collection sort order
 *  @param block        (NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error)
 *
 *  @return the associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId sortOrder:(BUYCollectionSort)sortOrder completion:(BUYDataProductListBlock)block;

#pragma mark - Checkout

/**
 *  Builds a checkout on Shopify. The checkout object is used to prepare an order
 *
 *  @param checkout BUYCheckout to create on Shopify
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)createCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Builds a checkout on Shopify using a Cart Token from an existing cart on your Shopify store's storefront.
 *  The BUYCheckout object is used to prepare an order.
 *
 *  @param cartToken Cart Token associated with an existing BUYCheckout on Shopify
 *  @param block     (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)createCheckoutWithCartToken:(NSString *)cartToken completion:(BUYDataCheckoutBlock)block;

/**
 *  Applies a gift card code to the checkout.
 *
 *  @param giftCardCode The gift card code to apply on an existing checkout on Shopify. Note: This is not the same as the gift card identifier.
 *  @param checkout     An existing BUYCheckout on Shopify
 *  @param block        (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)applyGiftCardWithCode:(NSString *)giftCardCode toCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Removes a gift card from the checkout.
 *
 *  @param giftCardCode The BUYGiftCard identifier to remove on an existing checkout on Shopify.
 *  @param checkout     An existing BUYCheckout on Shopify
 *  @param block        (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)removeGiftCard:(BUYGiftCard *)giftCard fromCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Retrieves an updated version of a BUYCheckout from Shopify.
 *
 *  Note: There's no guarantee that the BUYCheckout returned will be the same as the one that is passed in.
 *  We recommended using the BUYCheckout returned in the block.
 *
 *  @param checkout The BUYCheckout to retrieve (updated) from Shopify
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Updates a given BUYCheckout on Shopify.
 *
 *  Note: There's no guarantee that the BUYCheckout returned will be the same as the one that is passed in.
 *  We recommended using the BUYCheckout returned in the block.
 *
 *  Note: A BUYCheckout object with an `orderId` is a completed checkout.
 *
 *  @param checkout The BUYCheckout to updated on Shopify
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)updateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Finalizes the BUYCheckout and charges the credit card.
 *  This enqueues a completion job on Shopify and returns immediately.
 *  You must get the job's status by calling checkCompletionStatusOfCheckout:block
 *
 *  Note: There's no guarantee that the BUYCheckout returned will be the same as the one that is passed in.
 *  We recommended using the BUYCheckout returned in the block.
 *
 *  @param checkout The BUYCheckout to complete
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)completeCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 */
/**
 *  Finalizes the checkout and charges the credit card associated with the payment token from PassKit (Apple Pay).
 *  This only enqueues a completion job, and will return immediately.
 *  You must get the job's status by calling checkCompletionStatusOfCheckout:block
 *
 *  Note: There's no guarantee that the BUYCheckout returned will be the same as the one that is passed in.
 *  We recommended using the BUYCheckout returned in the block.
 *
 *  @param checkout The BUYCheckout to complete
 *  @param token    The PKPaymentToken
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)completeCheckout:(BUYCheckout *)checkout withApplePayToken:(PKPaymentToken *)token completion:(BUYDataCheckoutBlock)block;

/**
 *  Retrieve the status of a BUYCheckout. This checks the status of the current payment processing job for the provided checkout.
 *  Once the job is complete (status == BUYStatusComplete), you can retrieve the completed order by calling `getCheckout:completion`
 *
 *  @param checkout The BUYCheckout to retrieve completion status for
 *  @param block    (^BUYDataCheckoutStatusBlock)(BUYCheckout *checkout, BUYStatus status, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getCompletionStatusOfCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutStatusBlock)block;

/**
 *  Retrieve the status of a checkout given a URL obtained in the UIApplicationDelegate method `application:sourceApplication:annotation`
 *
 *  @param url   The URL resource used to open the application
 *  @param block    (^BUYDataCheckoutStatusBlock)(BUYCheckout *checkout, BUYStatus status, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getCompletionStatusOfCheckoutURL:(NSURL *)url completion:(BUYDataCheckoutStatusBlock)block;

#pragma mark - Shipping Rates

/**
 *  Retrieves a list of applicable shipping rates for a given BUYCheckout.
 *  Add the preferred/selected BUYShippingRate to BUYCheckout, then update BUYCheckout
 *
 *  @param checkout The BUYCheckout to retrieve shipping rates for
 *  @param block    (^BUYDataShippingRatesBlock)(NSArray *shippingRates, BUYStatus status, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getShippingRatesForCheckout:(BUYCheckout *)checkout completion:(BUYDataShippingRatesBlock)block;

#pragma mark - Payment Management

/**
 *  Prepares a credit card for usage during the checkout process. This sends it to Shopify's secure servers.
 *  Note: Storing the token does not charge the associated card (credit or otherwise).
 *  The card will be charged upon finalizing the checkout (`completeCheckout:completion:`)
 *
 *  You MUST call `completeCheckout:completion:` after this call and receiving a `paymentSessionId`.
 *  The `paymentSessionId` on the `BUYCheckout` object is not persisted on `updateCheckout:completion:` calls.
 *
 *  @param creditCard BUYCreditCard to prepare for usage
 *  @param checkout   The BUYCheckout associated to the purchase.
 *                    The `billingAddress` stored on the BUYCheckout object is optional and recommended and
 *                    used (if provided) to help with fraud checking.
 *  @param block      (^BUYDataCreditCardBlock)(BUYCheckout *checkout, NSString *paymentSessionId, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)storeCreditCard:(id <BUYSerializable>)creditCard checkout:(BUYCheckout *)checkout completion:(BUYDataCreditCardBlock)block;

/**
 *  Convenience method to release all product inventory reservations by setting its 
 *  `reservationTime` to `@0` and calls `updateCheckout:completion`. We recommend creating
 *  a new BUYCheckout object from a BUYCart for further API calls.
 *
 *  @param checkout The BUYCheckout to expire
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)removeProductReservationsFromCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

#pragma mark - Deprecated methods

/**
 *  Enable Apple Pay by calling this method with the Merchant ID provided via Apple Pay setup in the Mobile SDK Channel on Shopify Admin
 *
 *  @param merchantId The Merchant ID generated on Shopify Admin
 */
- (void)enableApplePayWithMerchantId:(NSString *)merchantId __attribute__((deprecated("Set the merchantId on the BUYViewController instead")));

@end

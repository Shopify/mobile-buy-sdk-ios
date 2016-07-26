//
//  BUYClient+Storefront.h
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

#import <Buy/BUYClient.h>
NS_ASSUME_NONNULL_BEGIN

@class BUYShop;
@class BUYCollection;
@class BUYProduct;

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

/**
 *  Return block containing a BUYShop and/or an NSError
 *
 *  @param shop  A BUYShop object
 *  @param error Optional NSError
 */
typedef void (^BUYDataShopBlock)(BUYShop * _Nullable shop, NSError * _Nullable error);

/**
 *  Return block containing a BUYCollection object and/or an NSError
 *
 *  @param collection  A BUYCollection object.
 *  @param error       Optional NSError
 */
typedef void (^BUYDataCollectionBlock)(BUYCollection* _Nullable collection, NSError * _Nullable error);

/**
 *  Return block containing a list of BUYCollection objects and/or an NSError
 *
 *  @param collections An array of BUYCollection objects
 *  @param error       Optional NSError
 */
typedef void (^BUYDataCollectionsBlock)(NSArray<BUYCollection *> * _Nullable collections, NSError * _Nullable error);

/**
 *  Return block containing a BUYProduct and/or an NSError
 *
 *  @param product A BUYProduct
 *  @param error   Optional NSError
 */
typedef void (^BUYDataProductBlock)(BUYProduct * _Nullable product, NSError * _Nullable error);

/**
 *  Return block containing a list of BUYProduct objects and/or an NSError
 *
 *  @param products An array of BUYProduct objects
 *  @param error    Optional NSError
 */
typedef void (^BUYDataProductsBlock)(NSArray<BUYProduct *> * _Nullable products, NSError * _Nullable error);

/**
 *  Return block containing list of collections
 *
 *  @param collections An array of BUYCollection objects
 *  @param error       Optional NSError
 */
typedef void (^BUYDataCollectionsListBlock)(NSArray<BUYCollection *> * _Nullable collections, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error);

/**
 *  Return block containing a list of BUYProduct objects, the page requested, a boolean to determine whether the end of the list has been reach and/or an optional NSError
 *
 *  @param products   An array of BUYProduct objects
 *  @param page       Index of the page requested
 *  @param reachedEnd Boolean indicating whether additional pages exist
 *  @param error      An optional NSError
 */
typedef void (^BUYDataProductListBlock)(NSArray<BUYProduct *> * _Nullable products, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error);

/**
 *  Return block containing a list of tags
 *
 *  @param tags       An array of tag titles
 *  @param page       Index of the page requested
 *  @param reachedEnd Boolean indicating whether additional pages exist
 *  @param error      An optional NSError
 */
typedef void (^BUYDataTagsListBlock)(NSArray <NSString *> * _Nullable tags, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error);

@interface BUYClient (Storefront)

/**
 *  Fetches the shop's metadata (from /meta.json).
 *
 *  @param block (^BUYDataShopBlock)(BUYShop *shop, NSError *error);
 *
 *  @return The associated operation
 */
- (NSOperation *)getShop:(BUYDataShopBlock)block;

/**
 *  Fetches a single page of products for the shop.
 *
 *  @param page  Page to request. Pages start at 1.
 *  @param block (^BUYDataProductListBlock)(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error);
 *
 *  @return The associated operation
 */
- (NSOperation *)getProductsPage:(NSUInteger)page completion:(BUYDataProductListBlock)block;

/**
 *  Fetches a single product by the handle of the product.
 *
 *  @param handle  Product handle
 *  @param block   (^BUYDataProductBlock)(BUYProduct *product, NSError *error);
 *
 *  @return The associated operation
 */
- (NSOperation *)getProductByHandle:(NSString *)handle completion:(BUYDataProductBlock)block;

/**
 *  Fetches a single product by the ID of the product.
 *
 *  @param productId Product ID
 *  @param block     (^BUYDataProductBlock)(BUYProduct *product, NSError *error);
 *
 *  @return The associated operation
 */
- (NSOperation *)getProductById:(NSNumber *)productId completion:(BUYDataProductBlock)block;

/**
 *  Fetches a list of product by the ID of each product.
 *
 *  @param productIds An array of `NSString` objects with Product IDs to fetch
 *  @param block      (^BUYDataProductsBlock)(NSArray *products, NSError *error);
 *
 *  @return The associated operation
 */
- (NSOperation *)getProductsByIds:(NSArray<NSNumber *> *)productIds completion:(BUYDataProductsBlock)block;

/**
 *  Gets the list of tags for all products
 *
 *  @param page  Page to request. Pages start at 1.
 *  @param block (^BUYDataTagsListBlock)(NSArray <NSString *> * _Nullable tags, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error)
 *
 *  @return The associated NSOperation
 */
- (NSOperation *)getProductTagsPage:(NSUInteger)page completion:(BUYDataTagsListBlock)block;

/**
 *  Fetch a single collection by the handle of the collection.
 *
 *  @param handle Collection handle
 *  @param block  (^BUYDataCollectionBlock)(BUYCollection* _Nullable collection, NSError * _Nullable error)
 *
 *  @return The associated operation.
 */
- (NSOperation *)getCollectionByHandle:(NSString *)handle completion:(BUYDataCollectionBlock)block;

/**
 *  Fetches collections based off page
 *
 *  @param page  Index of the page requested
 *  @param block (^BUYDataCollectionsBlock)(NSArray *collections, NSError *error)
 *
 *  @return The associated operation
 */
- (NSOperation *)getCollectionsPage:(NSUInteger)page completion:(BUYDataCollectionsListBlock)block;

/**
 *  Fetches the products in the given collection with the collection's
 *  default sort order set in the shop's admin
 *
 *  @param page         Index of the page requested
 *  @param collectionId The `collectionId` found in the BUYCollection object to fetch the products from
 *  @param block        (NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error)
 *
 *  @return the associated operation
 */
- (NSOperation *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId completion:(BUYDataProductListBlock)block;

/**
 *  Fetches the products in the given collection with a given sort order
 *
 *  @param page         Index of the page requested
 *  @param collectionId The `collectionId` found in the BUYCollection object to fetch the products from
 *  @param tags			An array of tags which each product must contain
 *  @param sortOrder    The sort order that overrides the default collection sort order
 *  @param block        (NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error)
 *
 *  @return the associated operation
 */
- (NSOperation *)getProductsPage:(NSUInteger)page inCollection:(nullable NSNumber *)collectionId withTags:(nullable NSArray <NSString *> *)tags sortOrder:(BUYCollectionSort)sortOrder completion:(BUYDataProductListBlock)block;

@end

NS_ASSUME_NONNULL_END

//
//  MERDataProvider.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHKShop;
@class CHKCollection;
@class CHKProduct;
@class CHKProductVariant;

typedef void (^MERDataShopBlock)(CHKShop *shop, NSError *error);
typedef void (^MERDataCollectionBlock)(CHKCollection *collection, NSError *error);
typedef void (^MERDataCollectionListBlock)(NSArray *collections, NSUInteger page, BOOL reachedEnd, NSError *error);
typedef void (^MERDataProductBlock)(CHKProduct *product, NSError *error);
typedef void (^MERDataProductListBlock)(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error);
typedef void (^MERDataImagesListBlock)(NSArray *images, NSError *error);

@interface MERDataProvider : NSObject

- (instancetype)initWithShopDomain:(NSString*)shopDomain;

/**
 * The page size for any request. This can range from 1-250.
 */
@property (nonatomic, assign) NSUInteger pageSize;

/**
 * Fetches the shop's metadata (from /meta.json).
 */
- (NSURLSessionDataTask *)getShop:(MERDataShopBlock)block;

/**
 * Fetches a single page of collections for the shop by page number. Pages start at 1.
 */
- (NSURLSessionDataTask *)getCollectionsPage:(NSUInteger)page completion:(MERDataCollectionListBlock)block;

/**
 * Fetches a single page of products for the shop. Pages start at 1.
 */
- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page completion:(MERDataProductListBlock)block;

/**
 * Fetches a single product by the name of the product. For example, if the product url is:
 * http://_________.myshopify.com/products/BANANA
 *
 * Then the handle is BANANA and you would invoke [provider getProductByHandle:@"BANANA" completion:...];
 */
- (NSURLSessionDataTask *)getProductByHandle:(NSString *)handle completion:(MERDataProductBlock)block;

/**
 * Fetches a single page of products for the shop.
 */
- (NSURLSessionDataTask *)getProductsInCollection:(CHKCollection*)collection page:(NSUInteger)page completion:(MERDataProductListBlock)block;

@end

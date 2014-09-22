//
//  MERDataProvider.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MERShop;
@class MERCollection;
@class MERProduct;
@class MERProductVariant;

typedef void (^MERDataShopBlock)(MERShop *shop, NSError *error);
typedef void (^MERDataCollectionListBlock)(NSArray *collections, NSError *error);
typedef void (^MERDataProductListBlock)(NSArray *products, NSError *error);
typedef void (^MERDataImagesListBlock)(NSArray *images, NSError *error);

@interface MERDataProvider : NSObject

- (instancetype)initWithShopDomain:(NSString*)shopDomain;

/**
 * Fetches the shop's metadata (from /meta.json).
 */
- (NSURLSessionDataTask*)fetchShop:(MERDataShopBlock)block;

/**
 * Fetches a single page of collections for the shop.
 */
- (NSURLSessionDataTask*)fetchCollections:(MERDataCollectionListBlock)block;

/**
 * Fetches a single page of products for the shop.
 */
- (NSURLSessionDataTask *)fetchProducts:(MERDataProductListBlock)block;

/**
 * Fetches a single page of products for the shop.
 */
- (NSURLSessionDataTask*)fetchProductsInCollection:(MERCollection*)collection completion:(MERDataProductListBlock)block;

@end

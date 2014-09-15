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
- (NSURLSessionDataTask*)fetchShop:(MERDataShopBlock)block;
- (NSURLSessionDataTask*)fetchCollections:(MERDataCollectionListBlock)block;
- (NSURLSessionDataTask*)fetchProductsInCollection:(MERCollection*)collection completion:(MERDataProductListBlock)block;

@end

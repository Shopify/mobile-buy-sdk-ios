//
//  BUYClient+Storefront.m
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

#import "BUYClient+Storefront.h"
#import "BUYClient+Internal.h"
#import "BUYClient+Routing.h"
#import "BUYShop.h"
#import "BUYCollection.h"
#import "BUYProduct.h"
#import "BUYAssert.h"
#import "BUYShopifyErrorCodes.h"

static NSString * const BUYProductsKey    = @"product_listings";
static NSString * const BUYCollectionsKey = @"collection_listings";

@implementation BUYClient (Storefront)

#pragma mark - Utilities -

- (BOOL)hasReachedEndOfPage:(NSArray *)lastFetchedObjects
{
	return [lastFetchedObjects count] < self.pageSize;
}

#pragma mark - API -

- (BUYRequestOperation *)getShop:(BUYDataShopBlock)block
{
	return [self getRequestForURL:[self urlForShop] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		BUYShop *shop = nil;
		if (json && !error) {
			shop = [self.modelManager insertShopWithJSONDictionary:json];
		}
		block(shop, error);
	}];
}

- (BUYRequestOperation *)getProductsPage:(NSUInteger)page completion:(BUYDataProductListBlock)block
{
	NSURL *route  = [self urlForProductListingsWithParameters:@{
																  @"limit" : @(self.pageSize),
																  @"page"  : @(page),
																  }];
	
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && !error) {
			products = [self.modelManager insertProductsWithJSONArray:json[BUYProductsKey]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

- (BUYRequestOperation *)getProductById:(NSString *)productId completion:(BUYDataProductBlock)block;
{
	BUYAssert(productId, @"Failed to get product by ID. Product ID must not be nil.");
	
	return [self getProductsByIds:@[productId] completion:^(NSArray *products, NSError *error) {
		if (products.count > 0) {
			block(products[0], error);
		} else {
			if (!error) {
				error = [NSError errorWithDomain:BUYShopifyErrorDomain code:BUYShopifyError_InvalidProductID userInfo:@{ NSLocalizedDescriptionKey : @"Product ID is not valid. Confirm the product ID on your shop's admin and also ensure that the visibility is on for the Mobile App channel." }];
			}
			block(nil, error);
		}
	}];
}

- (BUYRequestOperation *)getProductsByIds:(NSArray *)productIds completion:(BUYDataProductsBlock)block
{
	BUYAssert(productIds, @"Failed to get product by IDs. Product IDs array must not be nil.");
	
	NSURL *route  = [self urlForProductListingsWithParameters:@{
																  @"product_ids" : [productIds componentsJoinedByString:@","],
																  }];
	
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && !error) {
			products = [self.modelManager insertProductsWithJSONArray:json[BUYProductsKey]];
		}
		if (!error && products.count == 0) {
			error = [NSError errorWithDomain:BUYShopifyErrorDomain code:BUYShopifyError_InvalidProductID userInfo:@{ NSLocalizedDescriptionKey : @"Product IDs are not valid. Confirm the product IDs on your shop's admin and also ensure that the visibility is on for the Mobile App channel." }];
		}
		block(products, error);
	}];
}

- (BUYRequestOperation *)getCollections:(BUYDataCollectionsBlock)block
{
	return [self getCollectionsPage:1 completion:^(NSArray<BUYCollection *> *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {
		block(collections, error);
	}];
}

- (BUYRequestOperation *)getCollectionsPage:(NSUInteger)page completion:(BUYDataCollectionsListBlock)block
{
	NSURL *route  = [self urlForCollectionListingsWithParameters:@{
																	 @"limit" : @(self.pageSize),
																	 @"page"  : @(page),
																	 }];
	
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *collections = nil;
		if (json && !error) {
			collections = [self.modelManager buy_objectsWithEntityName:[BUYCollection entityName] JSONArray:json[BUYCollectionsKey]];
		}
		block(collections, page, [self hasReachedEndOfPage:collections], error);
	}];
}

- (BUYRequestOperation *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId completion:(BUYDataProductListBlock)block
{
	return [self getProductsPage:page inCollection:collectionId sortOrder:BUYCollectionSortCollectionDefault completion:block];
}

- (BUYRequestOperation *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId sortOrder:(BUYCollectionSort)sortOrder completion:(BUYDataProductListBlock)block
{
	BUYAssert(collectionId, @"Failed to get products page. Invalid collectionID.");
	
	NSURL *route  = [self urlForProductListingsWithParameters:@{
																  @"collection_id" : collectionId,
																  @"limit"         : @(self.pageSize),
																  @"page"          : @(page),
																  @"sort_by"       : [BUYCollection sortOrderParameterForCollectionSort:sortOrder]
																  }];
	
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && !error) {
			products = [self.modelManager buy_objectsWithEntityName:[BUYProduct entityName] JSONArray:json[BUYProductsKey]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

@end

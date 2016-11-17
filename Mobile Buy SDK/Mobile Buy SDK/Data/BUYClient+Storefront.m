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

#pragma mark - API -

- (NSOperation *)getShop:(BUYDataShopBlock)block
{
	return [self getRequestForURL:[self urlForShop] completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYShop *shop = nil;
		if (json && !error) {
			shop = [self.modelManager insertShopWithJSONDictionary:json];
		}
		block(shop, error);
	}];
}

- (NSOperation *)getProductsPage:(NSUInteger)page completion:(BUYDataProductListBlock)block
{
	NSURL *url  = [self urlForProductListingsWithParameters:@{
															  @"limit" : @(self.productPageSize),
															  @"page"  : @(page),
															  }];
	
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		NSArray *products = [self productsFromJSON:json error:error];
		block(products, page, [self isLastPageOfProducts:products] || error, error);
	}];
}

- (NSOperation *)getProductByHandle:(NSString *)handle completion:(BUYDataProductBlock)block
{
	BUYAssert(handle, @"Failed to get product by handle. Product handle must not be nil.");
	
	NSURL *url = [self urlForProductListingsWithParameters:@{ @"handle" : handle }];
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		BUYProduct *product = [self productsFromJSON:json error:error].firstObject;
		
		if (!product && !error) {
			error = [self productsError];
		}
		block(product, error);
	}];
}

- (NSOperation *)getProductById:(NSNumber *)productId completion:(BUYDataProductBlock)block
{
	BUYAssert(productId, @"Failed to get product by ID. Product ID must not be nil.");
	
	return [self getProductsByIds:@[productId] completion:^(NSArray *products, NSError *error) {
		block(products.firstObject, error);
	}];
}

- (NSOperation *)getProductsByIds:(NSArray *)productIds completion:(BUYDataProductsBlock)block
{
	BUYAssert(productIds, @"Failed to get product by IDs. Product IDs array must not be nil.");
	
	NSURL *url  = [self urlForProductListingsWithParameters:@{
															  @"product_ids" : [productIds componentsJoinedByString:@","],
															  }];
	
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		NSArray *products = [self productsFromJSON:json error:error];
		if (!error && products.count == 0) {
			error = [self productsError];
		}
		block(products, error);
	}];
}

- (NSOperation *)getProductsByTags:(NSArray<NSString *> *)tags page:(NSUInteger)page completion:(BUYDataProductsBlock)block
{
	NSURL *url = [self urlForProductListingsWithParameters:@{
															 @"tag":	[tags componentsJoinedByString:@","],
															 @"page":	@(page),
															 }];
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		block([self productsFromJSON:json error:error], error);
	}];
}

- (NSArray<BUYProduct *> *)productsFromJSON:(NSDictionary *)json error:(NSError *)error
{
	if (json && !error) {
		return [self.modelManager insertProductsWithJSONArray:json[BUYProductsKey]];
	}
	return nil;
}

- (NSOperation *)getProductTagsPage:(NSUInteger)page completion:(BUYDataTagsListBlock)block
{
	return [self getProductTagsInCollection:@"" page:page completion:block];
}

- (NSOperation *)getProductTagsInCollection:(NSString *)collectionId page:(NSUInteger)page completion:(BUYDataTagsListBlock)block
{
	NSMutableDictionary *params = @{
									@"limit" : @(self.productTagPageSize),
									@"page"  : @(page),
									}.mutableCopy;
	if (collectionId.length) {
		params[@"collection_id"] = collectionId;
	}
	
	NSURL *url  = [self urlForProductTagsWithParameters:params];
	
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		NSArray *tags = nil;
		if (json && !error) {
			tags = [json[@"tags"] valueForKey:@"title"];
		}
		block(tags, page, [self isLastPageOfProducts:tags], error);
	}];
}

- (NSOperation *)getCollectionByHandle:(NSString *)handle completion:(BUYDataCollectionBlock)block
{
	NSURL *url = [self urlForCollectionListingsWithParameters:@{
																@"handle" : handle
																}];
	
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYCollection *collection = nil;
		if (json && !error) {
			collection = (BUYCollection *)[self.modelManager buy_objectWithEntityName:[BUYCollection entityName] JSONDictionary:json[BUYCollectionsKey][0]];
		}
		block(collection, error);
	}];
}

- (NSOperation *)getCollectionsPage:(NSUInteger)page completion:(BUYDataCollectionsListBlock)block
{
	NSURL *url  = [self urlForCollectionListingsWithParameters:@{
																 @"limit" : @(self.collectionPageSize),
																 @"page"  : @(page),
																 }];
	
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		NSArray *collections = nil;
		if (json && !error) {
			collections = [self.modelManager buy_objectsWithEntityName:[BUYCollection entityName] JSONArray:json[BUYCollectionsKey]];
		}
		block(collections, page, [self isLastPageOfProducts:collections], error);
	}];
}

- (NSOperation *)getCollectionsByIds:(NSArray<NSString *> *)collectionIds page:(NSUInteger)page completion:(BUYDataCollectionsBlock)block
{
	NSURL *url = [self urlForCollectionListingsWithParameters:@{
																@"collection_ids": [collectionIds componentsJoinedByString:@","],
																@"limit" : @(self.collectionPageSize),
																@"page"  : @(page),
																}];
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		NSArray *collections = nil;
		if (json && !error) {
			collections = [self.modelManager buy_objectsWithEntityName:[BUYCollection entityName] JSONArray:json[BUYCollectionsKey]];
		}
		block(collections, error);
	}];
}

- (NSOperation *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId completion:(BUYDataProductListBlock)block
{
	return [self getProductsPage:page inCollection:collectionId withTags:nil sortOrder:BUYCollectionSortCollectionDefault completion:block];
}

- (NSOperation *)getProductsPage:(NSUInteger)page inCollection:(nullable NSNumber *)collectionId withTags:(nullable NSArray <NSString *> *)tags sortOrder:(BUYCollectionSort)sortOrder completion:(BUYDataProductListBlock)block
{
	NSMutableDictionary *params = @{
									@"limit"         : @(self.productPageSize),
									@"page"          : @(page),
									@"sort_by"       : [BUYCollection sortOrderParameterForCollectionSort:sortOrder]
									}.mutableCopy;
	
	if (tags) {
		params[@"tag"] = [tags componentsJoinedByString:@","];
	}
	
	if (collectionId) {
		params[@"collection_id"] = collectionId;
	}
	
	NSURL *url  = [self urlForProductListingsWithParameters:params];
	
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && !error) {
			products = [self.modelManager buy_objectsWithEntityName:[BUYProduct entityName] JSONArray:json[BUYProductsKey]];
		}
		block(products, page, [self isLastPageOfProducts:products] || error, error);
	}];
}

#pragma mark - Helpers -

- (BOOL)isLastPageOfProducts:(NSArray *)lastFetchedObjects
{
	return [lastFetchedObjects count] < self.productPageSize;
}

- (NSError *)productsError
{
	return [NSError errorWithDomain:BUYShopifyErrorDomain code:BUYShopifyError_InvalidProductID userInfo:@{ NSLocalizedDescriptionKey : @"Product identifier(s) / handle is not valid. Confirm the product identifier(s) / handle in your shop's admin and ensure that the visibility is ON for the Mobile App channel." }];
}

@end

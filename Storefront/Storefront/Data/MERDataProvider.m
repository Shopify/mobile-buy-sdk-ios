//
//  MERDataProvider.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERDataProvider.h"

//Models
#import "MERShop.h"
#import "MERProduct.h"
#import "MERProductVariant.h"
#import "MERCollection.h"

@implementation MERDataProvider {
	NSString *_shopDomain;
	NSURLSession *_session;
}

- (instancetype)initWithShopDomain:(NSString *)shopDomain
{
	self = [super init];
	if (self) {
		_shopDomain = shopDomain;
		_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
		_pageSize = 25;
	}
	return self;
}

- (void)setPageSize:(NSUInteger)pageSize
{
	_pageSize = MAX(MIN(pageSize, 250), 1);
}

- (BOOL)hasReachedEndOfPage:(NSArray *)lastFetchedObjects
{
	return [lastFetchedObjects count] < self.pageSize;
}

#pragma mark - Fetch Methods

- (NSURLSessionDataTask *)performRequestForURL:(NSString *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSDictionary *json = nil;
		if (error == nil) {
			id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			json = [jsonData isKindOfClass:[NSDictionary class]] ? jsonData : nil;
		}
		completionHandler(json, response, error);
	}];
	[task resume];
	return task;
}

- (NSURLSessionDataTask*)fetchShop:(MERDataShopBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/meta.json", _shopDomain] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		MERShop *shop = nil;
		if (json) {
			shop = [[MERShop alloc] initWithDictionary:json];
		}
		block(shop, error);
	}];
}

- (NSURLSessionDataTask*)fetchCollectionsPage:(NSUInteger)page completion:(MERDataCollectionListBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/collections.json?limit=%lu&page=%lu", _shopDomain, (unsigned long)_pageSize, (unsigned long)page] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSArray *collections = nil;
		if (json) {
			collections = [MERCollection convertJSONArray:json[@"collections"]];
		}
		block(collections, page, [self hasReachedEndOfPage:collections] || error, error);
	}];
}

- (NSURLSessionDataTask *)fetchProductsPage:(NSUInteger)page completion:(MERDataProductListBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/products.json?limit=%lu&page=%lu", _shopDomain, (unsigned long)_pageSize, (unsigned long)page] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSArray *products = nil;
		if (json) {
			products = [MERProduct convertJSONArray:json[@"products"]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

- (NSURLSessionDataTask*)fetchProductsInCollection:(MERCollection*)collection page:(NSUInteger)page completion:(MERDataProductListBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/collections/%@/products.json?limit=%lu&page=%lu", _shopDomain, collection.handle, (unsigned long)_pageSize, (unsigned long)page] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSArray *products = nil;
		if (json) {
			products = [MERProduct convertJSONArray:json[@"products"]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

@end

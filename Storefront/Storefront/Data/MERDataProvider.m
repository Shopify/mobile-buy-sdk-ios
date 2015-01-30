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
#import "CHKCollection.h"

#define kMinSuccessfulStatusCode 200
#define kMaxSuccessfulStatusCode 299

@implementation MERDataProvider {
	NSString *_shopDomain;
	NSURLSession *_session;
	NSOperationQueue *_queue;
}

- (instancetype)initWithShopDomain:(NSString *)shopDomain
{
	self = [super init];
	if (self) {
		_shopDomain = shopDomain;
		_queue = [[NSOperationQueue alloc] init];
		_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:_queue];
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

- (NSURLSessionDataTask *)getShop:(MERDataShopBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/meta.json", _shopDomain] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		CHKShop *shop = nil;
		if (json && error == nil) {
			shop = [[CHKShop alloc] initWithDictionary:json];
		}
		block(shop, error);
	}];
}

- (NSURLSessionDataTask *)getCollectionsPage:(NSUInteger)page completion:(MERDataCollectionListBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/collections.json?limit=%lu&page=%lu", _shopDomain, (unsigned long)_pageSize, (unsigned long)page] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSArray *collections = nil;
		if (json && error == nil) {
			collections = [CHKCollection convertJSONArray:json[@"collections"]];
		}
		block(collections, page, [self hasReachedEndOfPage:collections] || error, error);
	}];
}

- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page completion:(MERDataProductListBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/products.json?limit=%lu&page=%lu", _shopDomain, (unsigned long)_pageSize, (unsigned long)page] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSArray *products = nil;
		if (json && error == nil) {
			products = [CHKProduct convertJSONArray:json[@"products"]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

- (NSURLSessionDataTask *)getProductByHandle:(NSString *)handle completion:(MERDataProductBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/products/%@.json", _shopDomain, handle] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		CHKProduct *product = nil;
		if (json && error == nil) {
			product = [[CHKProduct alloc] initWithDictionary:json[@"product"]];
		}
		block(product, error);
	}];
}

- (NSURLSessionDataTask *)getProductsInCollection:(CHKCollection*)collection page:(NSUInteger)page completion:(MERDataProductListBlock)block
{
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/collections/%@/products.json?limit=%lu&page=%lu", _shopDomain, collection.handle, (unsigned long)_pageSize, (unsigned long)page] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSArray *products = nil;
		if (json && error == nil) {
			products = [CHKProduct convertJSONArray:json[@"products"]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

#pragma mark - Helpers

- (NSURLSessionDataTask *)performRequestForURL:(NSString *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSDictionary *json = nil;
		if (error == nil) {
			id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			json = [jsonData isKindOfClass:[NSDictionary class]] ? jsonData : nil;
			error = [self extractErrorFromResponse:response json:json];
		}
		completionHandler(json, response, error);
	}];
	[task resume];
	return task;
}

- (NSError *)extractErrorFromResponse:(NSURLResponse *)response json:(NSDictionary *)json
{
	NSError *error = nil;
	NSInteger statusCode = [((NSHTTPURLResponse *) response) statusCode];
	if (statusCode < kMinSuccessfulStatusCode || statusCode > kMaxSuccessfulStatusCode) {
		error = [NSError errorWithDomain:NSURLErrorDomain code:statusCode userInfo:json];
	}
	return error;
}

@end

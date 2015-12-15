//
//  BUYClientTest.m
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

@import UIKit;
@import XCTest;

#import <Buy/Buy.h>
#import "BUYTestConstants.h"
#import "BUYAddress+Additions.h"
#import "BUYClientTestBase.h"
#import "BUYCollection+Additions.h"
#import "NSURLComponents+BUYAdditions.h"

@interface BUYClient ()

+ (BUYStatus)statusForStatusCode:(NSUInteger)statusCode error:(NSError *)error;

@end

@interface BUYClient_Test : BUYClient

@end

@implementation BUYClient_Test

- (void)startTask:(NSURLSessionDataTask *)task
{
	// Do nothing
}

@end

@interface BUYClientTest : BUYClientTestBase
@end

@implementation BUYClientTest

- (void)setupClient
{
	self.shopDomain = BUYShopDomain_Placeholder;
	self.apiKey = BUYAPIKey_Placeholder;
	self.channelId = BUYChannelId_Placeholder;
	
	self.client = [[BUYClient_Test alloc] initWithShopDomain:self.shopDomain apiKey:self.apiKey channelId:self.channelId];
}

- (NSData *)dataForCartFromClient:(BUYClient *)client
{
	BUYCart *cart = [[BUYCart alloc] init];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
	NSURLSessionDataTask *task = [self.client createCheckout:checkout completion:nil];
	XCTAssertNotNil(task);
	
	NSURLRequest *request = task.originalRequest;
	XCTAssertNotNil(request);
	
	NSData *data = request.HTTPBody;
	XCTAssertNotNil(data);
	
	return data;
}

- (void)testCheckoutSerialization
{
	NSData *data = [self dataForCartFromClient:self.client];
	
	NSDictionary *dict = @{@"checkout":
							   @{@"line_items": @[],
								 @"channel_id": self.channelId,
								 @"source_name": @"mobile_app",
								 @"source_identifier": self.client.channelId,
								 @"marketing_attribution":@{@"medium": @"iOS", @"source": self.client.applicationName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

- (void)testPartialAddressesFlag
{
	BUYCart *cart = [[BUYCart alloc] init];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
	
	XCTAssertThrows([checkout setPartialAddresses:NO]);

	NSURLSessionDataTask *task = [self.client createCheckout:checkout completion:nil];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];
	XCTAssertFalse([json[@"checkout"][@"partial_addresses"] boolValue]);
	
	checkout = [[BUYCheckout alloc] initWithCart:cart];
	
	BUYAddress *partialAddress = [[BUYAddress alloc] init];
	partialAddress.address1 = nil;
	
	if ([partialAddress isPartialAddress]) {
		checkout.partialAddresses = YES;
	}
	
	checkout.shippingAddress = partialAddress;
	task = [self.client createCheckout:checkout completion:nil];
	json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];

	XCTAssertTrue([json[@"checkout"][@"partial_addresses"] boolValue]);
}

- (void)testCheckoutPaymentWithOnlyGiftCard
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{@"token": @"abcdef", @"payment_due": @0}];
	
	NSURLSessionDataTask *task = [self.client completeCheckout:checkout completion:nil];
	XCTAssertNotNil(task);
}

- (void)testCheckoutURLParsing
{
	NSURL *url = [NSURL URLWithString:@"sampleapp://?checkout%5Btoken%5D=377a6afb2c6651b6c42af5547e12bda1"];
	
	[self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
		// We should not get a callback here
		XCTFail();
	}];
}

- (void)testCheckoutBadURLParsing
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	NSURL *url = [NSURL URLWithString:@"sampleapp://"];
	
	[self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
		XCTAssertEqual(status, BUYStatusUnknown);
		XCTAssertEqual(error.code, BUYShopifyError_InvalidCheckoutObject);
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testMerchantId
{
	NSString *merchantId = @"com.merchant.id";
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	[self.client enableApplePayWithMerchantId:merchantId];
	
	XCTAssertEqualObjects(merchantId, self.client.merchantId);
#pragma GCC diagnostic pop
}

- (void)testStatusCodeConversions
{
	BUYStatus status = [BUYClient statusForStatusCode:412 error:nil];
	XCTAssertEqual(BUYStatusPreconditionFailed, status);
	
	status = [BUYClient statusForStatusCode:404 error:nil];
	XCTAssertEqual(BUYStatusNotFound, status);
	
	status = [BUYClient statusForStatusCode:0 error:[NSError errorWithDomain:@"" code:-1 userInfo:nil]];
	XCTAssertEqual(BUYStatusFailed, status);
	
	status = [BUYClient statusForStatusCode:424 error:nil];
	XCTAssertEqual(BUYStatusFailed, status);
	
	status = [BUYClient statusForStatusCode:202 error:nil];
	XCTAssertEqual(BUYStatusProcessing, status);
	
	status = [BUYClient statusForStatusCode:200 error:nil];
	XCTAssertEqual(BUYStatusComplete, status);
}

- (void)testCheckoutWithApplePayToken
{
	__block int callbackCount = 0;
	
	[self.client completeCheckout:nil withApplePayToken:[PKPaymentToken new] completion:^(BUYCheckout *checkout, NSError *error) {
		callbackCount++;
		XCTAssertEqual(error.code, BUYShopifyError_InvalidCheckoutObject);
	}];
	
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{@"token": @"abcdef", @"payment_due": @0}];

	[self.client completeCheckout:checkout withApplePayToken:nil completion:^(BUYCheckout *checkout, NSError *error) {
		callbackCount++;
		XCTAssertEqual(error.code, BUYShopifyError_NoApplePayTokenSpecified);
	}];
	
	XCTAssertEqual(callbackCount, 2);
	
	[self testProductsInCollectionWithSortOrderCollectionDefault];
}

- (void)testQueryItemsConversion
{
	NSDictionary *dictionary = @{@"collection_id" : @"1", @"limit" : @"25", @"page" : @"1", @"sort_by" : @"collection-default"};
	NSURLComponents *components = [[NSURLComponents alloc] init];
	[components setQueryItemsWithDictionary:dictionary];
	NSSet *componentsQueryItems = [NSSet setWithArray:components.queryItems];
	NSSet *queryItems = [NSSet setWithArray:@[[NSURLQueryItem queryItemWithName:@"collection_id" value:@"1"], [NSURLQueryItem queryItemWithName:@"limit" value:@"25"], [NSURLQueryItem queryItemWithName:@"page" value:@"1"], [NSURLQueryItem queryItemWithName:@"sort_by" value:@"collection-default"]]];
	XCTAssertEqualObjects(componentsQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderCollectionDefault
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortCollectionDefault completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=collection-default"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderBestSelling
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortBestSelling completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=best-selling"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderCreatedAscending
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortCreatedAscending completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=created-ascending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderCreatedDescending
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortCreatedDescending completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=created-descending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderPriceAscending
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortPriceAscending completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=price-ascending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderPriceDescending
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortPriceDescending completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=price-descending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderTitleAscending
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortTitleAscending completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=title-ascending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderTitleDescending
{
	NSURLSessionDataTask *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortTitleDescending completion:nil];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/channels/api_key/product_publications.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=title-descending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

@end

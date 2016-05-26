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
#import "BUYClientTestBase.h"
#import "NSURLComponents+BUYAdditions.h"
#import "BUYShopifyErrorCodes.h"
#import "BUYAccountCredentials.h"
#import "BUYClient+Customers.h"
#import "BUYClient+Internal.h"
#import "BUYApplePayToken.h"
#import "BUYApplePayTestToken.h"
#import "BUYRequestOperation.h"

NSString * const BUYFakeCustomerToken = @"dsfasdgafdg";

@interface BUYClient_Test : BUYClient

@end

@implementation BUYClient_Test

- (void)startOperation:(BUYOperation *)operation
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
	self.appId = BUYAppId_Placeholder;
	
	self.client = [[BUYClient_Test alloc] initWithShopDomain:self.shopDomain apiKey:self.apiKey appId:self.appId];
}

- (NSData *)dataForCartFromClient:(BUYClient *)client
{
	BUYCart *cart = [self cart];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
	BUYRequestOperation *task = [self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {}];
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
								 @"source_name": @"mobile_app",
								 @"marketing_attribution":@{@"medium": @"iOS", @"source": self.client.applicationName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

- (void)testPartialAddressesFlag
{
	BUYCart *cart = [self cart];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
	
	XCTAssertThrows([checkout setPartialAddressesValue:NO]);

	BUYRequestOperation *task = [self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {}];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];
	XCTAssertFalse([json[@"checkout"][@"partial_addresses"] boolValue]);
	
	checkout = [[BUYCheckout alloc] initWithCart:cart];
	
	BUYAddress *partialAddress = [self.client.modelManager insertAddressWithJSONDictionary:nil];
	partialAddress.address1 = nil;
	
	if ([partialAddress isPartialAddress]) {
		checkout.partialAddressesValue = YES;
	}
	
	checkout.shippingAddress = partialAddress;
	task = [self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {}];
	json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];

	XCTAssertTrue([json[@"checkout"][@"partial_addresses"] boolValue]);
}

- (void)testCheckoutPaymentWithOnlyGiftCard
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithModelManager:self.client.modelManager JSONDictionary:@{@"token": @"abcdef", @"payment_due": @0}];
	
	BUYOperation *task = [self.client completeCheckout:checkout paymentToken:nil completion:^(BUYCheckout *checkout, NSError *error) {}];
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
	NSURL *url = [NSURL URLWithString:@"sampleapp://"];
	
	XCTAssertThrows(
		[self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {}]
	);
}

- (void)testStatusCodeConversions
{
	BUYStatus status = [self.client statusForStatusCode:412 error:nil];
	XCTAssertEqual(BUYStatusPreconditionFailed, status);
	
	status = [self.client statusForStatusCode:404 error:nil];
	XCTAssertEqual(BUYStatusNotFound, status);
	
	status = [self.client statusForStatusCode:0 error:[NSError errorWithDomain:@"" code:-1 userInfo:nil]];
	XCTAssertEqual(BUYStatusFailed, status);
	
	status = [self.client statusForStatusCode:424 error:nil];
	XCTAssertEqual(BUYStatusFailed, status);
	
	status = [self.client statusForStatusCode:202 error:nil];
	XCTAssertEqual(BUYStatusProcessing, status);
	
	status = [self.client statusForStatusCode:200 error:nil];
	XCTAssertEqual(BUYStatusComplete, status);
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
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortCollectionDefault completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=collection-default"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderBestSelling
{
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortBestSelling completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=best-selling"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderCreatedAscending
{
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortCreatedAscending completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=created-ascending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderCreatedDescending
{
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortCreatedDescending completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=created-descending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderPriceAscending
{
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortPriceAscending completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=price-ascending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderPriceDescending
{
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortPriceDescending completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=price-descending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderTitleAscending
{
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortTitleAscending completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=title-ascending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (void)testProductsInCollectionWithSortOrderTitleDescending
{
	BUYRequestOperation *task = [self.client getProductsPage:1 inCollection:@1 sortOrder:BUYCollectionSortTitleDescending completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=title-descending"]];
	XCTAssertEqualObjects(requestQueryItems, queryItems);
}

- (BUYCart *)cart
{
	return [self.client.modelManager insertCartWithJSONDictionary:nil];
}

#pragma mark - Customer Tests -

- (void)testCustomerCreationURL
{
	NSArray *items = @[
					   [BUYAccountCredentialItem itemWithFirstName:@"michael"],
					   [BUYAccountCredentialItem itemWithLastName:@"scott"],
					   [BUYAccountCredentialItem itemWithEmail:@"fake@example.com"],
					   [BUYAccountCredentialItem itemWithPassword:@"password"],
					   [BUYAccountCredentialItem itemWithPasswordConfirmation:@"password"],
					   ];
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:items];
	
	BUYRequestOperation *task = [self.client createCustomerWithCredentials:credentials callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"POST");
	
	NSError *error = nil;
	NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:&error];
	
	XCTAssertNil(error);
	NSDictionary *dict = @{@"customer": @{
								   @"first_name": @"michael",
								   @"last_name": @"scott",
								   @"email": @"fake@example.com",
								   @"password": @"password",
								   @"password_confirmation": @"password"
								   }};
	XCTAssertEqualObjects(payload, dict);
}

- (void)testLoginCustomerURL
{
	NSArray *items = @[
					   [BUYAccountCredentialItem itemWithEmail:@"fake@example.com"],
					   [BUYAccountCredentialItem itemWithPassword:@"password"],
					   ];
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:items];
	BUYRequestOperation *task = [self.client loginCustomerWithCredentials:credentials callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/customer_token.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"POST");
	
	NSError *error = nil;
	NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:&error];
	
	XCTAssertNil(error);
	NSDictionary *dict = @{@"customer": @{
								   @"email": @"fake@example.com",
								   @"password": @"password",
								   }};
	XCTAssertEqualObjects(payload, dict);
}

- (void)testGetCustomerURL
{
	BUYRequestOperation *task = [self.client getCustomerWithID:@"" callback:^(BUYCustomer *customer, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	
	XCTAssertEqualObjects(self.client.customerToken, task.originalRequest.allHTTPHeaderFields[BUYClientCustomerAccessToken]);
}

- (void)testGetOrdersForCustomerURL
{
	BUYRequestOperation *task = [self.client getOrdersForCustomerWithCallback:^(NSArray<BUYOrder *> *orders, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/orders.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	
	XCTAssertEqualObjects(self.client.customerToken, task.originalRequest.allHTTPHeaderFields[BUYClientCustomerAccessToken]);
}

- (void)testCustomerRecovery
{
	NSString *email = @"fake@example.com";
	BUYRequestOperation *task = [self.client recoverPasswordForCustomer:email callback:^(BUYStatus status, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/recover.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"POST");
	
	NSError *error = nil;
	NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:&error];
	
	XCTAssertNil(error);
	NSDictionary *dict = @{@"email": email};
	XCTAssertEqualObjects(payload, dict);
}

- (void)testTokenRenewal
{
	self.client.customerToken = nil;
	
	BUYRequestOperation *task = [self.client renewCustomerTokenWithID:@"" callback:^(NSString *token, NSError *error) {}];
	XCTAssertNil(task); // task should be nil if no customer token was set on the client
	
	self.client.customerToken = BUYFakeCustomerToken;
	task = [self.client renewCustomerTokenWithID:@"1" callback:^(NSString *token, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/1/customer_token/renew.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"PUT");
}

- (void)testCustomerActivation
{
	NSArray *items = @[
					   [BUYAccountCredentialItem itemWithPassword:@"12345"],
					   [BUYAccountCredentialItem itemWithPasswordConfirmation:@"12345"],
					   ];
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:items];
	NSString *customerID = @"12345";
	NSString *token      = @"12345";
	BUYRequestOperation *task = [self.client activateCustomerWithCredentials:credentials customerID:customerID token:token callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/12345/activate.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"PUT");
}

@end

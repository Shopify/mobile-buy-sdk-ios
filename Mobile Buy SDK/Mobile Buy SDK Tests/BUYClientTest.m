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
#import "BUYShopifyErrorCodes.h"
#import "BUYAccountCredentials.h"
#import "BUYClient+Customers.h"
#import "BUYClient+Internal.h"
#import "BUYApplePayToken.h"
#import "BUYApplePayTestToken.h"
#import "BUYRequestOperation.h"

@interface BUYClient_Test : BUYClient

@end

@implementation BUYClient_Test

- (void)startOperation:(NSOperation *)operation
{
	// Do nothing
}

@end

@interface BUYClientTest : BUYClientTestBase
@end

@implementation BUYClientTest

- (void)setUp
{
	[super setUp];
	self.client.customerToken = [self customerTokenForTesting];
}

- (void)tearDown
{
	self.client.customerToken = nil;
	[super tearDown];
}

- (BUYCustomerToken *)customerTokenForTesting
{
	return [[BUYCustomerToken alloc] initWithCustomerID:@1 accessToken:@"" expiry:[NSDate dateWithTimeIntervalSinceNow:3600]];
}

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
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithModelManager:cart.modelManager cart:cart];
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {}];
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
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithModelManager:cart.modelManager cart:cart];
	
	XCTAssertThrows([checkout setPartialAddressesValue:NO]);

	BUYRequestOperation *task = (BUYRequestOperation *)[self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {}];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];
	XCTAssertFalse([json[@"checkout"][@"partial_addresses"] boolValue]);
	
	checkout = [[BUYCheckout alloc] initWithModelManager:cart.modelManager cart:cart];
	
	BUYAddress *partialAddress = [self.client.modelManager insertAddressWithJSONDictionary:nil];
	partialAddress.address1 = nil;
	
	if ([partialAddress isPartialAddress]) {
		checkout.partialAddressesValue = YES;
	}
	
	checkout.shippingAddress = partialAddress;
	task = (BUYRequestOperation *)[self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {}];
	json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];

	XCTAssertTrue([json[@"checkout"][@"partial_addresses"] boolValue]);
}

- (void)testCheckoutPaymentWithOnlyGiftCard
{
	BUYOperation *task = [self.client completeCheckoutWithToken:@"abcdef" paymentToken:nil completion:^(BUYCheckout *checkout, NSError *error) {}];
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

- (void)testSortConversion
{
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortBestSelling],       @"best-selling");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortCreatedAscending],  @"created-ascending");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortCreatedDescending], @"created-descending");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortPriceAscending],    @"price-ascending");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortPriceDescending],   @"price-descending");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortTitleAscending],    @"title-ascending");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortTitleDescending],   @"title-descending");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:999],                                @"collection-default");
	XCTAssertEqualObjects([BUYCollection sortOrderParameterForCollectionSort:0],                                  @"collection-default");
}

- (void)testProductsInCollection
{
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client getProductsPage:1 inCollection:@1 withTags:nil sortOrder:BUYCollectionSortCollectionDefault completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {}];
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.host, @"test_shop");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/apps/app_id/product_listings.json");
	NSSet *requestQueryItems = [NSSet setWithArray:[task.originalRequest.URL.query componentsSeparatedByString:@"&"]];
	NSSet *queryItems = [NSSet setWithArray:@[@"collection_id=1", @"limit=25", @"page=1", @"sort_by=collection-default"]];
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
					   ];
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:items];
	
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client createCustomerWithCredentials:credentials callback:^(BUYCustomer *customer, BUYCustomerToken *token, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"POST");
	
	NSError *error = nil;
	NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:&error];
	
	XCTAssertNil(error);
	NSDictionary *dict = @{@"customer": @{
								   BUYAccountFirstNameKey: @"michael",
								   BUYAccountLastNameKey: @"scott",
								   BUYAccountEmailKey: @"fake@example.com",
								   BUYAccountPasswordKey: @"password",
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
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client loginCustomerWithCredentials:credentials callback:^(BUYCustomer *customer, BUYCustomerToken *token, NSError *error) {
		
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
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client getCustomerCallback:^(BUYCustomer *customer, NSError *error) {
	
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/1.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	
	XCTAssertEqualObjects(self.client.customerToken.accessToken, task.originalRequest.allHTTPHeaderFields[BUYClientCustomerAccessToken]);
}

- (void)testGetOrdersForCustomerURL
{
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client getOrdersForCustomerCallback:^(NSArray<BUYOrder *> *orders, NSError *error) {
	
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/1/orders.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"GET");
	
	XCTAssertEqualObjects(self.client.customerToken.accessToken, task.originalRequest.allHTTPHeaderFields[BUYClientCustomerAccessToken]);
}

- (void)testCustomerRecovery
{
	NSString *email = @"fake@example.com";
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client recoverPasswordForCustomer:email callback:^(BUYStatus status, NSError *error) {
		
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
	
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client renewCustomerTokenCallback:^(NSString *token, NSError *error) {}];
	XCTAssertNil(task); // task should be nil if no customer token was set on the client
	
	
	self.client.customerToken = [[BUYCustomerToken alloc] initWithCustomerID:@1 accessToken:@"fake_token" expiry:[NSDate dateWithTimeIntervalSinceNow:3600]];
	task = (BUYRequestOperation *)[self.client renewCustomerTokenCallback:^(NSString *token, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/1/customer_token/renew.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"PUT");
}

- (void)testCustomerActivation
{
	NSArray *items = @[
					   [BUYAccountCredentialItem itemWithPassword:@"12345"]
					   ];
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:items];
	NSString *customerID = @"12345";
	NSString *token      = @"12345";
	BUYRequestOperation *task = (BUYRequestOperation *)[self.client activateCustomerWithCredentials:credentials customerID:customerID token:token callback:^(BUYCustomer *customer, BUYCustomerToken *token, NSError *error) {
		
	}];
	
	XCTAssertEqualObjects(task.originalRequest.URL.scheme, @"https");
	XCTAssertEqualObjects(task.originalRequest.URL.path, @"/api/customers/12345/activate.json");
	XCTAssertEqualObjects(task.originalRequest.HTTPMethod, @"PUT");
}

@end

//
//  BUYClient+RoutingTests.m
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

#import <XCTest/XCTest.h>
#import "BUYClient+Routing.h"
#import "BUYCustomerToken.h"

@interface BUYClient_RoutingTests : XCTestCase

@property (strong, nonatomic) BUYClient *client;

@end

@implementation BUYClient_RoutingTests

#pragma mark - Setup -

- (void)setUp
{
    [super setUp];
	
	self.client = [[BUYClient alloc] initWithShopDomain:@"_DOMAIN_" apiKey:@"_API_KEY_" appId:@"_APP_ID_"];
	self.client.customerToken = [[BUYCustomerToken alloc] initWithCustomerID:@1 accessToken:@"token" expiry:[NSDate date]];
}

#pragma mark - Test Routes -

- (void)testRoutes
{
	NSString *identifier     = @"1";
	NSString *token          = @"_TOKEN_";
	NSDictionary *parameters = @{ @"param" : @"value" };
	
	XCTAssertEqualObjects(
						  [self.client urlForAPI].absoluteString,
						  @"https://_DOMAIN_/api"
						  );
	
	XCTAssertEqualObjects(
						  [self.client urlForApps].absoluteString,
						  @"https://_DOMAIN_/api/apps/_APP_ID_"
						  );
	
	XCTAssertEqualObjects(
						  [self.client urlForShop].absoluteString,
						  @"https://_DOMAIN_/meta.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForProductListingsWithParameters:parameters].absoluteString,
						  @"https://_DOMAIN_/api/apps/_APP_ID_/product_listings.json?param=value"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCollectionListingsWithParameters:parameters].absoluteString,
						  @"https://_DOMAIN_/api/apps/_APP_ID_/collection_listings.json?param=value"
						  );
	
	XCTAssertEqualObjects(
						  [self.client urlForCheckouts].absoluteString,
						  @"https://_DOMAIN_/api/checkouts.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCheckoutsWithToken:token].absoluteString,
						  @"https://_DOMAIN_/api/checkouts/_TOKEN_.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCheckoutsProcessingWithToken:token].absoluteString,
						  @"https://_DOMAIN_/api/checkouts/_TOKEN_/processing.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCheckoutsCompletionWithToken:token].absoluteString,
						  @"https://_DOMAIN_/api/checkouts/_TOKEN_/complete.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCheckoutsShippingRatesWithToken:token parameters:parameters].absoluteString,
						  @"https://_DOMAIN_/api/checkouts/_TOKEN_/shipping_rates.json?param=value"
						  );
	
	XCTAssertEqualObjects(
						  [self.client urlForCheckoutsUsingGiftCard].absoluteString,
						  @"https://_DOMAIN_/api/checkouts/gift_cards.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCheckoutsUsingGiftCardWithToken:token].absoluteString,
						  @"https://_DOMAIN_/api/checkouts/_TOKEN_/gift_cards.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCheckoutsUsingGiftCard:@999 token:token].absoluteString,
						  @"https://_DOMAIN_/api/checkouts/_TOKEN_/gift_cards/999.json"
						  );
	
	XCTAssertEqualObjects(
						  [self.client urlForCustomers].absoluteString,
						  @"https://_DOMAIN_/api/customers.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersToken].absoluteString,
						  @"https://_DOMAIN_/api/customers/customer_token.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersPasswordRecovery].absoluteString,
						  @"https://_DOMAIN_/api/customers/recover.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersOrders].absoluteString,
						  @"https://_DOMAIN_/api/customers/1/orders.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersOrdersWithOrderID:@99].absoluteString,
						  @"https://_DOMAIN_/api/customers/1/orders/99.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersWithID:identifier].absoluteString,
						  @"https://_DOMAIN_/api/customers/1.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersActivationWithID:identifier parameters:parameters].absoluteString,
						  @"https://_DOMAIN_/api/customers/1/activate.json?param=value"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersTokenRenewal].absoluteString,
						  @"https://_DOMAIN_/api/customers/1/customer_token/renew.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersPasswordResetWithID:identifier parameters:parameters].absoluteString,
						  @"https://_DOMAIN_/api/customers/1/reset.json?param=value"
						  );
	
	XCTAssertEqualObjects(
						  [self.client urlForCustomersAddresses].absoluteString,
						  @"https://_DOMAIN_/api/customers/1/addresses.json"
						  );
	XCTAssertEqualObjects(
						  [self.client urlForCustomersAddressWithAddressID:@999].absoluteString,
						  @"https://_DOMAIN_/api/customers/1/addresses/999.json"
						  );
}

@end

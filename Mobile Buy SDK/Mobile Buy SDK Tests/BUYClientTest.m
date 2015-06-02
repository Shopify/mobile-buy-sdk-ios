//
//  BUYClientTest.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-12-04.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;
#import <Buy/Buy.h>
#import "BUYTestConstants.h"
#import "NSProcessInfo+Environment.h"
#import "BUYAddress+Additions.h"

@interface BUYClient_Test : BUYClient

@end

@implementation BUYClient_Test

- (void)startTask:(NSURLSessionDataTask *)task
{
	// Do nothing
}

@end

@interface BUYClientTest : XCTestCase
@end

@implementation BUYClientTest {
	BUYClient_Test *_client;
	
	NSString *shopDomain;
	NSString *apiKey;
	NSString *channelId;
	NSString *giftCardCode;
	NSString *expiredGiftCardCode;
	NSString *expiredGiftCardId;
}

- (void)setUp
{
	[super setUp];
	
	shopDomain = [NSProcessInfo environmentForKey:kBUYTestDomain];
	apiKey = [NSProcessInfo environmentForKey:kBUYTestAPIKey];
	channelId = [NSProcessInfo environmentForKey:kBUYTestChannelId];
	giftCardCode = [NSProcessInfo environmentForKey:kBUYTestGiftCardCode];
	expiredGiftCardCode = [NSProcessInfo environmentForKey:kBUYTestExpiredGiftCardCode];
	expiredGiftCardId = [NSProcessInfo environmentForKey:kBUYTestExpiredGiftCardID];
	
	XCTAssert([shopDomain length] > 0, @"You must provide a valid shop domain. This is your 'shopname.myshopify.com' address.");
	XCTAssert([apiKey length] > 0, @"You must provide a valid API Key. This is the API Key of your app.");
	
	_client = [[BUYClient_Test alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
}

- (NSData *)dataForCartFromClient:(BUYClient *)client
{
	BUYCart *cart = [[BUYCart alloc] init];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
	NSURLSessionDataTask *task = [client createCheckout:checkout completion:nil];
	XCTAssertNotNil(task);
	
	NSURLRequest *request = task.originalRequest;
	XCTAssertNotNil(request);
	
	NSData *data = request.HTTPBody;
	XCTAssertNotNil(data);
	
	return data;
}

- (void)testCheckoutSerialization
{
	NSData *data = [self dataForCartFromClient:_client];
	
	NSDictionary *dict = @{@"checkout":
							   @{@"line_items": @[],
								 @"channel": channelId,
								 @"marketing_attribution":@{@"platform": @"iOS", @"application_name": _client.applicationName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

- (void)testPartialAddressesFlag
{
	BUYCart *cart = [[BUYCart alloc] init];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];

	NSURLSessionDataTask *task = [_client createCheckout:checkout completion:nil];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];
	XCTAssertFalse([json[@"checkout"][@"partial_addresses"] boolValue]);
	
	checkout = [[BUYCheckout alloc] initWithCart:cart];
	
	BUYAddress *partialAddress = [[BUYAddress alloc] init];
	partialAddress.address1 = BUYPartialAddressPlaceholder;
	
	checkout.shippingAddress = partialAddress;
	task = [_client createCheckout:checkout completion:nil];
	json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];

	XCTAssertTrue([json[@"checkout"][@"partial_addresses"] boolValue]);
}

- (void)testMarketingAttributions
{
	NSString *appName = @"ApPnAmE";
	
	BUYClient_Test *testClient = [[BUYClient_Test alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
	testClient.applicationName = appName;
	
	NSData *data = [self dataForCartFromClient:testClient];
	
	NSDictionary *dict = @{@"checkout":
							   @{@"line_items": @[],
								 @"channel": channelId,
								 @"marketing_attribution":@{@"platform": @"iOS", @"application_name": appName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

- (void)testCallbackQueue
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	XCTestExpectation *expectation2 = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[_client getShop:^(BUYShop *shop, NSError *error) {
		
		BOOL isMainThread = [NSThread isMainThread];
		XCTAssertTrue(isMainThread);
		[expectation fulfill];
	}];
	
	BUYClient *testClient = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
	testClient.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	
	[testClient getShop:^(BUYShop *shop, NSError *error) {
		BOOL isMainThread = [NSThread isMainThread];
		XCTAssertFalse(isMainThread);
		[expectation2 fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

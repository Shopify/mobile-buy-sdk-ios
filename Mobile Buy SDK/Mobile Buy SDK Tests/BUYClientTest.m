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

@interface BUYTestClient : BUYClient

@end

@implementation BUYTestClient

- (void)startTask:(NSURLSessionDataTask *)task
{
	// Do nothing
}

@end

@interface BUYClientTest : XCTestCase
@end

@implementation BUYClientTest {
	BUYTestClient *_client;
	
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
	
	_client = [[BUYTestClient alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
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
							   @{@"partial_addresses": @1,
								 @"line_items": @[],
								 @"channel": channelId,
								 @"marketing_attribution":@{@"platform": @"iOS", @"application_name": _client.applicationName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

- (void)testMarketingAttributions
{
	NSString *appName = @"ApPnAmE";
	
	BUYClient *testClient = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
	testClient.applicationName = appName;
	
	NSData *data = [self dataForCartFromClient:testClient];
	
	NSDictionary *dict = @{@"checkout":
							   @{@"partial_addresses": @1,
								 @"line_items": @[],
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

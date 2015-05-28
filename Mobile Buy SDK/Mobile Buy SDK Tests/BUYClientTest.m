//
//  BUYDataProviderTest.m
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

@interface BUYDataProvider : BUYClient
@end

@implementation BUYDataProvider

- (void)startTask:(NSURLSessionDataTask *)task
{
	// Do nothing
}

@end

@interface BUYDataProviderTest : XCTestCase
@end

@implementation BUYDataProviderTest {
	BUYClient *_dataProvider;
	
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
	
	_dataProvider = [[BUYDataProvider alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
}

- (NSData *)dataForCartFromDataProvider:(BUYClient *)provider
{
	BUYCart *cart = [[BUYCart alloc] init];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
	NSURLSessionDataTask *task = [provider createCheckout:checkout completion:nil];
	XCTAssertNotNil(task);
	
	NSURLRequest *request = task.originalRequest;
	XCTAssertNotNil(request);
	
	NSData *data = request.HTTPBody;
	XCTAssertNotNil(data);
	
	return data;
}

- (void)testCheckoutSerialization
{
	NSData *data = [self dataForCartFromDataProvider:_dataProvider];
	
	NSDictionary *dict = @{@"checkout":
							   @{@"partial_addresses": @1,
								 @"line_items": @[],
								 @"channel": channelId,
								 @"marketing_attribution":@{@"platform": @"iOS", @"application_name": _dataProvider.applicationName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

- (void)testPartialAddressesFlag
{
	BUYCart *cart = [[BUYCart alloc] init];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
	
	// Ensure the partial address is YES for creation
	NSURLSessionDataTask *task = [_dataProvider createCheckout:checkout completion:nil];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];

	XCTAssertTrue([json[@"checkout"][@"partial_addresses"] boolValue]);
	
	// ensure it is NO when not creating it
	json = [checkout jsonDictionaryForCheckout];
	
	XCTAssertFalse([json[@"checkout"][@"partial_addresses"] boolValue]);
}

- (void)testMarketingAttributions
{
	NSString *appName = @"ApPnAmE";
	
	BUYDataProvider *testProvider = [[BUYDataProvider alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
	testProvider.applicationName = appName;
	
	NSData *data = [self dataForCartFromDataProvider:testProvider];
	
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

	[_dataProvider getShop:^(BUYShop *shop, NSError *error) {
		
		BOOL isMainThread = [NSThread isMainThread];
		XCTAssertTrue(isMainThread);
		[expectation fulfill];
	}];
	
	BUYDataProvider *testProvider = [[BUYDataProvider alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
	testProvider.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	
	[testProvider getShop:^(BUYShop *shop, NSError *error) {
		BOOL isMainThread = [NSThread isMainThread];
		XCTAssertFalse(isMainThread);
		[expectation2 fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

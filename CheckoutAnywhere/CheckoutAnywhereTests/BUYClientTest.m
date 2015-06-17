//
//  BUYDataProviderTest.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-12-04.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "BUYClient.h"
#import "BUYTestConstants.h"
#import "BUYCheckout.h"
#import "BUYCart.h"
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
								 @"channel_id": channelId,
								 @"channel": @"mobile_app",
								 @"marketing_attribution":@{@"platform": @"iOS", @"application_name": _dataProvider.applicationName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
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
								 @"channel_id": channelId,
								 @"channel": @"mobile_app",
								 @"marketing_attribution":@{@"platform": @"iOS", @"application_name": appName}}};
	
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

@end

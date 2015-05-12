//
//  CHKDataProviderTest.m
//  Checkout
//
//  Created by Shopify on 2014-12-04.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "CHKDataProvider.h"
#import "CHKTestConstants.h"
#import "CHKCheckout.h"
#import "CHKCart.h"
#import "NSProcessInfo+Environment.h"

@interface TESTDataProvider : CHKDataProvider
@end

@implementation TESTDataProvider

- (void)startTask:(NSURLSessionDataTask *)task
{
	// Do nothing
}

@end

@interface CHKDataProviderTest : XCTestCase
@end

@implementation CHKDataProviderTest {
	CHKDataProvider *_dataProvider;
	
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
	
	shopDomain = [NSProcessInfo environmentForKey:kCHKTestDomain];
	apiKey = [NSProcessInfo environmentForKey:kCHKTestAPIKey];
	channelId = [NSProcessInfo environmentForKey:kCHKTestChannelId];
	giftCardCode = [NSProcessInfo environmentForKey:kCHKTestGiftCardCode];
	expiredGiftCardCode = [NSProcessInfo environmentForKey:kCHKTestExpiredGiftCardCode];
	expiredGiftCardId = [NSProcessInfo environmentForKey:kCHKTestExpiredGiftCardID];
	
	XCTAssert([shopDomain length] > 0, @"You must provide a valid shop domain. This is your 'shopname.myshopify.com' address.");
	XCTAssert([apiKey length] > 0, @"You must provide a valid API Key. This is the API Key of your app.");
	
	_dataProvider = [[TESTDataProvider alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
}

- (NSData *)dataForCartFromDataProvider:(CHKDataProvider *)provider
{
	CHKCart *cart = [[CHKCart alloc] init];
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithCart:cart];
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

- (void)testMarketingAttributions
{
	NSString *appName = @"ApPnAmE";
	
	TESTDataProvider *testProvider = [[TESTDataProvider alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
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

@end

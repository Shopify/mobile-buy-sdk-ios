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
#import "BUYAddress+Additions.h"

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
	
	NSDictionary *environment = [[NSProcessInfo processInfo] environment];
	shopDomain = environment[kBUYTestDomain];
	apiKey = environment[kBUYTestAPIKey];
	channelId = environment[kBUYTestChannelId];
	giftCardCode = environment[kBUYTestGiftCardCode];
	expiredGiftCardCode = environment[kBUYTestExpiredGiftCardCode];
	expiredGiftCardId = environment[kBUYTestExpiredGiftCardID];
	
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
								 @"channel_id": channelId,
								 @"source_name": @"mobile_app",
								 @"source_identifier": _client.channelId,
								 @"marketing_attribution":@{@"medium": @"iOS", @"source": _client.applicationName}}};
	
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

- (void)testCheckoutPaymentWithOnlyGiftCard
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{@"token": @"abcdef", @"payment_due": @0}];
	
	NSURLSessionDataTask *task = [_client completeCheckout:checkout completion:nil];
	XCTAssertNotNil(task);
}

- (void)testCheckoutURLParsing
{
	NSURL *url = [NSURL URLWithString:@"sampleapp://?checkout%5Btoken%5D=377a6afb2c6651b6c42af5547e12bda1"];
	
	[_client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
		// We should not get a callback here
		XCTFail();
	}];
}

- (void)testCheckoutBadURLParsing
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	NSURL *url = [NSURL URLWithString:@"sampleapp://"];
	
	[_client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
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
	[_client enableApplePayWithMerchantId:merchantId];
	
	XCTAssertEqualObjects(merchantId, _client.merchantId);
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
	
	[_client completeCheckout:nil withApplePayToken:[PKPaymentToken new] completion:^(BUYCheckout *checkout, NSError *error) {
		callbackCount++;
		XCTAssertEqual(error.code, BUYShopifyError_InvalidCheckoutObject);
	}];
	
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{@"token": @"abcdef", @"payment_due": @0}];

	[_client completeCheckout:checkout withApplePayToken:nil completion:^(BUYCheckout *checkout, NSError *error) {
		callbackCount++;
		XCTAssertEqual(error.code, BUYShopifyError_NoApplePayTokenSpecified);
	}];
	
	XCTAssertEqual(callbackCount, 2);
}

@end

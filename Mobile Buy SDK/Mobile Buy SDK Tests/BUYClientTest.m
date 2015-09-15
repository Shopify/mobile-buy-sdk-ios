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
#import "BUYClientTestBase.h"

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

- (void)setUp {
	
	[super setUp];
	
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

	NSURLSessionDataTask *task = [self.client createCheckout:checkout completion:nil];
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];
	XCTAssertFalse([json[@"checkout"][@"partial_addresses"] boolValue]);
	
	checkout = [[BUYCheckout alloc] initWithCart:cart];
	
	BUYAddress *partialAddress = [[BUYAddress alloc] init];
	partialAddress.address1 = BUYPartialAddressPlaceholder;
	
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
}

@end

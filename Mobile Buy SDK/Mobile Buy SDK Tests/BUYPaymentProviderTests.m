//
//  BUYPaymentProviderTests.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-12-15.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

@import XCTest;

#import <Buy/Buy.h>

#import "BUYApplePayPaymentProvider.h"
#import "BUYWebCheckoutPaymentProvider.h"
#import "BUYClientTestBase.h"
#import "BUYPaymentController.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

@interface BUYPaymentController ()
- (id <BUYPaymentProvider>)providerForType:(NSString *)type;
@end

@interface BUYPaymentProviderTests : XCTestCase <BUYPaymentProviderDelegate>

@property (nonatomic) NSMutableDictionary <NSString *, XCTestExpectation *> *expectations;
@property (nonatomic) BUYModelManager *modelManager;

@end

@implementation BUYPaymentProviderTests

- (void)setUp
{
	[super setUp];
	self.modelManager = [BUYModelManager modelManager];
	self.expectations = [@{} mutableCopy];
}

- (void)tearDown
{
	[super tearDown];
	[OHHTTPStubs removeAllStubs];
}

- (BUYClient *)client
{
	return [[BUYClient alloc] initWithShopDomain:BUYShopDomain_Placeholder apiKey:BUYAPIKey_Placeholder appId:BUYAppId_Placeholder];
}

- (BUYCheckout *)checkout
{
	return [self.modelManager insertCheckoutWithJSONDictionary:nil];
}

- (void)mockRequests
{
	// This mocks a getShop, and createCheckout request
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return YES;
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [BUYPaymentProviderTests responseForRequest:request];
	}];
}

+ (OHHTTPStubsResponse *)responseForRequest:(NSURLRequest *)request
{
	NSURLComponents *components = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
	
	if ([components.path isEqualToString:@"/meta.json"]) {
		return [OHHTTPStubsResponse responseWithJSONObject:@{@"id": @"123", @"name": @"test_shop", @"country": @"US", @"currency": @"USD"} statusCode:200 headers:nil];
	}
	else if ([components.path isEqualToString:@"/api/checkouts.json"]) {
		return [OHHTTPStubsResponse responseWithJSONObject:@{@"checkout":@{@"payment_due": @(99), @"web_checkout_url": @"https://example.com"}} statusCode:200 headers:nil];
	}
	
	return nil;
}

#pragma mark - Apple Pay

- (void)testAppleAvailability
{
	BUYApplePayPaymentProvider *applePay = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@"merchant.id.1"];
	XCTAssertTrue(applePay.isAvailable);
	
	BUYApplePayPaymentProvider *applePay2 = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@""];
	XCTAssertFalse(applePay2.isAvailable);
}

- (void)testApplePayPresentationCallbacks
{
	[self mockRequests];
	
	BUYApplePayPaymentProvider *applePay = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@"merchant.id.1"];
	applePay.delegate = self;
	
	self.expectations[@"presentController"] = [self expectationWithDescription:NSStringFromSelector(_cmd)];

	[applePay startCheckout:self.checkout];
	
	[self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testApplePayProvider
{
	BUYApplePayPaymentProvider *applePay1 = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@"merchant.id.1"];
	XCTAssertEqualObjects(applePay1.merchantID, @"merchant.id.1");
	
	// 4 default networks should be configured
	XCTAssertEqual(applePay1.supportedNetworks.count, 4);
	
	applePay1.supportedNetworks = @[PKPaymentNetworkMasterCard];
	XCTAssertEqual(applePay1.supportedNetworks.count, 1);
	XCTAssertEqualObjects(applePay1.supportedNetworks[0], PKPaymentNetworkMasterCard);
}

- (void)testCanShowApplePaySetup
{
	BUYApplePayPaymentProvider *applePay = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@"merchant.id.1"];
	XCTAssertTrue(applePay.canShowApplePaySetup);
	
	BUYApplePayPaymentProvider *applePay2 = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@""];
	XCTAssertFalse(applePay2.canShowApplePaySetup);
}

- (void)testFailedApplePayCallbacks
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return YES;
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithJSONObject:@{} statusCode:400 headers:nil];
	}];
	BUYApplePayPaymentProvider *applePay = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@"merchant.id.1"];
	applePay.delegate = self;
	
	self.expectations[@"failedCheckout"] = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	self.expectations[@"failedShop"] = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[applePay startCheckout:self.checkout];
	
	[self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

#pragma mark - Web

- (void)testWebAvailability
{
	BUYWebCheckoutPaymentProvider *webProvider = [[BUYWebCheckoutPaymentProvider alloc] initWithClient:self.client];
	XCTAssertTrue(webProvider.isAvailable);
}

- (void)testWebPresentationCallbacks
{
	[self mockRequests];
	
	BUYWebCheckoutPaymentProvider *webProvider = [[BUYWebCheckoutPaymentProvider alloc] initWithClient:self.client];
	webProvider.delegate = self;
	
	self.expectations[@"presentController"] = [self expectationWithDescription:NSStringFromSelector(_cmd)];

	[webProvider startCheckout:self.checkout];
	
	[self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

#pragma mark - Payment Controller

- (void)testPaymentController
{
	BUYPaymentController *controller = [[BUYPaymentController alloc] init];
	BUYApplePayPaymentProvider *applePay1 = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@"merchant.id.1"];

	[controller addPaymentProvider:applePay1];
	
	XCTAssertEqual(controller.providers.count, 1);
	
	id <BUYPaymentProvider> provider = [controller providerForType:BUYApplePayPaymentProviderId];
	XCTAssertEqualObjects(provider, applePay1);
	
	BUYWebCheckoutPaymentProvider *webProvider = [[BUYWebCheckoutPaymentProvider alloc] initWithClient:self.client];
	[controller addPaymentProvider:webProvider];
	
	XCTAssertEqual(controller.providers.count, 2);
	provider = [controller providerForType:BUYWebPaymentProviderId];
	XCTAssertEqualObjects(provider, webProvider);

	// Attempt to add an alternate Apple Pay provider
	BUYApplePayPaymentProvider *applePay2 = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:@"merchant.id.2"];
	[controller addPaymentProvider:applePay2];
	XCTAssertEqual(controller.providers.count, 2);
}

- (void)testStartingPaymentWithPaymentController
{
	[self mockRequests];
	
	BUYPaymentController *controller = [[BUYPaymentController alloc] init];
	BUYWebCheckoutPaymentProvider *webProvider = [[BUYWebCheckoutPaymentProvider alloc] initWithClient:self.client];
	webProvider.delegate = self;
	[controller addPaymentProvider:webProvider];

	self.expectations[@"presentController"] = [self expectationWithDescription:NSStringFromSelector(_cmd)];

	[controller startCheckout:self.checkout withProviderType:BUYWebPaymentProviderId];
	
	[self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

#pragma mark - Payment Provider delegate

- (void)paymentProvider:(id <BUYPaymentProvider>)provider wantsControllerPresented:(UIViewController *)controller
{
	[self.expectations[@"presentController"] fulfill];
}

- (void)paymentProviderWantsControllerDismissed:(id <BUYPaymentProvider>)provider
{
	
}

- (void)paymentProviderWillStartCheckout:(id <BUYPaymentProvider>)provider
{
	
}

- (void)paymentProviderDidDismissCheckout:(id <BUYPaymentProvider>)provider
{
	
}

- (void)paymentProvider:(id <BUYPaymentProvider>)provider didFailToUpdateCheckoutWithError:(NSError *)error
{
}

- (void)paymentProvider:(id <BUYPaymentProvider>)provider didFailWithError:(NSError *)error;
{
	if (self.expectations[@"failedCheckout"]) {
		[self.expectations[@"failedCheckout"] fulfill];
		[self.expectations removeObjectForKey:@"failedCheckout"];
	}
	
	if (self.expectations[@"failedShop"]) {
		[self.expectations[@"failedShop"] fulfill];
		[self.expectations removeObjectForKey:@"failedShop"];
	}
}

- (void)paymentProvider:(id <BUYPaymentProvider>)provider didCompleteCheckout:(BUYCheckout *)checkout withStatus:(BUYStatus)status
{
	
}


@end

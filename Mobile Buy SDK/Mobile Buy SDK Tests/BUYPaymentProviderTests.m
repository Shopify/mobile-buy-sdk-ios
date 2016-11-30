//
//  BUYPaymentProviderTests.m
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

@import XCTest;
@import Buy;

#import "BUYClientTestBase.h"
#import "BUYFakeSafariController.h"
#import "BUYApplePayAuthorizationDelegate.h"
#import "BUYClientTestBase.h"

#import <OHHTTPStubs/OHHTTPStubs.h>

extern Class SafariViewControllerClass;

@interface BUYPaymentController (Private)
- (id <BUYPaymentProvider>)providerForType:(NSString *)type;
@end

@interface BUYPaymentProviderTests : BUYClientTestBase <BUYPaymentProviderDelegate>

@property (nonatomic) NSMutableDictionary <NSString *, XCTestExpectation *> *expectations;
@property (nonatomic) BUYModelManager *modelManager;

@end

@implementation BUYPaymentProviderTests

- (void)setUp
{
	[super setUp];
	self.modelManager = [BUYModelManager modelManager];
	self.expectations = [@{} mutableCopy];
	
	/* ---------------------------------
	 * We need to kick off the provider
	 * class initialization before setting
	 * the fake safari controller to
	 * prevent it getting overriden.
	 */
	[BUYWebCheckoutPaymentProvider class];
	SafariViewControllerClass = [BUYFakeSafariController class];
}

- (void)tearDown
{
	[super tearDown];
	[OHHTTPStubs removeAllStubs];
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

- (void)testUpdatedCheckoutAfterApplePayPaymentAuthorized
{
	XCTestExpectation *expectationForPaymentAuth = [self expectationWithDescription:@"Apple Pay Authorized"];
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithModelManager:_modelManager JSONDictionary:@{ @"id" : @7522060675 }];
	BUYCheckout *checkout = [_modelManager checkoutWithVariant:variant];
	[self.client createCheckout:checkout completion:^(BUYCheckout * _Nullable checkout, NSError * _Nullable error) {
		BUYApplePayAuthorizationDelegate *applePayDelegate = [[BUYApplePayAuthorizationDelegate alloc] initWithClient:self.client checkout:checkout shopName:@"Testing"];
		PKPaymentAuthorizationViewController *controller = [[PKPaymentAuthorizationViewController alloc] init];
		PKPayment *fakePayment = [[PKPayment alloc] init];
		[applePayDelegate paymentAuthorizationViewController:controller didAuthorizePayment:fakePayment completion:^(PKPaymentAuthorizationStatus status) {
			[expectationForPaymentAuth fulfill];
			XCTAssertNotNil(applePayDelegate.checkout);
		}];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
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

- (void)paymentProvider:(id<BUYPaymentProvider>)provider wantsPaymentControllerPresented:(PKPaymentAuthorizationController *)controller
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

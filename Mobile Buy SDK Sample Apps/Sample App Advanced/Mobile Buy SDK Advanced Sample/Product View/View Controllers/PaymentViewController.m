//
//  PaymentViewController.m
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

@import AddressBook;
@import UIKit;
@import Buy;

#import "PaymentViewController.h"

@implementation PaymentViewController

@synthesize client = _client;

- (instancetype)initWithClient:(BUYClient *)client
{
	self = [super init];
	if (self) {
		self.client = client;
	}
	return self;
}

- (BUYClient*)client
{
	if (_client == nil) {
		NSLog(@"`BUYClient` has not been initialized. Please initialize PaymentViewController with `initWithClient:` or set a `BUYClient` after Storyboard initialization");
	}
	return _client;
}

- (void)loadShopWithCallback:(void (^)(BOOL, NSError *))block
{
	// Deprecated
}

- (BOOL)canShowApplePaySetup
{
	return self.applePayPaymentProvider.canShowApplePaySetup;
}

- (BOOL)isApplePayAvailable
{
	return self.applePayPaymentProvider.available;
}

- (BOOL)shouldShowApplePayButton {
	return self.applePayPaymentProvider.available || [self canShowApplePaySetup];
}

- (BOOL)shouldShowApplePaySetup
{
	return self.applePayPaymentProvider.available == NO && [self canShowApplePaySetup];
}

#pragma mark - Payment

- (void)startApplePayCheckout:(BUYCheckout *)checkout
{
	[self.paymentController startCheckout:checkout withProviderType:BUYApplePayPaymentProviderId];
}

- (void)startWebCheckout:(BUYCheckout *)checkout
{
	[self.paymentController startCheckout:checkout withProviderType:BUYWebPaymentProviderId];
}

- (BUYPaymentController *)paymentController
{
	if (_paymentController == nil) {
		_paymentController = [[BUYPaymentController alloc] init];
		
		BUYWebCheckoutPaymentProvider *webPaymentProvider = [[BUYWebCheckoutPaymentProvider alloc] initWithClient:self.client];
		webPaymentProvider.delegate = self;
		[_paymentController addPaymentProvider:webPaymentProvider];
		
		if (self.merchantId.length) {
			BUYApplePayPaymentProvider *applePayPaymentProvider = [[BUYApplePayPaymentProvider alloc] initWithClient:self.client merchantID:self.merchantId];
			applePayPaymentProvider.delegate = self;
			[_paymentController addPaymentProvider:applePayPaymentProvider];
		}
	}
	
	return _paymentController;
}

- (BUYWebCheckoutPaymentProvider *)webPaymentProvider
{
    return (BUYWebCheckoutPaymentProvider*)[self.paymentController providerForType:BUYWebPaymentProviderId];
}

- (BUYApplePayPaymentProvider *)applePayPaymentProvider
{
    return (BUYApplePayPaymentProvider*)[self.paymentController providerForType:BUYApplePayPaymentProviderId];
}

#pragma  mark - Creating a Checkout using a Cart Token

- (void)startCheckoutWithCartToken:(NSString *)token
{
	[self.client createCheckoutWithCartToken:token completion:^(BUYCheckout *checkout, NSError *error) {
		[self handleCheckoutCompletion:checkout error:error];
	}];
}

- (void)handleCheckoutCompletion:(BUYCheckout *)checkout error:(NSError *)error
{
	if (checkout && error == nil) {
		self.checkout = checkout;
		[self.applePayPaymentProvider startCheckout:checkout];
	}
	else {
		if ([self.delegate respondsToSelector:@selector(controller:failedToCreateCheckout:)]) {
			[self.delegate controller:self failedToCreateCheckout:error];
		}
	}
}

- (void)checkoutCompleted:(BUYCheckout *)checkout status:(BUYStatus)status
{
	if ([self.delegate respondsToSelector:@selector(controller:didCompleteCheckout:status:)]) {
		[self.delegate controller:self didCompleteCheckout:checkout status:status];
	}
}

#pragma mark - Payment delegate methods

+ (void)completeCheckoutFromLaunchURL:(NSURL *)url
{
	[[NSNotificationCenter defaultCenter] postNotificationName:BUYSafariCallbackURLNotification object:nil userInfo:@{BUYURLKey: url}];
}

- (void)paymentProviderWillStartCheckout:(id<BUYPaymentProvider>)provider
{
	if ([self.delegate respondsToSelector:@selector(controllerWillCheckoutViaWeb:)]) {
		[self.delegate controllerWillCheckoutViaWeb:self];
	}
}

- (void)paymentProviderDidDismissCheckout:(id<BUYPaymentProvider>)provider
{
	if ([self.delegate respondsToSelector:@selector(controller:didDismissWebCheckout:)]) {
		[self.delegate controller:self didDismissWebCheckout:self.checkout];
	}
}

- (void)paymentProvider:(id<BUYPaymentProvider>)provider didFailCheckoutWithError:(NSError *)error
{
	if ([self.delegate respondsToSelector:@selector(controller:failedToCreateCheckout:)]) {
		[self.delegate controller:self failedToCreateCheckout:error];
	}
}

- (void)paymentProvider:(id<BUYPaymentProvider>)provider didCompleteCheckout:(BUYCheckout *)checkout withStatus:(BUYStatus)status
{
	if ([self.delegate respondsToSelector:@selector(controller:didCompleteCheckout:status:)]) {
		[self.delegate controller:self didCompleteCheckout:checkout status:status];
	}
}

- (void)paymentProvider:(id<BUYPaymentProvider>)provider wantsControllerPresented:(UIViewController *)controller
{
	[self presentViewController:controller animated:YES completion:nil];
}

- (void)paymentProviderWantsControllerDismissed:(id<BUYPaymentProvider>)provider
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(PKPaymentRequest *)paymentRequest
{
	return nil;
}

@end

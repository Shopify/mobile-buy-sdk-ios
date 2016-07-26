//
//  BUYWebCheckoutPaymentProvider.m
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

#import "BUYWebCheckoutPaymentProvider.h"
#import "BUYCheckout.h"
#import "BUYClient+Checkout.h"
#import "BUYCustomerToken.h"
#import "BUYAssert.h"

@import SafariServices;

Class SafariViewControllerClass;

NSString * BUYSafariCallbackURLNotification = @"kBUYSafariCallbackURLNotification";
NSString * BUYURLKey = @"url";
NSString * const BUYWebPaymentProviderId = @"BUYWebPaymentProviderId";

static NSString *const WebCheckoutCustomerAccessToken = @"customer_access_token";

@interface BUYWebCheckoutPaymentProvider () <SFSafariViewControllerDelegate>

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@end

@implementation BUYWebCheckoutPaymentProvider

@synthesize delegate;

#pragma mark - Initialize -

+ (void)initialize
{
	/* ----------------------------------
	 * Used in tests to set a fake / mock
	 * SFSafariViewController to avoid
	 * instantiating a real one.
	 */
	SafariViewControllerClass = [SFSafariViewController class];
}

#pragma mark - Init -

- (instancetype)initWithClient:(BUYClient *)client
{
	BUYAssert(client, @"Failed to initialize BUYWebCheckoutPaymentProvider, client must not be nil.");
	
	self = [super init];
	if (self) {
		_client = client;
	}
	return self;
}

#pragma mark - Accessors -

- (BOOL)isAvailable
{
	return YES;
}

- (BOOL)isInProgress
{
	return (self.checkout != nil);
}

- (NSString *)identifier
{
	return BUYWebPaymentProviderId;
}

#pragma mark - Equality -

- (NSUInteger)hash
{
	return self.identifier.hash;
}

- (BOOL)isEqual:(id)object
{
	return ([object isKindOfClass:[self class]] && [self.identifier isEqual:[object identifier]]);
}

#pragma mark - Checkout -

- (void)startCheckout:(BUYCheckout *)checkout
{	
	if (self.isInProgress && ![checkout.token isEqual:self.checkout.token]) {
		[[NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Asked to start checkout; but checkout has already started in %@", self] userInfo:nil] raise];
	}
	
	self.checkout = checkout;
	
	[self.client updateOrCreateCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
		[self postCheckoutCompletion:checkout error:error];
	}];
}

- (void)cancelCheckout
{
	self.checkout = nil;
}

- (void)cancelCheckoutAndNotify
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:BUYSafariCallbackURLNotification object:nil];
	
	if ([self.delegate respondsToSelector:@selector(paymentProviderDidDismissCheckout:)]) {
		[self.delegate paymentProviderDidDismissCheckout:self];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidDismissCheckoutNotificationKey object:self];
	
	self.checkout = nil;
}

- (void)postCheckoutCompletion:(BUYCheckout *)checkout error:(NSError *)error
{
	if (self.checkout && error == nil) {
		self.checkout = checkout;

		if ([self.delegate respondsToSelector:@selector(paymentProviderWillStartCheckout:)]) {
			[self.delegate paymentProviderWillStartCheckout:self];
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderWillStartCheckoutNotificationKey object:self];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveCallbackURLNotification:) name:BUYSafariCallbackURLNotification object:nil];
		
		[self openWebCheckout:checkout];
	}
	else {
		if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
			[self.delegate paymentProvider:self didFailWithError:error];
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailCheckoutNotificationKey object:self];
		
		self.checkout = nil;
	}
}

- (void)openWebCheckout:(BUYCheckout *)checkout
{
	NSURL *checkoutURL = [self authenticatedWebCheckoutURL:checkout.webCheckoutURL];
	if (SafariViewControllerClass) {
		
		SFSafariViewController *safariViewController = [[SafariViewControllerClass alloc] initWithURL:checkoutURL];
		safariViewController.delegate = self;
		[self.delegate paymentProvider:self wantsControllerPresented:safariViewController];
	}
	else {
		[[UIApplication sharedApplication] openURL:checkoutURL];
	}
}

- (NSURL *)authenticatedWebCheckoutURL:(NSURL *)url
{
	NSString *accessToken = self.client.customerToken.accessToken;
	if (!accessToken.length) {
		return url;
	}
	NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:WebCheckoutCustomerAccessToken value:accessToken];
	NSURLComponents *authenticatedComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
	authenticatedComponents.queryItems = authenticatedComponents.queryItems ? [authenticatedComponents.queryItems arrayByAddingObject:item] : @[item];
	return authenticatedComponents.URL;
}

#pragma mark - Web Checkout Delegate Methods -

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller;
{
	[self cancelCheckoutAndNotify];
}

- (void)didReceiveCallbackURLNotification:(NSNotification *)notification
{
	NSURL *url = notification.userInfo[BUYURLKey];
	
	[self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
		
		if ([self.delegate respondsToSelector:@selector(paymentProvider:didCompleteCheckout:withStatus:)]) {
			[self.delegate paymentProvider:self didCompleteCheckout:self.checkout withStatus:status];
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidCompleteCheckoutNotificationKey object:self];
		
		[[NSNotificationCenter defaultCenter] removeObserver:self name:BUYSafariCallbackURLNotification object:nil];
	}];
	
	[self.delegate paymentProviderWantsControllerDismissed:self];
	
	self.checkout = nil;
}

@end

//
//  BUYViewController.m
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
@import PassKit;
@import SafariServices;

#import "BUYApplePayAdditions.h"
#import "BUYCart.h"
#import "BUYClient.h"
#import "BUYViewController.h"
#import "BUYApplePayHelpers.h"
#import "BUYDiscount.h"
#import "BUYShop.h"

NSString * BUYSafariCallbackURLNotification = @"kBUYSafariCallbackURLNotification";
NSString * BUYURLKey = @"url";


@interface BUYViewController () <SFSafariViewControllerDelegate>

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYApplePayHelpers *applePayHelper;
@property (nonatomic, assign) BOOL isLoadingShop;
@property (nonatomic, assign) PKPaymentAuthorizationStatus paymentAuthorizationStatus;

@end

@implementation BUYViewController

@synthesize client = _client;

- (instancetype)initWithClient:(BUYClient *)client
{
	self = [super init];
	if (self) {
		self.client = client;
	}
	return self;
}

- (void)setClient:(BUYClient *)client
{
	_client = client;
	if (&PKPaymentNetworkDiscover != NULL) {
		self.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa, PKPaymentNetworkDiscover];
	} else {
		self.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
	}
}

- (BUYClient*)client
{
	if (_client == nil) {
		NSLog(@"`BUYClient` has not been initialized. Please initialize BUYViewController with `initWithClient:` or set a `BUYClient` after Storyboard initialization");
	}
	return _client;
}

- (void)loadShopWithCallback:(void (^)(BOOL, NSError *))block
{
	// fetch shop details for the currency and country codes
	self.isLoadingShop = YES;
	[self.client getShop:^(BUYShop *shop, NSError *error) {
		
		if (error == nil) {
			self.shop = shop;
		}
		
		self.isLoadingShop = NO;
		
		if (block) block((error == nil), error);
	}];
}

- (BOOL)canShowApplePaySetup
{
	PKPassLibrary *passLibrary = [[PKPassLibrary alloc] init];
	if (self.allowApplePaySetup == YES &&
		// Check that it's running iOS 9.0 or above
		[passLibrary respondsToSelector:@selector(canAddPaymentPassWithPrimaryAccountIdentifier:)] &&
		// Check if the device can add a payment pass
		[PKPaymentAuthorizationViewController canMakePayments] &&
		// Check that Apple Pay is enabled for the merchant
		[self.merchantId length]) {
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)isApplePayAvailable
{
	// checks if the client is setup to use Apple Pay
	// checks if device hardware is capable of using Apple Pay
	// checks if the device has a payment card setup
	return (self.merchantId.length &&
			[PKPaymentAuthorizationViewController canMakePayments] &&
			[PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:self.supportedNetworks]);
}

- (BOOL)shouldShowApplePayButton {
	return self.isApplePayAvailable || [self canShowApplePaySetup];
}

- (BOOL)shouldShowApplePaySetup
{
	return self.isApplePayAvailable == NO && [self canShowApplePaySetup];
}

#pragma mark - Checkout Flow Methods
#pragma mark - Step 1 - Creating or updating a Checkout

- (void)startApplePayCheckout:(BUYCheckout *)checkout
{
	// Default to the failure state, since cancelling a payment would not update the state and thus appear as a success
	self.paymentAuthorizationStatus = PKPaymentAuthorizationStatusFailure;
	
	/**
	 *  To perform an Apple Pay checkout, we need both the BUYShop object, and a BUYCheckout
	 *  We will download both in parallel, and continue with the checkout when they both succeed
	 */
	dispatch_group_t group = dispatch_group_create();
	__block NSError *checkoutError = nil;
	
	// download the shop
	if (self.shop == nil) {
		dispatch_group_enter(group);
		[self loadShopWithCallback:^(BOOL success, NSError *error) {
			
			if (error) {
				checkoutError = error;
				
				if ([self.delegate respondsToSelector:@selector(controllerFailedToStartApplePayProcess:)]) {
					[self.delegate controllerFailedToStartApplePayProcess:self];
				}
			}
			dispatch_group_leave(group);
		}];
	}
	
	// create the checkout on Shopify
	dispatch_group_enter(group);
	[self handleCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
		
		if (error) {
			checkoutError = error;
			
			if ([self.delegate respondsToSelector:@selector(controller:failedToCreateCheckout:)]) {
				[self.delegate controller:self failedToCreateCheckout:error];
			}
		}
		else {
			self.checkout = checkout;
		}

		dispatch_group_leave(group);
	}];
	
	// When we have both the shop and checkout, we can request the payment with Apple Pay
	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		
		if (self.checkout && self.shop) {
			
			if ([self.delegate respondsToSelector:@selector(controllerWillCheckoutViaApplePay:)]) {
				[self.delegate controllerWillCheckoutViaApplePay:self];
			}
			
			self.applePayHelper = [[BUYApplePayHelpers alloc] initWithClient:self.client checkout:self.checkout shop:self.shop];
			[self requestPayment];
		}
		else {
			if ([self.delegate respondsToSelector:@selector(controller:failedToCreateCheckout:)]) {
				[self.delegate controller:self failedToCreateCheckout:checkoutError];
			}
		}
	});
}

- (void)startWebCheckout:(BUYCheckout *)checkout
{
	[self handleCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
		
		[self postCheckoutCompletion:checkout error:error];
	}];
}

- (void)postCheckoutCompletion:(BUYCheckout *)checkout error:(NSError *)error
{
	if (error == nil) {
		self.checkout = checkout;
		if ([self.delegate respondsToSelector:@selector(controllerWillCheckoutViaWeb:)]) {
			[self.delegate controllerWillCheckoutViaWeb:self];
		}
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveCallbackURLNotification:) name:BUYSafariCallbackURLNotification object:nil];
		
		[self openWebCheckout:checkout];
	}
	else {
		if ([self.delegate respondsToSelector:@selector(controller:failedToCreateCheckout:)]) {
			[self.delegate controller:self failedToCreateCheckout:error];
		}
	}
}

- (void)handleCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)completion
{
	if ([checkout.token length] > 0) {
		[self.client updateCheckout:checkout completion:completion];
	} else {
		[self.client createCheckout:checkout completion:completion];
	}
}

#pragma  mark - Alternative Step 1 - Creating a Checkout using a Cart Token

- (void)startCheckoutWithCartToken:(NSString *)token
{
	[self.client createCheckoutWithCartToken:token completion:^(BUYCheckout *checkout, NSError *error) {
		self.applePayHelper = [[BUYApplePayHelpers alloc] initWithClient:self.client checkout:checkout];
		[self handleCheckoutCompletion:checkout error:error];
	}];
}

- (void)handleCheckoutCompletion:(BUYCheckout *)checkout error:(NSError *)error
{
	if (checkout && error == nil) {
		self.checkout = checkout;
		[self requestPayment];
	}
	else {
		if ([self.delegate respondsToSelector:@selector(controller:failedToCreateCheckout:)]) {
			[self.delegate controller:self failedToCreateCheckout:error];
		}
	}
}

#pragma mark - Web Checkout

- (void)openWebCheckout:(BUYCheckout *)checkout
{
	if ([SFSafariViewController class]) {
		
		SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:checkout.webCheckoutURL];
		safariViewController.delegate = self;
		
		[self presentViewController:safariViewController animated:YES completion:nil];
	}
	else {
		[[UIApplication sharedApplication] openURL:checkout.webCheckoutURL];
	}
}

#pragma mark - Step 2 - Requesting Payment using Apple Pay

- (void)requestPayment
{
	//Step 2 - Request payment from the user by presenting an Apple Pay sheet
	if (self.merchantId.length == 0) {
		NSLog(@"Merchant ID must be configured to use Apple Pay");
		if ([self.delegate respondsToSelector:@selector(controllerFailedToStartApplePayProcess:)]) {
			[self.delegate controllerFailedToStartApplePayProcess:self];
		}
		return;
	}
	
	if (self.shop == nil) {
		NSLog(@"loadShopWithCallback: must be called before starting an Apple Pay checkout");
		if ([self.delegate respondsToSelector:@selector(controllerFailedToStartApplePayProcess:)]) {
			[self.delegate controllerFailedToStartApplePayProcess:self];
		}
		return;
	}
	
	PKPaymentRequest *request = [self paymentRequest];
	request.paymentSummaryItems = [self.checkout buy_summaryItemsWithShopName:self.shop.name];
	PKPaymentAuthorizationViewController *controller = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
	if (controller) {
		controller.delegate = self;
		[self presentViewController:controller animated:YES completion:nil];
	}
	else {
		if ([self.delegate respondsToSelector:@selector(controllerFailedToStartApplePayProcess:)]) {
			[self.delegate controllerFailedToStartApplePayProcess:self];
		}
	}
}

- (void)checkoutCompleted:(BUYCheckout *)checkout status:(BUYStatus)status
{
	if ([self.delegate respondsToSelector:@selector(controller:didCompleteCheckout:status:)]) {
		[self.delegate controller:self didCompleteCheckout:checkout status:status];
	}
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate Methods

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	[self.applePayHelper paymentAuthorizationViewController:controller didAuthorizePayment:payment completion:^(PKPaymentAuthorizationStatus status) {
		self.paymentAuthorizationStatus = status;
		switch (status) {
			case PKPaymentAuthorizationStatusFailure:
				if ([self.delegate respondsToSelector:@selector(controller:failedToCompleteCheckout:withError:)]) {
					[self.delegate controller:self failedToCompleteCheckout:self.checkout withError:self.applePayHelper.lastError];
				}
				break;
				
			case PKPaymentAuthorizationStatusInvalidShippingPostalAddress:
				if ([self.delegate respondsToSelector:@selector(controller:failedToUpdateCheckout:withError:)]) {
					[self.delegate controller:self failedToUpdateCheckout:self.checkout withError:self.applePayHelper.lastError];
				}
				break;
				
			default: {
				if ([self.delegate respondsToSelector:@selector(controller:didCompleteCheckout:status:)]) {
					BUYStatus buyStatus = (status == PKPaymentAuthorizationStatusSuccess) ? BUYStatusComplete : BUYStatusFailed;
					[self.delegate controller:self didCompleteCheckout:self.checkout status:buyStatus];
				}
			}
				break;
		}
		
		completion(status);
	}];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
	// The checkout is done at this point, it may have succeeded or failed. You are responsible for dealing with failure/success earlier in the steps.
	[self dismissViewControllerAnimated:YES completion:^{
		// If Apple Pay is dismissed with Cancel we need to clear the reservation time on the products in the checkout
		if (self.paymentAuthorizationStatus != PKPaymentAuthorizationStatusSuccess) {
			[self.client removeProductReservationsFromCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
				self.checkout = checkout;
				if ([self.delegate respondsToSelector:@selector(controller:didDismissApplePayControllerWithStatus:forCheckout:)]) {
					[self.delegate controller:self didDismissApplePayControllerWithStatus:self.paymentAuthorizationStatus forCheckout:self.checkout];
				}
			}];
		} else {
			if ([self.delegate respondsToSelector:@selector(controller:didDismissApplePayControllerWithStatus:forCheckout:)]) {
				[self.delegate controller:self didDismissApplePayControllerWithStatus:self.paymentAuthorizationStatus forCheckout:self.checkout];
			}
		}
	}];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingMethod:(nonnull PKShippingMethod *)shippingMethod completion:(nonnull void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
	[self.applePayHelper paymentAuthorizationViewController:controller didSelectShippingMethod:shippingMethod completion:^(PKPaymentAuthorizationStatus status, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		if (status == PKPaymentAuthorizationStatusInvalidShippingPostalAddress) {
			if ([self.delegate respondsToSelector:@selector(controller:failedToGetShippingRates:withError:)]) {
				[self.delegate controller:self failedToGetShippingRates:self.checkout withError:self.applePayHelper.lastError];
			}
		}
		completion(status, summaryItems);
	}];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
	[self.applePayHelper paymentAuthorizationViewController:controller didSelectShippingAddress:address completion:^(PKPaymentAuthorizationStatus status, NSArray<PKShippingMethod *> * _Nonnull shippingMethods, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		if (status == PKPaymentAuthorizationStatusInvalidShippingPostalAddress) {
			if ([self.delegate respondsToSelector:@selector(controller:failedToUpdateCheckout:withError:)]) {
				[self.delegate controller:self failedToUpdateCheckout:self.checkout withError:self.applePayHelper.lastError];
			}
		}
		completion(status, shippingMethods, summaryItems);
	}];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingContact:(PKContact *)contact completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
	[self.applePayHelper paymentAuthorizationViewController:controller didSelectShippingContact:contact completion:^(PKPaymentAuthorizationStatus status, NSArray<PKShippingMethod *> * _Nonnull shippingMethods, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		if (status == PKPaymentAuthorizationStatusInvalidShippingPostalAddress) {
			if ([self.delegate respondsToSelector:@selector(controller:failedToUpdateCheckout:withError:)]) {
				[self.delegate controller:self failedToUpdateCheckout:self.checkout withError:self.applePayHelper.lastError];
			}
		}
		completion(status, shippingMethods, summaryItems);
	}];
}

#pragma mark - Helpers

- (PKPaymentRequest *)paymentRequest
{
	PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	NSString *merchantId = self.client.merchantId ? : self.merchantId;
#pragma GCC diagnostic pop
	
	[paymentRequest setMerchantIdentifier:merchantId];
	[paymentRequest setRequiredBillingAddressFields:PKAddressFieldAll];
	[paymentRequest setRequiredShippingAddressFields:self.checkout.requiresShipping ? PKAddressFieldAll : PKAddressFieldEmail|PKAddressFieldPhone];
	[paymentRequest setSupportedNetworks:self.supportedNetworks];
	[paymentRequest setMerchantCapabilities:PKMerchantCapability3DS];
	[paymentRequest setCountryCode:self.shop.country];
	[paymentRequest setCurrencyCode:self.shop.currency];
	
	return paymentRequest;
}

#pragma mark - Web Checkout delegate methods

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller;
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:BUYSafariCallbackURLNotification object:nil];
	
	if ([self.delegate respondsToSelector:@selector(controller:didDismissWebCheckout:)]) {
		[self.delegate controller:self didDismissWebCheckout:self.checkout];
	}
}

- (void)didReceiveCallbackURLNotification:(NSNotification *)notification
{
	NSURL *url = notification.userInfo[BUYURLKey];
	
	[self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
		
		[self checkoutCompleted:_checkout status:status];
		
		[[NSNotificationCenter defaultCenter] removeObserver:self name:BUYSafariCallbackURLNotification object:nil];
	}];
	
	if (self.presentedViewController) {
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}

+ (void)completeCheckoutFromLaunchURL:(NSURL *)url
{
	[[NSNotificationCenter defaultCenter] postNotificationName:BUYSafariCallbackURLNotification object:nil userInfo:@{BUYURLKey: url}];
}

@end

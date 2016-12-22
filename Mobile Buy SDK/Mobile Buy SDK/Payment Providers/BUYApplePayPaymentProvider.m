//
//  BUYApplePayPaymentProvider.m
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

@import PassKit;

#import "BUYApplePayPaymentProvider.h"
#import "BUYCheckout.h"
#import "BUYApplePayAuthorizationDelegate.h"
#import "BUYApplePayAdditions.h"
#import "BUYShop.h"
#import "BUYClient+Checkout.h"
#import "BUYClient+Storefront.h"

NSString *const BUYApplePayPaymentProviderId = @"BUYApplePayPaymentProviderId";

typedef void (^BUYAddressUpdateCompletion)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull);
typedef void (^BUYShippingMethodCompletion)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull);

#if TARGET_OS_WATCH
@interface BUYApplePayPaymentProvider () <PKPaymentAuthorizationControllerDelegate>
#else
@interface BUYApplePayPaymentProvider () <PKPaymentAuthorizationViewControllerDelegate, PKPaymentAuthorizationControllerDelegate>
#endif

@property (nonatomic, strong) BUYShop *shop;
@property (nonatomic, strong) BUYApplePayAuthorizationDelegate *applePayAuthorizationDelegate;
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, assign) PKPaymentAuthorizationStatus paymentAuthorizationStatus;
@property (nonatomic, strong) BUYClient *client;

@property (nonatomic) Class applePayControllerClass;

@property (nonatomic, assign) BOOL inProgress;

@end

@implementation BUYApplePayPaymentProvider

@synthesize delegate;

- (instancetype)initWithClient:(BUYClient *)client merchantID:(NSString *)merchantID
{
	NSParameterAssert(client);
	NSParameterAssert(merchantID);
	
	self = [super init];
	
	if (self) {
		_client = client;
		_merchantID = merchantID;
		_allowApplePaySetup = YES;
		#if TARGET_OS_WATCH
		_applePayControllerClass = [PKPaymentAuthorizationController class];
		#else
		_applePayControllerClass = ([PKPaymentAuthorizationController class]) ?: [PKPaymentAuthorizationViewController class];
		#endif
	}
	
	return self;
}

- (NSUInteger)hash
{
	return self.identifier.hash;
}

- (BOOL)isEqual:(id)object
{
	return ([object isKindOfClass:[self class]] && [self.identifier isEqual:[object identifier]]);
}

- (NSString *)identifier
{
	return BUYApplePayPaymentProviderId;
}

- (void)startCheckout:(BUYCheckout *)checkout
{	
	if (self.isInProgress) {
		return;
	}
	self.inProgress = YES;
	self.checkout = checkout;
	
	// Default to the failure state, since cancelling a payment would not update the state and thus appear as a success
	self.paymentAuthorizationStatus = PKPaymentAuthorizationStatusFailure;

	// download the shop
	dispatch_group_t group = dispatch_group_create();
	
	dispatch_group_enter(group);
	[self.client getShop:^(BUYShop *theShop, NSError *error) {
		
		if (error) {
			if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
				[self.delegate paymentProvider:self didFailWithError:error];
			}
			[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailCheckoutNotificationKey object:self];
		}
		else {
			self.shop = theShop;
		}
		
		dispatch_group_leave(group);
	}];
	
	dispatch_group_enter(group);
	[self.client updateOrCreateCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (error) {
			if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
				[self.delegate paymentProvider:self didFailWithError:error];
			}
			[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailCheckoutNotificationKey object:self];
		}
		else {
			self.checkout = checkout;
		}
		
		dispatch_group_leave(group);
	}];
	
	// create the checkout on Shopify
	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		
		if (self.shop && self.checkout) {
			[self proceedWithApplePay];
		}
		else {
			[self cancelCheckout];
		}
	});
}

- (void)cancelCheckout
{
	self.inProgress = NO;
	self.checkout = nil;
}

- (BOOL)isAvailable
{
	// checks if the client is setup to use Apple Pay
	// checks if device hardware is capable of using Apple Pay
	// checks if the device has a payment card setup

	return (self.merchantID.length &&
			[self canMakePayments] &&
			[self canMakePaymentsUsingNetworks:self.supportedNetworks]);
}

- (BOOL)canShowApplePaySetup
{
	PKPassLibrary *passLibrary = [[PKPassLibrary alloc] init];
	if ([passLibrary respondsToSelector:@selector(canAddPaymentPassWithPrimaryAccountIdentifier:)] &&
		// Check if the device can add a payment pass
		[self.merchantID length]) {
		return [self canMakePayments];
	} else {
		return NO;
	}
}

- (BOOL)canMakePayments
{
	return [self.applePayControllerClass canMakePayments];
}

- (BOOL)canMakePaymentsUsingNetworks:(NSArray<PKPaymentNetwork> *)supportedNetworks
{
	return [self.applePayControllerClass canMakePaymentsUsingNetworks:supportedNetworks];
}

- (void)proceedWithApplePay
{
	self.applePayAuthorizationDelegate = [[BUYApplePayAuthorizationDelegate alloc] initWithClient:self.client checkout:self.checkout shopName:self.shop.name];

	PKPaymentRequest *request = [self paymentRequest];
	request.paymentSummaryItems = [self.checkout buy_summaryItemsWithShopName:self.shop.name];
	
	id controller = [[self.applePayControllerClass alloc] initWithPaymentRequest:request];
	[self presentPaymentController:controller];
}

- (PKPaymentRequest *)paymentRequest
{
	PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
	
	[paymentRequest setMerchantIdentifier:self.merchantID];
	[paymentRequest setRequiredBillingAddressFields:PKAddressFieldAll];
	[paymentRequest setRequiredShippingAddressFields:self.checkout.requiresShippingValue ? PKAddressFieldAll : PKAddressFieldEmail|PKAddressFieldPhone];
	[paymentRequest setSupportedNetworks:self.supportedNetworks];
	[paymentRequest setMerchantCapabilities:PKMerchantCapability3DS];
	[paymentRequest setCountryCode:self.shop.country];
	[paymentRequest setCurrencyCode:self.shop.currency];
	
	return paymentRequest;
}

- (NSArray *)supportedNetworks
{
	if (_supportedNetworks == nil) {
		#if TARGET_OS_WATCH
		self.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa, PKPaymentNetworkDiscover];
		#else
		if (&PKPaymentNetworkDiscover != NULL) {
			self.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa, PKPaymentNetworkDiscover];
		} else {
			self.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
		}
		#endif
	}
	
	return _supportedNetworks;
}

#pragma mark - PKPaymentAuthorization Helper Methods

- (void)handleAuthorizedPaymentCompletionWithStatus:(PKPaymentAuthorizationStatus)status
{
	self.paymentAuthorizationStatus = status;
	switch (status) {
		case PKPaymentAuthorizationStatusFailure:
			if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
				[self.delegate paymentProvider:self didFailWithError:self.applePayAuthorizationDelegate.lastError];
			}
			[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailCheckoutNotificationKey object:self];
			break;
			
		case PKPaymentAuthorizationStatusInvalidShippingPostalAddress:
			if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
				[self.delegate paymentProvider:self didFailWithError:self.applePayAuthorizationDelegate.lastError];
			}
			[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailToUpdateCheckoutNotificationKey object:self];
			break;
			
		default:
			break;
	}
	self.checkout = self.applePayAuthorizationDelegate.checkout;
}

- (void)paymentAuthorizationDidFinish
{
	[self.delegate paymentProviderWantsControllerDismissed:self];
	
	BUYStatus status = (self.paymentAuthorizationStatus == PKPaymentAuthorizationStatusSuccess) ? BUYStatusComplete : BUYStatusFailed;
	if ([self.delegate respondsToSelector:@selector(paymentProvider:didCompleteCheckout:withStatus:)]) {
		[self.delegate paymentProvider:self didCompleteCheckout:self.checkout withStatus:status];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidCompleteCheckoutNotificationKey object:self];
	
	self.inProgress = NO;
}

- (void)paymentAuthorizationDidUpdateAddressWithStatus:(PKPaymentAuthorizationStatus)status
{
	if (status == PKPaymentAuthorizationStatusInvalidShippingPostalAddress) {
		if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
			[self.delegate paymentProvider:self didFailWithError:self.applePayAuthorizationDelegate.lastError];
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailToUpdateCheckoutNotificationKey object:self];
	}
}

- (void)presentPaymentController:(id)controller
{
	if (controller) {
		[controller setDelegate:self];
		if ([self.applePayControllerClass isSubclassOfClass:[PKPaymentAuthorizationController class]]) {
			if ([self.delegate respondsToSelector:@selector(paymentProvider:wantsPaymentControllerPresented:)]) {
				[self.delegate paymentProvider:self wantsPaymentControllerPresented:controller];
			} else {
				[controller presentWithCompletion:nil];
			}
		} else {
			#if !TARGET_OS_WATCH
			[self.delegate paymentProvider:self wantsControllerPresented:controller];
			#endif
		}
	}
	else {
		if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
			[self.delegate paymentProvider:self didFailWithError:nil];
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailCheckoutNotificationKey object:self];
	}
}

#pragma mark - PKPaymentAuthorizationControllerDelegate Methods

- (void)paymentAuthorizationController:(PKPaymentAuthorizationController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
	[self.applePayAuthorizationDelegate paymentAuthorizationController:controller didAuthorizePayment:payment completion:^(PKPaymentAuthorizationStatus status) {
		[self handleAuthorizedPaymentCompletionWithStatus:status];
		completion(status);
	}];
}

- (void)paymentAuthorizationControllerDidFinish:(PKPaymentAuthorizationController *)controller
{
	[controller dismissWithCompletion:nil];
	[self paymentAuthorizationDidFinish];
}

- (void)paymentAuthorizationController:(PKPaymentAuthorizationController *)controller didSelectShippingMethod:(PKShippingMethod *)shippingMethod completion:(BUYShippingMethodCompletion)completion
{
	[self.applePayAuthorizationDelegate paymentAuthorizationController:controller didSelectShippingMethod:shippingMethod completion:^(PKPaymentAuthorizationStatus status, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		if (status == PKPaymentAuthorizationStatusInvalidShippingPostalAddress) {
			if ([self.delegate respondsToSelector:@selector(paymentProvider:didFailWithError:)]) {
				[self.delegate paymentProvider:self didFailWithError:self.applePayAuthorizationDelegate.lastError];
			}
			[[NSNotificationCenter defaultCenter] postNotificationName:BUYPaymentProviderDidFailToUpdateCheckoutNotificationKey object:self];
		}
		completion(status, summaryItems);
	}];
}

- (void)paymentAuthorizationController:(PKPaymentAuthorizationController *)controller didSelectShippingContact:(PKContact *)contact completion:(BUYAddressUpdateCompletion)completion
{
	[self.applePayAuthorizationDelegate paymentAuthorizationController:controller didSelectShippingContact:contact completion:^(PKPaymentAuthorizationStatus status, NSArray<PKShippingMethod *> * _Nonnull shippingMethods, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		[self paymentAuthorizationDidUpdateAddressWithStatus:status];
		completion(status, shippingMethods, summaryItems);
	}];
}

#if !TARGET_OS_WATCH
#pragma mark - PKPaymentAuthorizationViewControllerDelegate Methods

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	[self.applePayAuthorizationDelegate paymentAuthorizationViewController:controller didAuthorizePayment:payment completion:^(PKPaymentAuthorizationStatus status) {
		[self handleAuthorizedPaymentCompletionWithStatus:status];
		completion(status);
	}];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
	[self paymentAuthorizationDidFinish];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingMethod:(nonnull PKShippingMethod *)shippingMethod completion:(BUYShippingMethodCompletion)completion
{
	[self.applePayAuthorizationDelegate paymentAuthorizationViewController:controller didSelectShippingMethod:shippingMethod completion:^(PKPaymentAuthorizationStatus status, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		[self paymentAuthorizationDidUpdateAddressWithStatus:status];
		completion(status, summaryItems);
	}];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingAddress:(ABRecordRef)address completion:(BUYAddressUpdateCompletion)completion
{
	[self.applePayAuthorizationDelegate paymentAuthorizationViewController:controller didSelectShippingAddress:address completion:^(PKPaymentAuthorizationStatus status, NSArray<PKShippingMethod *> * _Nonnull shippingMethods, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		[self paymentAuthorizationDidUpdateAddressWithStatus:status];
		completion(status, shippingMethods, summaryItems);
	}];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingContact:(PKContact *)contact completion:(BUYAddressUpdateCompletion)completion
{
	[self.applePayAuthorizationDelegate paymentAuthorizationViewController:controller didSelectShippingContact:contact completion:^(PKPaymentAuthorizationStatus status, NSArray<PKShippingMethod *> * _Nonnull shippingMethods, NSArray<PKPaymentSummaryItem *> * _Nonnull summaryItems) {
		[self paymentAuthorizationDidUpdateAddressWithStatus:status];
		completion(status, shippingMethods, summaryItems);
	}];
}
#endif

@end

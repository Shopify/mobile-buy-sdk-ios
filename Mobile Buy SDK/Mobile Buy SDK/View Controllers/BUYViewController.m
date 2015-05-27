//
//  BUYViewController.m
//  Mobile Buy SDK
//
//  Created by Joshua Tessier on 2015-02-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import AddressBook;
@import PassKit;
#import "BUYApplePayAdditions.h"
#import "BUYCart.h"
#import "BUYClient.h"
#import "BUYViewController.h"
#import "BUYApplePayHelpers.h"

@interface BUYViewController () <PKPaymentAuthorizationViewControllerDelegate>
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *provider;
@property (nonatomic, strong) BUYApplePayHelpers *applePayHelper;
@end

@implementation BUYViewController

- (instancetype)initWithDataProvider:(BUYClient *)dataProvider
{
	self = [super init];
	if (self) {
		
		self.provider = dataProvider;
		
		self.merchantCapability = PKMerchantCapability3DS;
		self.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
		self.countryCode = @"US";
		self.currencyCode = @"USD";
	}
	return self;
}


#pragma mark - Checkout Flow Methods
#pragma mark - Step 1 - Creating a Checkout

- (void)startCheckoutWithCart:(BUYCart *)cart
{
	[_provider createCheckout:[[BUYCheckout alloc] initWithCart:cart] completion:^(BUYCheckout *checkout, NSError *error) {
		
		self.applePayHelper = [[BUYApplePayHelpers alloc] initWithClient:self.provider checkout:checkout];
		[self handleCheckoutCompletion:checkout error:error];
	}];
}

#pragma  mark - Alternative Step 1 - Creating a Checkout using a Cart Token

- (void)startCheckoutWithCartToken:(NSString *)token
{
	[_provider createCheckoutWithCartToken:token completion:^(BUYCheckout *checkout, NSError *error) {
		self.applePayHelper = [[BUYApplePayHelpers alloc] initWithClient:self.provider checkout:checkout];
		[self handleCheckoutCompletion:checkout error:error];
	}];
}

- (void)handleCheckoutCompletion:(BUYCheckout *)checkout error:(NSError *)error
{
	if (checkout && error == nil) {
		_checkout = checkout;
		[self requestPayment];
	}
	else {
		[_delegate controller:self failedToCreateCheckout:error];
	}
}

#pragma mark - Step 2 - Requesting Payment using ApplePay

- (void)requestPayment
{
	//Step 2 - Request payment from the user by presenting an Apple Pay sheet
	if (self.provider.merchantId.length == 0) {
		NSLog(@"Merchant ID must be configured to use Apple Pay");
		[_delegate controllerFailedToStartApplePayProcess:self];
		return;
	}
	
	PKPaymentRequest *request = [self paymentRequest];
	request.paymentSummaryItems = [_checkout buy_summaryItems];
	PKPaymentAuthorizationViewController *controller = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
	if (controller) {
		controller.delegate = self;
		[self presentViewController:controller animated:YES completion:nil];
	}
	else {
		[_delegate controllerFailedToStartApplePayProcess:self];
	}
}

- (void)checkoutCompleted:(BUYCheckout *)checkout status:(BUYStatus)status
{
	[_delegate controller:self didCompleteCheckout:checkout status:status];
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate Methods

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	[self.applePayHelper updateAndCompleteCheckoutWithPayment:payment completion:^(PKPaymentAuthorizationStatus status) {
		
		BUYStatus buyStatus = BUYStatusComplete;
		
		switch (status) {
			case PKPaymentAuthorizationStatusFailure:
			case PKPaymentAuthorizationStatusInvalidShippingPostalAddress:
				[_delegate controller:self failedToCompleteCheckout:self.checkout withError:self.applePayHelper.lastError];
				buyStatus = BUYStatusFailed;
				
			default:
				[_delegate controller:self didCompleteCheckout:self.checkout status:buyStatus];
				completion(status);
				break;
		}
	}];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
	//The checkout is done at this point, it may have succeeded or failed. You are responsible for dealing with failure/success earlier in the steps.
	
	[controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *summaryItems))completion
{
	[self.applePayHelper updateCheckoutWithShippingMethod:shippingMethod completion:^(PKPaymentAuthorizationStatus status, NSArray *methods) {
		
		if (status == PKPaymentAuthorizationStatusInvalidShippingPostalAddress) {
			[_delegate controller:self failedToGetShippingRates:_checkout withError:self.applePayHelper.lastError];
		}
		
		completion(status, methods);
	}];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	[self.applePayHelper updateCheckoutWithAddress:address completion:^(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems) {
		
		if (status == PKPaymentAuthorizationStatusInvalidShippingPostalAddress) {
			[_delegate controller:self failedToUpdateCheckout:self.checkout withError:self.applePayHelper.lastError];
		}
		completion(status, shippingMethods, summaryItems);
	}];
}

#pragma mark - Helpers

- (PKPaymentRequest *)paymentRequest
{
	PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
	[paymentRequest setMerchantIdentifier:self.provider.merchantId];
	[paymentRequest setRequiredBillingAddressFields:PKAddressFieldAll];
	[paymentRequest setRequiredShippingAddressFields:_checkout.requiresShipping ? PKAddressFieldAll : PKAddressFieldEmail];
	[paymentRequest setSupportedNetworks:self.supportedNetworks];
	[paymentRequest setMerchantCapabilities:self.merchantCapability];
	[paymentRequest setCountryCode:self.countryCode];
	[paymentRequest setCurrencyCode:self.currencyCode];
	return paymentRequest;
}

@end

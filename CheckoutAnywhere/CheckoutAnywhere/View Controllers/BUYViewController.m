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

#define kPollDelay 0.5f

#define CFSafeRelease(obj) if (obj) { CFRelease(obj); }

@interface BUYViewController () <PKPaymentAuthorizationViewControllerDelegate>
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *provider;
@property (nonatomic, strong) NSArray *shippingRates;
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
		[self handleCheckoutCompletion:checkout error:error];
	}];
}

#pragma  mark - Alternative Step 1 - Creating a Checkout using a Cart Token

- (void)startCheckoutWithCartToken:(NSString *)token
{
	[_provider createCheckoutWithCartToken:token completion:^(BUYCheckout *checkout, NSError *error) {
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

#pragma mark - Step 3 - Fetching Shipping Rates Using ApplePay's Partial Address

- (void)updateCheckoutWithAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *, NSArray *))completion
{
	//Step 3- ApplePay only provides us a partial address at this point. This is done (presumably) so that developers cannot phish user information (full name, address) without their permission.
	
	_checkout.shippingAddress = [BUYAddress buy_addressFromRecord:address];
	[_provider updateCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			_checkout = checkout;
			[self getShippingRates:_checkout completion:completion];
		}
		else {
			[_delegate controller:self failedToUpdateCheckout:checkout withError:error];
			completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [_checkout buy_summaryItems]);
		}
	}];
}

#pragma mark - Step 4 - Fetch Shipping Rates and Default to the First One

- (void)fetchShippingRates:(void (^)(PKPaymentAuthorizationStatus, NSArray *, NSArray *))completion
{
	//Step 4 - Fetch shipping rates. This may take several seconds to get back from our shipping providers. You have to poll here.
	_shippingRates = @[];
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	__block BUYStatus shippingStatus = BUYStatusUnknown;
	while (shippingStatus == BUYStatusUnknown || shippingStatus == BUYStatusProcessing) {
		[_provider getShippingRatesForCheckout:_checkout completion:^(NSArray *shippingRates, BUYStatus status, NSError *error) {
			shippingStatus = status;
			
			if (error) {
				[_delegate controller:self failedToGetShippingRates:_checkout withError:error];
				completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [_checkout buy_summaryItems]);
			}
			else if (status == BUYStatusComplete && [shippingRates count] == 0) {
				//You don't ship to this location
				[_delegate controller:self failedToGetShippingRates:_checkout withError:error];
				
				_checkout.shippingRate = nil;
				completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [_checkout buy_summaryItems]);
			}
			else if ((status == BUYStatusUnknown && error == nil) || status == BUYStatusComplete) { //We shouldn't add unkonown here, but this supports the case where we don't need shipping rates
				shippingStatus = BUYStatusComplete;
				
				_shippingRates = shippingRates;
			}
			
			dispatch_semaphore_signal(semaphore);
		}];
		
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		if (shippingStatus != BUYStatusComplete && shippingStatus != BUYStatusUnknown) {
			//ADjust as you see fit for your polling rate.
			[NSThread sleepForTimeInterval:kPollDelay];
		}
	}
}

#pragma mark - Step 5 - Update Checkout with Shipping Info

- (void)getShippingRates:(BUYCheckout *)checkout completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	//Step 5 - We're now fetching the rates from Shopify. This will will calculate shipping rates very similarly to how our web checkout.
	//We then turn our BUYShippingRate objects into PKShippingMethods for Apple to present to the user.
	
	if ([_checkout requiresShipping] == NO) {
		completion(PKPaymentAuthorizationStatusSuccess, nil, [_checkout buy_summaryItems]);
	}
	else {
		[self fetchShippingRates:completion];
		
		NSArray *shippingMethods = [BUYShippingRate buy_convertShippingRatesToShippingMethods:_shippingRates];
		if ([shippingMethods count] > 0) {
			[self selectShippingMethod:shippingMethods[0] completion:^(BUYCheckout *checkout, NSError *error) {
				if (checkout && error == nil) {
					_checkout = checkout;
				}
				completion(error ? PKPaymentAuthorizationStatusFailure : PKPaymentAuthorizationStatusSuccess, shippingMethods, [_checkout buy_summaryItems]);
			}];
		}
		else {
			completion(PKPaymentAuthorizationStatusSuccess, nil, [_checkout buy_summaryItems]);
		}
	}
}

- (void)updateCheckoutWithShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *))completion
{
	//Step 5B -- Update the checkout with the selected shipping rate. This is called when a user selects an alternative rate (or double-selects the same one)
	
	[self selectShippingMethod:shippingMethod completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			_checkout = checkout;
		}
		completion(error == nil ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure, [_checkout buy_summaryItems]);
	}];
}

- (void)selectShippingMethod:(PKShippingMethod *)shippingMethod completion:(BUYDataCheckoutBlock)block
{
	BUYShippingRate *shippingRate = [self rateForShippingMethod:shippingMethod];
	_checkout.shippingRate = shippingRate;
	
	[_provider updateCheckout:_checkout completion:block];
}

#pragma mark - Step 6 - Complete Checkout

- (void)updateAndCompleteCheckoutWithPayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
	//Step 6 - Update the checkout with the rest of the information. Apple has now provided us with a FULL billing address and a FULL shipping address.
	//We now update the checkout with our new found data so that you can ship the products to the right address, and we collect whatever else we need.
	
	_checkout.shippingAddress = _checkout.requiresShipping ? [BUYAddress buy_addressFromRecord:[payment shippingAddress]] : nil;
	_checkout.billingAddress = [BUYAddress buy_addressFromRecord:[payment billingAddress]];
	_checkout.email = [BUYAddress buy_emailFromRecord:[payment billingAddress]];
	if (_checkout.email == nil) {
		_checkout.email = [BUYAddress buy_emailFromRecord:[payment shippingAddress]];
	}
	
	[_provider updateCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			_checkout = checkout;
			
			//Now that the checkout is up to date, call complete.
			[_provider completeCheckout:checkout withApplePayToken:payment.token completion:^(BUYCheckout *checkout, NSError *error) {
				if (checkout && error == nil) {
					_checkout = checkout;
					
					[self pollUntilCheckoutIsComplete:_checkout completion:completion];
				}
				else {
					[_delegate controller:self failedToCompleteCheckout:_checkout withError:error];
					
					completion(PKPaymentAuthorizationStatusFailure);
				}
			}];
		}
		else {
			[_delegate controller:self failedToUpdateCheckout:_checkout withError:error];
			
			completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress);
		}
	}];
}

#pragma mark - Step 7 - Poll Until Complete

- (void)pollUntilCheckoutIsComplete:(BUYCheckout *)checkout completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	//Step 7 - Poll until done. At this point, we've sent the payment information to the Payment Gateway for your shop, and we're waiting for it to come back.
	//This is sometimes a slow process, so we need to poll until we've received confirmation that money has been authorized or captured.
	
	__block BUYStatus checkoutStatus = BUYStatusUnknown;
	__block BUYCheckout *completedCheckout = nil;
	__block NSError *error = nil;
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	
	while (checkout.token && checkoutStatus != BUYStatusFailed && checkoutStatus != BUYStatusComplete) {
		[_provider getCompletionStatusOfCheckout:_checkout completion:^(BUYCheckout *checkout, BUYStatus status, NSError *err) {
			completedCheckout = checkout;
			checkoutStatus = status;
			error = err;
			dispatch_semaphore_signal(semaphore);
		}];
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		
		if (checkoutStatus != BUYStatusComplete) {
			[NSThread sleepForTimeInterval:kPollDelay];
		}
	}
	completion(checkoutStatus == BUYStatusComplete ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure);
	
	if (error) {
		[_delegate controller:self failedToCompleteCheckout:checkout withError:error	];
	}
	else {
		[self checkoutCompleted:completedCheckout status:checkoutStatus];
	}
}

- (void)checkoutCompleted:(BUYCheckout *)checkout status:(BUYStatus)status
{
	[_delegate controller:self didCompleteCheckout:checkout status:status];
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate Methods

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	[self updateAndCompleteCheckoutWithPayment:payment completion:completion];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
	//The checkout is done at this point, it may have succeeded or failed. You are responsible for dealing with failure/success earlier in the steps.
	
	[controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *summaryItems))completion
{
	[self updateCheckoutWithShippingMethod:shippingMethod completion:completion];
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	[self updateCheckoutWithAddress:address completion:completion];
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

- (BUYShippingRate *)rateForShippingMethod:(PKShippingMethod *)method
{
	BUYShippingRate *rate = nil;
	NSString *identifier = [method identifier];
	for (BUYShippingRate *method in _shippingRates) {
		if ([[method shippingRateIdentifier] isEqual:identifier]) {
			rate = method;
			break;
		}
	}
	return rate;
}

@end

//
//  CHKViewController.m
//  Checkout
//
//  Created by Joshua Tessier on 2015-02-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKViewController.h"

@import AddressBook;
@import PassKit;

//Other
#import "CHKApplePayAdditions.h"
#import "CHKDataProvider.h"
#import "CHKCart.h"

#define kPollDelay 0.5f

#define CFSafeRelease(obj) if (obj) { CFRelease(obj); }

@interface CHKViewController () <PKPaymentAuthorizationViewControllerDelegate>
@end

@implementation CHKViewController {
    CHKCheckout *_checkout;
    NSArray *_shippingRates;
    NSString *_merchantId;
}

- (instancetype)initWithShopAddress:(NSString *)shopAddress apiKey:(NSString *)apiKey merchantId:(NSString *)merchantId
{
    self = [super init];
    if (self) {
		if (shopAddress == nil || apiKey == nil) {
			NSException *exception = [NSException exceptionWithName:@"Missing keys" reason:@"Please ensure you initialize with a shop address, API key. The Merchant ID is optional and only needed for Apple Pay support" userInfo:@{ @"Shop Address" : shopAddress ?: @"", @"API key" : apiKey ?: @""}];
			@throw exception;
		}
        
        _provider = [[CHKDataProvider alloc] initWithShopDomain:shopAddress apiKey:apiKey];
        _merchantId = merchantId;
        
        self.merchantCapability = PKMerchantCapability3DS;
        self.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
        self.countryCode = @"US";
        self.currencyCode = @"USD";
    }
    return self;
}

#pragma mark - Checkout Flow Methods
#pragma mark - Step 1 - Creating a Checkout

- (void)startCheckoutWithCart:(CHKCart *)cart
{
	[_provider createCheckout:[[CHKCheckout alloc] initWithCart:cart] completion:^(CHKCheckout *checkout, NSError *error) {
		[self handleCheckoutCompletion:checkout error:error];
	}];
}

#pragma  mark - Alternative Step 1 - Creating a Checkout using a Cart Token

- (void)startCheckoutWithCartToken:(NSString *)token
{
	[_provider createCheckoutWithCartToken:token completion:^(CHKCheckout *checkout, NSError *error) {
		[self handleCheckoutCompletion:checkout error:error];
	}];
}

- (void)handleCheckoutCompletion:(CHKCheckout *)checkout error:(NSError *)error
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
	
	PKPaymentRequest *request = [self paymentRequest];
	request.paymentSummaryItems = [_checkout chk_summaryItems];
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
	
	_checkout.shippingAddress = [CHKAddress chk_addressFromRecord:address];
	[_provider updateCheckout:_checkout completion:^(CHKCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			_checkout = checkout;
			[self getShippingRates:_checkout completion:completion];
		}
		else {
			[_delegate controller:self failedToUpdateCheckout:checkout withError:error];
			completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [_checkout chk_summaryItems]);
		}
	}];
}

#pragma mark - Step 4 - Fetch Shipping Rates and Default to the First One

- (void)fetchShippingRates:(void (^)(PKPaymentAuthorizationStatus, NSArray *, NSArray *))completion
{
	//Step 4 - Fetch shipping rates. This may take several seconds to get back from our shipping providers. You have to poll here.
	_shippingRates = @[];
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	__block CHKStatus shippingStatus = CHKStatusUnknown;
	while (shippingStatus == CHKStatusUnknown || shippingStatus == CHKStatusProcessing) {
		[_provider getShippingRatesForCheckout:_checkout completion:^(NSArray *shippingRates, CHKStatus status, NSError *error) {
			shippingStatus = status;
			
			if (error) {
				[_delegate controller:self failedToGetShippingRates:_checkout withError:error];
				completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [_checkout chk_summaryItems]);
			}
			else if (status == CHKStatusComplete && [shippingRates count] == 0) {
				//You don't ship to this location
				[_delegate controller:self failedToGetShippingRates:_checkout withError:error];
				
				_checkout.shippingRate = nil;
				completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [_checkout chk_summaryItems]);
			}
			else if ((status == CHKStatusUnknown && error == nil) || status == CHKStatusComplete) { //We shouldn't add unkonown here, but this supports the case where we don't need shipping rates
				shippingStatus = CHKStatusComplete;
				
				_shippingRates = shippingRates;
			}
			
			dispatch_semaphore_signal(semaphore);
		}];
		
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		if (shippingStatus != CHKStatusComplete && shippingStatus != CHKStatusUnknown) {
			//ADjust as you see fit for your polling rate.
			[NSThread sleepForTimeInterval:kPollDelay];
		}
	}
}

#pragma mark - Step 5 - Update Checkout with Shipping Info

- (void)getShippingRates:(CHKCheckout *)checkout completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	//Step 5 - We're now fetching the rates from Shopify. This will will calculate shipping rates very similarly to how our web checkout.
	//We then turn our CHKShippingRate objects into PKShippingMethods for Apple to present to the user.
	
	if ([_checkout requiresShipping] == NO) {
		completion(PKPaymentAuthorizationStatusSuccess, nil, [_checkout chk_summaryItems]);
	}
	else {
		[self fetchShippingRates:completion];
		
		NSArray *shippingMethods = [CHKShippingRate chk_convertShippingRatesToShippingMethods:_shippingRates];
		if ([shippingMethods count] > 0) {
			[self selectShippingMethod:shippingMethods[0] completion:^(CHKCheckout *checkout, NSError *error) {
				if (checkout && error == nil) {
					_checkout = checkout;
				}
				completion(error ? PKPaymentAuthorizationStatusFailure : PKPaymentAuthorizationStatusSuccess, shippingMethods, [_checkout chk_summaryItems]);
			}];
		}
		else {
			completion(PKPaymentAuthorizationStatusSuccess, nil, [_checkout chk_summaryItems]);
		}
	}
}

- (void)updateCheckoutWithShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *))completion
{
	//Step 5B -- Update the checkout with the selected shipping rate. This is called when a user selects an alternative rate (or double-selects the same one)
	
	[self selectShippingMethod:shippingMethod completion:^(CHKCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			_checkout = checkout;
		}
		completion(error == nil ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure, [_checkout chk_summaryItems]);
	}];
}

- (void)selectShippingMethod:(PKShippingMethod *)shippingMethod completion:(CHKDataCheckoutBlock)block
{
	CHKShippingRate *shippingRate = [self rateForShippingMethod:shippingMethod];
	_checkout.shippingRate = shippingRate;
	
	[_provider updateCheckout:_checkout completion:block];
}

#pragma mark - Step 6 - Complete Checkout

- (void)updateAndCompleteCheckoutWithPayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
	//Step 6 - Update the checkout with the rest of the information. Apple has now provided us with a FULL billing address and a FULL shipping address.
	//We now update the checkout with our new found data so that you can ship the products to the right address, and we collect whatever else we need.
	
	_checkout.shippingAddress = [CHKAddress chk_addressFromRecord:[payment shippingAddress]];
	_checkout.billingAddress = [CHKAddress chk_addressFromRecord:[payment billingAddress]];
	_checkout.email = [CHKAddress chk_emailFromRecord:[payment billingAddress]];
	if (_checkout.email == nil) {
		_checkout.email = [CHKAddress chk_emailFromRecord:[payment shippingAddress]];
	}
	
	[_provider updateCheckout:_checkout completion:^(CHKCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			_checkout = checkout;
			
			//Now that the checkout is up to date, call complete.
			[_provider completeCheckout:checkout withApplePayToken:payment.token completion:^(CHKCheckout *checkout, NSError *error) {
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

- (void)pollUntilCheckoutIsComplete:(CHKCheckout *)checkout completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	//Step 7 - Poll until done. At this point, we've sent the payment information to the Payment Gateway for your shop, and we're waiting for it to come back.
	//This is sometimes a slow process, so we need to poll until we've received confirmation that money has been authorized or captured.
	
	__block CHKStatus checkoutStatus = CHKStatusUnknown;
	__block CHKCheckout *completedCheckout = nil;
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	
	while (checkout.token && checkoutStatus != CHKStatusFailed && checkoutStatus != CHKStatusComplete) {
		[_provider getCompletionStatusOfCheckout:_checkout completion:^(CHKCheckout *checkout, CHKStatus status, NSError *error) {
			completedCheckout = checkout;
			checkoutStatus = status;
			dispatch_semaphore_signal(semaphore);
		}];
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		
		if (checkoutStatus != CHKStatusComplete) {
			[NSThread sleepForTimeInterval:kPollDelay];
		}
	}
	completion(checkoutStatus == CHKStatusComplete ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure);
	
	[self checkoutCompleted:completedCheckout status:checkoutStatus];
}

- (void)checkoutCompleted:(CHKCheckout *)checkout status:(CHKStatus)status
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
	[paymentRequest setMerchantIdentifier:_merchantId];
	[paymentRequest setRequiredBillingAddressFields:PKAddressFieldAll];
	[paymentRequest setRequiredShippingAddressFields:_checkout.requiresShipping ? PKAddressFieldAll : PKAddressFieldPostalAddress];
	[paymentRequest setSupportedNetworks:self.supportedNetworks];
	[paymentRequest setMerchantCapabilities:self.merchantCapability];
	[paymentRequest setCountryCode:self.countryCode];
	[paymentRequest setCurrencyCode:self.currencyCode];
	return paymentRequest;
}

- (CHKShippingRate *)rateForShippingMethod:(PKShippingMethod *)method
{
	CHKShippingRate *rate = nil;
	NSString *identifier = [method identifier];
	for (CHKShippingRate *method in _shippingRates) {
		if ([[method shippingRateIdentifier] isEqual:identifier]) {
			rate = method;
			break;
		}
	}
	return rate;
}

@end

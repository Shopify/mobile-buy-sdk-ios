//
//  BUYApplePayHelpers.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-05-27.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYApplePayHelpers.h"
#import "BUYClient.h"
#import "BUYCheckout.h"
#import "BUYApplePayAdditions.h"

#define kPollDelay 0.5f

@interface BUYApplePayHelpers ()
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@property (nonatomic, strong) NSArray *shippingRates;
@property (nonatomic, strong) NSError *lastError;

@end

@implementation BUYApplePayHelpers

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout
{
	self = [super init];
	
	if (self) {
		self.client = client;
		self.checkout = checkout;
	}
	
	return self;
}

- (void)updateAndCompleteCheckoutWithPayment:(PKPayment *)payment
								  completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
	// Update the checkout with the rest of the information. Apple has now provided us with a FULL billing address and a FULL shipping address.
	// We now update the checkout with our new found data so that you can ship the products to the right address, and we collect whatever else we need.
	
	self.checkout.shippingAddress = self.checkout.requiresShipping ? [BUYAddress buy_addressFromRecord:[payment shippingAddress]] : nil;
	self.checkout.billingAddress = [BUYAddress buy_addressFromRecord:[payment billingAddress]];
	self.checkout.email = [BUYAddress buy_emailFromRecord:[payment billingAddress]];
	if (self.checkout.email == nil) {
		self.checkout.email = [BUYAddress buy_emailFromRecord:[payment shippingAddress]];
	}
	
	[self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			self.checkout = checkout;
			
			//Now that the checkout is up to date, call complete.
			[self.client completeCheckout:checkout withApplePayToken:payment.token completion:^(BUYCheckout *checkout, NSError *error) {
				if (checkout && error == nil) {
					self.checkout = checkout;
					
					[self pollUntilCheckoutIsComplete:self.checkout completion:completion];
				}
				else {
					self.lastError = error;
					completion(PKPaymentAuthorizationStatusFailure);
				}
			}];
		}
		else {
			self.lastError = error;
			completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress);
		}
	}];
}

- (void)updateCheckoutWithShippingMethod:(PKShippingMethod *)shippingMethod
							  completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *methods))completion
{
	BUYShippingRate *shippingRate = [self rateForShippingMethod:shippingMethod];
	self.checkout.shippingRate = shippingRate;
	
	[self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			self.checkout = checkout;
		}
		else {
			self.lastError = error;
		}
		completion(error == nil ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure, [self.checkout buy_summaryItems]);
	}];
}

- (void)updateCheckoutWithAddress:(ABRecordRef)address
					   completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	self.checkout.shippingAddress = [BUYAddress buy_addressFromRecord:address];
	[self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			self.checkout = checkout;
			[self getShippingRates:self.checkout completion:completion];
		}
		else {
			self.lastError = error;
			completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [self.checkout buy_summaryItems]);
		}
	}];
}

#pragma mark - internal

- (void)pollUntilCheckoutIsComplete:(BUYCheckout *)checkout completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	//Step 7 - Poll until done. At this point, we've sent the payment information to the Payment Gateway for your shop, and we're waiting for it to come back.
	//This is sometimes a slow process, so we need to poll until we've received confirmation that money has been authorized or captured.
	
	__block BUYStatus checkoutStatus = BUYStatusUnknown;
	__block BUYCheckout *completedCheckout = nil;
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	
	while (checkout.token && checkoutStatus != BUYStatusFailed && checkoutStatus != BUYStatusComplete) {
		[self.client getCompletionStatusOfCheckout:self.checkout completion:^(BUYCheckout *checkout, BUYStatus status, NSError *error) {
			completedCheckout = checkout;
			checkoutStatus = status;
			dispatch_semaphore_signal(semaphore);
		}];
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		
		if (checkoutStatus != BUYStatusComplete) {
			[NSThread sleepForTimeInterval:kPollDelay];
		}
	}
	completion(checkoutStatus == BUYStatusComplete ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure);
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

- (void)getShippingRates:(BUYCheckout *)checkout completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	//Step 5 - We're now fetching the rates from Shopify. This will will calculate shipping rates very similarly to how our web checkout.
	//We then turn our BUYShippingRate objects into PKShippingMethods for Apple to present to the user.
	
	if ([self.checkout requiresShipping] == NO) {
		completion(PKPaymentAuthorizationStatusSuccess, nil, [self.checkout buy_summaryItems]);
	}
	else {
		[self fetchShippingRates:completion];
		
		NSArray *shippingMethods = [BUYShippingRate buy_convertShippingRatesToShippingMethods:_shippingRates];
		if ([shippingMethods count] > 0) {
			[self selectShippingMethod:shippingMethods[0] completion:^(BUYCheckout *checkout, NSError *error) {
				if (checkout && error == nil) {
					self.checkout = checkout;
				}
				completion(error ? PKPaymentAuthorizationStatusFailure : PKPaymentAuthorizationStatusSuccess, shippingMethods, [self.checkout buy_summaryItems]);
			}];
		}
		else {
			completion(PKPaymentAuthorizationStatusSuccess, nil, [self.checkout buy_summaryItems]);
		}
	}
}

- (void)fetchShippingRates:(void (^)(PKPaymentAuthorizationStatus, NSArray *, NSArray *))completion
{
	//Step 4 - Fetch shipping rates. This may take several seconds to get back from our shipping providers. You have to poll here.
	self.shippingRates = @[];
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	__block BUYStatus shippingStatus = BUYStatusUnknown;
	while (shippingStatus == BUYStatusUnknown || shippingStatus == BUYStatusProcessing) {
		[self.client getShippingRatesForCheckout:self.checkout completion:^(NSArray *shippingRates, BUYStatus status, NSError *error) {
			shippingStatus = status;
			
			if (error) {
				completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [self.checkout buy_summaryItems]);
			}
			else if (status == BUYStatusComplete && [shippingRates count] == 0) {
				//You don't ship to this location
				self.checkout.shippingRate = nil;
				completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [self.checkout buy_summaryItems]);
			}
			else if ((status == BUYStatusUnknown && error == nil) || status == BUYStatusComplete) { //We shouldn't add unkonown here, but this supports the case where we don't need shipping rates
				shippingStatus = BUYStatusComplete;
				
				self.shippingRates = shippingRates;
			}
			
			dispatch_semaphore_signal(semaphore);
		}];
		
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		if (shippingStatus != BUYStatusComplete && shippingStatus != BUYStatusUnknown) {
			//Adjust as you see fit for your polling rate.
			[NSThread sleepForTimeInterval:kPollDelay];
		}
	}
}

- (void)selectShippingMethod:(PKShippingMethod *)shippingMethod completion:(BUYDataCheckoutBlock)block
{
	BUYShippingRate *shippingRate = [self rateForShippingMethod:shippingMethod];
	self.checkout.shippingRate = shippingRate;
	
	[self.client updateCheckout:self.checkout completion:block];
}

@end

//
//  BUYApplePayHelpers.m
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

#import "BUYApplePayHelpers.h"
#import "BUYClient.h"
#import "BUYCheckout.h"
#import "BUYApplePayAdditions.h"
#import "BUYError.h"
#import "BUYAddress+Additions.h"
#import "BUYShop.h"

const NSTimeInterval PollDelay = 0.5;

@interface BUYApplePayHelpers ()
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@property (nonatomic, strong) NSArray *shippingRates;
@property (nonatomic, strong) NSError *lastError;

@property (nonatomic, strong) BUYShop *shop;

@end

@implementation BUYApplePayHelpers

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout
{
	return [self initWithClient:client checkout:checkout shop:nil];
}

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout shop:(BUYShop *)shop
{
	NSParameterAssert(client);
	NSParameterAssert(checkout);
	
	self = [super init];
	
	if (self) {
		self.client = client;
		self.checkout = checkout;
		
		// We need a shop object to display the business name in the pay sheet
		if (shop) {
			self.shop = shop;
		}
		else {
			[self.client getShop:^(BUYShop *shop, NSError *error) {
				
				if (shop) {
					self.shop = shop;
				}
			}];
		}
	}
	
	return self;
}


#pragma mark - PKPaymentAuthorizationDelegate methods

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
					   didAuthorizePayment:(PKPayment *)payment
								completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	// Update the checkout with the rest of the information. Apple has now provided us with a FULL billing address and a FULL shipping address.
	// We now update the checkout with our new found data so that you can ship the products to the right address, and we collect whatever else we need.

	if ([payment respondsToSelector:@selector(shippingContact)]) {
		self.checkout.email = payment.shippingContact.emailAddress;
		self.checkout.shippingAddress = self.checkout.requiresShipping ? [BUYAddress buy_addressFromContact:payment.shippingContact] : nil;
	} else {
		self.checkout.email = [BUYAddress buy_emailFromRecord:payment.shippingAddress];
		self.checkout.shippingAddress = self.checkout.requiresShipping ? [BUYAddress buy_addressFromRecord:payment.shippingAddress] : nil;
	}
	if ([payment respondsToSelector:@selector(billingContact)]) {
		self.checkout.billingAddress = [BUYAddress buy_addressFromContact:payment.billingContact];
	} else {
		self.checkout.billingAddress = [BUYAddress buy_addressFromRecord:payment.billingAddress];
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


- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
	[controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
	self.checkout.shippingAddress = [BUYAddress buy_addressFromRecord:address];
	[self updateCheckoutWithAddressCompletion:completion];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingContact:(PKContact *)contact completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
	self.checkout.shippingAddress = [BUYAddress buy_addressFromContact:contact];
	[self updateCheckoutWithAddressCompletion:completion];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
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
		completion(error == nil ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
	}];
}

#pragma mark -

- (void)updateCheckoutWithAddressCompletion:(void (^)(PKPaymentAuthorizationStatus, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	// This method call is internal to selection of shipping address that are returned as partial from PKPaymentAuthorizationViewController
	// However, to ensure we never set partialAddresses to NO, we want to guard the setter. Should PKPaymentAuthorizationViewController ever
	// return a full address through it's delegate method, this will still function since a complete address can be used to calculate shipping rates
	if ([self.checkout.shippingAddress isPartialAddress] == YES) {
		self.checkout.partialAddresses = YES;
	}
	
	if ([self.checkout.shippingAddress isValidAddressForShippingRates]) {
		
		[self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
			if (checkout && error == nil) {
				self.checkout = checkout;
				[self getShippingRates:self.checkout completion:completion];
			}
			else {
				self.lastError = error;
				completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
			}
		}];
	}
	else {
		completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
	}
}

- (void)updateAndCompleteCheckoutWithPayment:(PKPayment *)payment
								  completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
	// Since we're deprecating this method and the controller is not used in the delegate method, we can pass in a not-null PKPaymentAuthorizationViewController
	[self paymentAuthorizationViewController:[PKPaymentAuthorizationViewController new] didAuthorizePayment:payment completion:completion];
}

- (void)updateCheckoutWithShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *methods))completion
{
	// Since we're deprecating this method and the controller is not used in the delegate method, we can pass in a not-null PKPaymentAuthorizationViewController
	[self paymentAuthorizationViewController:[PKPaymentAuthorizationViewController new] didSelectShippingMethod:shippingMethod completion:completion];
}

- (void)updateCheckoutWithAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	// Since we're deprecating this method and the controller is not used in the delegate method, we can pass in a not-null PKPaymentAuthorizationViewController
	[self paymentAuthorizationViewController:[PKPaymentAuthorizationViewController new] didSelectShippingAddress:address completion:completion];
}

- (void)updateCheckoutWithContact:(PKContact*)contact completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *shippingMethods, NSArray *summaryItems))completion
{
	// Since we're deprecating this method and the controller is not used in the delegate method, we can pass in a not-null PKPaymentAuthorizationViewController
	[self paymentAuthorizationViewController:[PKPaymentAuthorizationViewController new] didSelectShippingContact:contact completion:completion];
}

#pragma mark - internal

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
	// We're now fetching the rates from Shopify. This will will calculate shipping rates very similarly to how our web checkout.
	// We then turn our BUYShippingRate objects into PKShippingMethods for Apple to present to the user.
	
	if ([self.checkout requiresShipping] == NO) {
		completion(PKPaymentAuthorizationStatusSuccess, nil, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
	}
	else {
		[self fetchShippingRates:^(PKPaymentAuthorizationStatus status, NSArray *methods, NSArray *summaryItems) {
			
			NSArray *shippingMethods = [BUYShippingRate buy_convertShippingRatesToShippingMethods:_shippingRates];
			if ([shippingMethods count] > 0) {
				[self selectShippingMethod:shippingMethods[0] completion:^(BUYCheckout *checkout, NSError *error) {
					if (checkout && error == nil) {
						self.checkout = checkout;
					}
					completion(error ? PKPaymentAuthorizationStatusFailure : PKPaymentAuthorizationStatusSuccess, shippingMethods, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
				}];
			}
			else {
				self.lastError = [NSError errorWithDomain:BUYShopifyError code:BUYShopifyError_NoShippingMethodsToAddress userInfo:nil];
				completion(status, nil, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
			}
		}];
	}
}

- (void)fetchShippingRates:(void (^)(PKPaymentAuthorizationStatus, NSArray *, NSArray *))completion
{
	// Fetch shipping rates. This may take several seconds to get back from our shipping providers. You have to poll here.
	self.shippingRates = @[];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
		__block BUYStatus shippingStatus = BUYStatusUnknown;
		do {
			[self.client getShippingRatesForCheckout:self.checkout completion:^(NSArray *shippingRates, BUYStatus status, NSError *error) {
				shippingStatus = status;

				if (error) {
					completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
				}
				else if (shippingStatus == BUYStatusComplete) {
					self.shippingRates = shippingRates;
					
					if ([self.shippingRates count] == 0) {
						// Shipping address is not supported and no shipping rates were returned
						if (completion) {
							completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, nil, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
						}
					} else {
						if (completion) {
							completion(PKPaymentAuthorizationStatusSuccess, self.shippingRates, [self.checkout buy_summaryItemsWithShopName:self.shop.name]);
						}
					}
					
				}
				
				dispatch_semaphore_signal(semaphore);
			}];
			
			dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
			if (shippingStatus != BUYStatusComplete && shippingStatus != BUYStatusUnknown) {
				// Adjust as you see fit for your polling rate.
				[NSThread sleepForTimeInterval:PollDelay];
			}
		} while (shippingStatus == BUYStatusProcessing);
	});
}

- (void)selectShippingMethod:(PKShippingMethod *)shippingMethod completion:(BUYDataCheckoutBlock)block
{
	BUYShippingRate *shippingRate = [self rateForShippingMethod:shippingMethod];
	self.checkout.shippingRate = shippingRate;
	
	[self.client updateCheckout:self.checkout completion:block];
}

- (void)pollUntilCheckoutIsComplete:(BUYCheckout *)checkout completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
	// Poll until done. At this point, we've sent the payment information to the Payment Gateway for your shop, and we're waiting for it to come back.
	// This is sometimes a slow process, so we need to poll until we've received confirmation that money has been authorized or captured.
	
	__block BUYStatus checkoutStatus = BUYStatusUnknown;
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
		
		while (checkout.token && checkoutStatus != BUYStatusFailed && checkoutStatus != BUYStatusComplete) {
			[self.client getCompletionStatusOfCheckout:self.checkout completion:^(BUYStatus status, NSError *error) {
				checkoutStatus = status;
				self.lastError = error;
				dispatch_semaphore_signal(semaphore);
			}];
			dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
			
			if (checkoutStatus != BUYStatusComplete) {
				[NSThread sleepForTimeInterval:PollDelay];
			}
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			completion(checkoutStatus == BUYStatusComplete ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure);
		});
	});
}

@end

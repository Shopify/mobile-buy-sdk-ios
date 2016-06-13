//
//  BUYApplePayAuthorizationDelegate.m
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

#import "BUYApplePayAuthorizationDelegate.h"
#import "BUYApplePayAdditions.h"
#import "BUYApplePayToken.h"
#import "BUYAssert.h"
#import "BUYClient+Checkout.h"
#import "BUYClient+Storefront.h"
#import "BUYCheckout.h"
#import "BUYError.h"
#import "BUYModelManager+ApplePay.h"
#import "BUYShop.h"
#import "BUYShopifyErrorCodes.h"

const NSTimeInterval PollDelay = 0.5;

typedef void (^AddressUpdateCompletion)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull);

@interface BUYApplePayAuthorizationDelegate ()

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) NSArray *shippingRates;
@property (nonatomic, strong) NSError *lastError;

@end

@implementation BUYApplePayAuthorizationDelegate

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout shopName:(NSString *)shopName
{
	BUYAssert(client, @"Failed to initialize BUYApplePayAuthorizationDelegate. Client must not be nil.");
	BUYAssert(checkout, @"Failed to initialize BUYApplePayAuthorizationDelegate. Checkout must not be nil.");
	BUYAssert(shopName, @"Failed to initialize BUYApplePayAuthorizationDelegate. Shop name must not be nil.");
	
	self = [super init];
	
	if (self) {
		_client = client;
		_checkout = checkout;
		_shopName = shopName;
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
		if (self.checkout.requiresShipping) {
			self.checkout.shippingAddress = [self buyAddressWithContact:payment.shippingContact];
		}
	} else {
		self.checkout.email = [BUYAddress buy_emailFromRecord:payment.shippingAddress];
		if (self.checkout.requiresShipping) {
			self.checkout.shippingAddress = [self buyAddressWithABRecord:payment.shippingAddress];
		}
	}

	if ([payment respondsToSelector:@selector(billingContact)]) {
		self.checkout.billingAddress = [self buyAddressWithContact:payment.billingContact];
	} else {
		self.checkout.billingAddress = [self buyAddressWithABRecord:payment.billingAddress];
	}
	
	[self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && error == nil) {
			self.checkout = checkout;
			
			id<BUYPaymentToken> token = [[BUYApplePayToken alloc] initWithPaymentToken:payment.token];
			
			//Now that the checkout is up to date, call complete.
			[self.client completeCheckoutWithToken:checkout.token paymentToken:token completion:^(BUYCheckout *checkout, NSError *error) {
				if (checkout && error == nil) {
					self.checkout = checkout;
					completion(PKPaymentAuthorizationStatusSuccess);
				} else {
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

- (BUYAddress *)buyAddressWithABRecord:(ABRecordRef)addressRecord
{
	return [self.client.modelManager buyAddressWithABRecord:addressRecord];
}

- (BUYAddress *)buyAddressWithContact:(PKContact *)contact
{
	return [self.client.modelManager buyAddressWithContact:contact];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
	[controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingAddress:(ABRecordRef)address completion:(AddressUpdateCompletion)completion
{
	self.checkout.shippingAddress = [self buyAddressWithABRecord:address];
	if ([self.checkout.shippingAddress isValidAddressForShippingRates]) {
		[self updateCheckoutWithAddressCompletion:completion];
	}
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingContact:(PKContact *)contact completion:(AddressUpdateCompletion)completion
{
	self.checkout.shippingAddress = [self buyAddressWithContact:contact];
	if ([self.checkout.shippingAddress isValidAddressForShippingRates]) {
		[self updateCheckoutWithAddressCompletion:completion];
	}
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
		completion(error == nil ? PKPaymentAuthorizationStatusSuccess : PKPaymentAuthorizationStatusFailure, [self.checkout buy_summaryItemsWithShopName:self.shopName]);
	}];
}

#pragma mark -

- (void)updateCheckoutWithAddressCompletion:(AddressUpdateCompletion)completion
{
	// This method call is internal to selection of shipping address that are returned as partial from PKPaymentAuthorizationViewController
	// However, to ensure we never set partialAddresses to NO, we want to guard the setter. Should PKPaymentAuthorizationViewController ever
	// return a full address through it's delegate method, this will still function since a complete address can be used to calculate shipping rates
	if ([self.checkout.shippingAddress isPartialAddress] == YES) {
		self.checkout.partialAddresses = @YES;
	}
	
	[self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout && !error) {
			self.checkout = checkout;
		}
		else if (error) {
			self.lastError = error;
		}
		if (checkout.requiresShipping) {
			self.shippingRates = @[];
			[self updateShippingRatesCompletion:completion];
		}
		else {
			completion(PKPaymentAuthorizationStatusSuccess, @[], [self.checkout buy_summaryItemsWithShopName:self.shopName]);
		}
	}];
}

- (void)updateShippingRatesCompletion:(AddressUpdateCompletion)completion
{
	[self.client getShippingRatesForCheckoutWithToken:self.checkout.token completion:^(NSArray *shippingRates, BUYStatus status, NSError *error) {
		
		self.shippingRates = shippingRates;
		NSArray *shippingMethods = [BUYShippingRate buy_convertShippingRatesToShippingMethods:shippingRates];
		
		if (shippingMethods.count > 0) {
			
			[self selectShippingMethod:shippingMethods[0] completion:^(BUYCheckout *checkout, NSError *error) {
				if (checkout && !error) {
					self.checkout = checkout;
				}
				completion(error ? PKPaymentAuthorizationStatusFailure : PKPaymentAuthorizationStatusSuccess, shippingMethods, [self.checkout buy_summaryItemsWithShopName:self.shopName]);
			}];
			
		} else {
			self.lastError = [NSError errorWithDomain:BUYShopifyError code:BUYShopifyError_NoShippingMethodsToAddress userInfo:nil];
			completion(PKPaymentAuthorizationStatusInvalidShippingPostalAddress, @[], [self.checkout buy_summaryItemsWithShopName:self.shopName]);
		}
	}];
}

#pragma mark - Internal -

- (BUYShippingRate *)rateForShippingMethod:(PKShippingMethod *)method
{
	BUYShippingRate *rate = nil;
	NSString *identifier = [method identifier];
	for (BUYShippingRate *method in self.shippingRates) {
		if ([[method shippingRateIdentifier] isEqual:identifier]) {
			rate = method;
			break;
		}
	}
	return rate;
}

- (void)selectShippingMethod:(PKShippingMethod *)shippingMethod completion:(BUYDataCheckoutBlock)block
{
	BUYShippingRate *shippingRate = [self rateForShippingMethod:shippingMethod];
	self.checkout.shippingRate = shippingRate;
	
	[self.client updateCheckout:self.checkout completion:block];
}

@end

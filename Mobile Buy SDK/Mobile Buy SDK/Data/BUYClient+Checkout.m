//
//  BUYClient+Checkout.m
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

#import "BUYClient+Checkout.h"
#import "BUYClient+Internal.h"
#import "BUYClient+Routing.h"
#import "BUYRequestOperation.h"
#import "BUYCheckoutOperation.h"
#import "BUYAddress.h"
#import "BUYCheckout.h"
#import "BUYGiftCard.h"
#import "BUYShippingRate.h"
#import "BUYCreditCard.h"
#import "BUYCreditCardToken.h"
#import "BUYAssert.h"
#import "BUYPaymentToken.h"
#import "NSDecimalNumber+BUYAdditions.h"

#define BUYAssertToken(checkoutToken) BUYAssert((checkoutToken), @"Checkout assertion failed. Checkout must have a valid token associated with it.")
#define BUYAssertCheckout(checkout)   BUYAssert([(checkout) hasToken], @"Checkout assertion failed. Checkout must have a valid token associated with it.")

@implementation BUYClient (Checkout)

#pragma mark - Checkout -

- (BUYRequestOperation *)createCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssert(checkout, @"Failed to create checkout. Invalid checkout object.");
	
	// Inject channel and marketing attributions
	[self configureCheckout:checkout];
	
	NSDictionary *json = [checkout jsonDictionaryForCheckout];
	return [self postCheckout:json completion:block];
}

- (BUYRequestOperation *)createCheckoutWithCartToken:(NSString *)cartToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssert(cartToken, @"Failed to create checkout. Invalid cart token");
	BUYCheckout *checkout = [self.modelManager checkoutwithCartToken:cartToken];
	[self configureCheckout:checkout];
	
	NSDictionary *json = [checkout jsonDictionaryForCheckout];
	return [self postCheckout:json completion:block];
}

- (BUYRequestOperation *)updateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	NSURL *route = [self urlForCheckoutsWithToken:checkout.token];
	return [self patchRequestForURL:route object:checkout completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (BUYRequestOperation *)getCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	return [self getCheckout:checkout start:YES completion:block];
}

- (BUYRequestOperation *)getCheckout:(BUYCheckout *)checkout start:(BOOL)start completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	NSURL *url = [self urlForCheckoutsWithToken:checkout.token];
	return [self getRequestForURL:url start:start completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (BUYOperation *)completeCheckout:(BUYCheckout *)checkout paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block {
	BUYCheckoutOperation *operation = [[BUYCheckoutOperation alloc] initWithClient:self checkout:checkout token:paymentToken completion:block];
	[self startOperation:operation];
	return operation;
}

- (BUYRequestOperation *)getCompletionStatusOfCheckout:(BUYCheckout *)checkout completion:(BUYDataStatusBlock)block
{
	BUYAssertCheckout(checkout);
	
	return [self getCompletionStatusOfCheckoutToken:checkout.token start:YES completion:block];
}

- (BUYRequestOperation *)getCompletionStatusOfCheckoutURL:(NSURL *)url completion:(BUYDataStatusBlock)block
{
	NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
	
	NSString *token = nil;
	for (NSURLQueryItem *item in components.queryItems) {
		if ([item.name isEqualToString:@"checkout[token]"]) {
			token = item.value;
			break;
		}
	}
	
	BUYAssert(token, @"Failed to get completion status of checkout. Checkout URL must have a valid token associated with it.");
	
	return [self getCompletionStatusOfCheckoutToken:token start:YES completion:block];
}

#pragma mark - Checkout Helpers -

- (BUYRequestOperation *)beginCheckout:(BUYCheckout *)checkout paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	BOOL isFree = (checkout.paymentDue && checkout.paymentDue.floatValue == 0);
	
	BUYAssert(paymentToken || isFree, @"Failed to complete checkout. Checkout must have a payment token or have a payment value equal to $0.00");
	
	NSURL *route = [self urlForCheckoutsCompletionWithToken:checkout.token];
	return [self postRequestForURL:route object:[paymentToken JSONDictionary] start:NO completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (BUYRequestOperation *)getCompletionStatusOfCheckoutToken:(NSString *)token start:(BOOL)start completion:(BUYDataStatusBlock)block
{
	NSURL *url = [self urlForCheckoutsProcessingWithToken:token];
	return [self getRequestForURL:url start:start completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		block([self statusForStatusCode:response.statusCode error:error], error);
	}];
}

- (BUYRequestOperation *)postCheckout:(NSDictionary *)checkoutJSON completion:(BUYDataCheckoutBlock)block
{
	return [self postRequestForURL:[self urlForCheckouts] object:checkoutJSON completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (void)configureCheckout:(BUYCheckout *)checkout
{
	checkout.marketingAttribution = @{@"medium": @"iOS", @"source": self.applicationName};
	checkout.sourceName = @"mobile_app";
	if (self.urlScheme || checkout.webReturnToURL) {
		checkout.webReturnToURL = checkout.webReturnToURL ?: [NSURL URLWithString:self.urlScheme];
		checkout.webReturnToLabel = checkout.webReturnToLabel ?: [@"Return to " stringByAppendingString:self.applicationName];
	}
}

- (void)handleCheckoutResponse:(NSDictionary *)json error:(NSError *)error block:(BUYDataCheckoutBlock)block
{
	BUYCheckout *checkout = nil;
	if (json && !error) {
		checkout = [self.modelManager insertCheckoutWithJSONDictionary:json[@"checkout"]];
	}
	block(checkout, error);
}

- (void)updateCheckout:(BUYCheckout *)checkout withGiftCardDictionary:(NSDictionary *)giftCardDictionary addingGiftCard:(BOOL)addingGiftCard
{
	if (addingGiftCard) {
		BUYGiftCard *giftCard = [self.modelManager insertGiftCardWithJSONDictionary:giftCardDictionary];
		[checkout.giftCardsSet addObject:giftCard];
	} else {
		[checkout removeGiftCardWithIdentifier:giftCardDictionary[@"id"]];
	}
	
	checkout.paymentDue = [NSDecimalNumber buy_decimalNumberFromJSON:giftCardDictionary[@"checkout"][@"payment_due"]];
	
	// Marking the checkout as clean. The properties we have updated above we don't need to re-sync with Shopify.
	// There's also an issue with gift cards where syncing the gift card JSON won't work since the update endpoint
	// doesn't accept the gift card without a gift card code (which we do not have).
	[checkout markAsClean];
}

#pragma mark - Shipping Rates -

- (BUYRequestOperation *)getShippingRatesForCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataShippingRatesBlock)block
{
	BUYAssertToken(checkoutToken);
	
	NSURL *url  = [self urlForCheckoutsShippingRatesWithToken:checkoutToken parameters:@{
																						  @"checkout" : @"",
																						  }];
	
	BUYRequestOperation *operation = [self getRequestForURL:url start:NO completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		NSArray *shippingRates = nil;
		if (json && !error) {
			shippingRates = [self.modelManager insertShippingRatesWithJSONArray:json[@"shipping_rates"]];
		}
		
		block(shippingRates, [self statusForStatusCode:response.statusCode error:error], error);
	}];
	
	operation.pollingHandler = ^BOOL(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		return response.statusCode == BUYStatusProcessing;
	};
	
	[self startOperation:operation];
	return operation;
}

#pragma mark - Cards -

- (BUYRequestOperation *)storeCreditCard:(BUYCreditCard *)creditCard checkout:(BUYCheckout *)checkout completion:(BUYDataCreditCardBlock)completion
{
	BUYAssertCheckout(checkout);
	BUYAssert(creditCard, @"Failed to store credit card. No credit card provided.");
	
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"token"]            = checkout.token;
	json[@"credit_card"]      = [creditCard jsonDictionaryForCheckout];
	if (checkout.billingAddress) {
		json[@"billing_address"] = [checkout.billingAddress jsonDictionaryForCheckout];
	}
	
	return [self postRequestForURL:checkout.paymentURL object:@{ @"checkout" : json } completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		id<BUYPaymentToken> token = nil;
		if (!error) {
			token = [[BUYCreditCardToken alloc] initWithPaymentSessionID:json[@"id"]];
		}
		completion(token, error);
	}];
}

- (BUYRequestOperation *)applyGiftCardWithCode:(NSString *)giftCardCode toCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	BUYAssert(giftCardCode.length > 0, @"Failed to apply gift card code. Invalid gift card code.");
	
	BUYGiftCard *giftCard = [self.modelManager giftCardWithCode:giftCardCode];
	NSURL *route = [self urlForCheckoutsUsingGiftCardWithToken:checkout.token];
	
	return [self postRequestForURL:route object:giftCard completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			[self updateCheckout:checkout withGiftCardDictionary:json[@"gift_card"] addingGiftCard:YES];
		}
		block(checkout, error);
	}];
}

- (BUYRequestOperation *)removeGiftCard:(BUYGiftCard *)giftCard fromCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	BUYAssert(giftCard.identifier, @"Failed to remove gift card. Gift card must have a valid identifier.");
	
	NSURL *route = [self urlForCheckoutsUsingGiftCard:giftCard.identifier token:checkout.token];
	return [self deleteRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (!error) {
			[self updateCheckout:checkout withGiftCardDictionary:json[@"gift_card"] addingGiftCard:NO];
		}
		block(checkout, error);
	}];
}

#pragma mark - Reservations -

- (BUYRequestOperation *)removeProductReservationsFromCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssertToken(checkoutToken);
	
	BUYCheckout *checkout    = [[BUYCheckout alloc] initWithModelManager:self.modelManager JSONDictionary:@{}];
	checkout.reservationTime = @0;
	checkout.token           = checkoutToken;
	
	return [self updateCheckout:checkout completion:block];
}

@end

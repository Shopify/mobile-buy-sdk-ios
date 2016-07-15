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
#import "BUYStatusOperation.h"
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


- (NSOperation *)updateOrCreateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)completion
{
	if ([checkout hasToken]) {
		return [self updateCheckout:checkout completion:completion];
	} else {
		return [self createCheckout:checkout completion:completion];
	}
}

- (NSOperation *)createCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssert(checkout, @"Failed to create checkout. Invalid checkout object.");
	
	// Inject channel and marketing attributions
	[self configureCheckout:checkout];
	
	NSDictionary *json = [checkout jsonDictionaryForCheckout];
	return [self postCheckout:json completion:block];
}

- (NSOperation *)createCheckoutWithCartToken:(NSString *)cartToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssert(cartToken, @"Failed to create checkout. Invalid cart token");
	BUYCheckout *checkout = [self.modelManager checkoutwithCartToken:cartToken];
	[self configureCheckout:checkout];
	
	NSDictionary *json = [checkout jsonDictionaryForCheckout];
	return [self postCheckout:json completion:block];
}

- (NSOperation *)updateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	NSURL *route = [self urlForCheckoutsWithToken:checkout.token];
	return [self patchRequestForURL:route object:checkout completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSOperation *)getCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataCheckoutBlock)block
{
	return [self getCheckoutWithToken:checkoutToken start:YES completion:block];
}

- (NSOperation *)getCheckoutWithToken:(NSString *)checkoutToken start:(BOOL)start completion:(BUYDataCheckoutBlock)block
{
	BUYAssertToken(checkoutToken);
	
	NSURL *url = [self urlForCheckoutsWithToken:checkoutToken];
	return [self getRequestForURL:url start:start completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (BUYOperation *)completeCheckoutWithToken:(NSString *)checkoutToken paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block
{
	BUYCheckoutOperation *operation = [BUYCheckoutOperation operationWithClient:self checkoutToken:checkoutToken token:paymentToken completion:block];
	[self startOperation:operation];
	return operation;
}

- (NSOperation *)getCompletionStatusOfCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataStatusBlock)block
{
	BUYAssertToken(checkoutToken);
	return [self getCompletionStatusOfCheckoutWithToken:checkoutToken start:YES completion:block];
}

- (NSOperation *)getCompletionStatusOfCheckoutURL:(NSURL *)url completion:(BUYDataStatusBlock)block
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
	
	return [self getCompletionStatusOfCheckoutWithToken:token start:YES completion:block];
}

#pragma mark - Checkout Helpers -

- (NSOperation *)beginCheckoutWithToken:(NSString *)checkoutToken paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssertToken(checkoutToken);
	
	NSURL *route = [self urlForCheckoutsCompletionWithToken:checkoutToken];
	return [self postRequestForURL:route object:[paymentToken JSONDictionary] start:NO completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSOperation *)getCompletionStatusOfCheckoutWithToken:(NSString *)token start:(BOOL)start completion:(BUYDataStatusBlock)block
{
	NSURL *url = [self urlForCheckoutsProcessingWithToken:token];
	return [self getRequestForURL:url start:start completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		block([self statusForStatusCode:response.statusCode error:error], error);
	}];
}

- (NSOperation *)pollCompletionStatusAndGetCheckoutWithToken:(NSString *)token start:(BOOL)start completion:(BUYCheckoutStatusOperationCompletion)block
{
	BUYStatusOperation *operation = [BUYStatusOperation operationWithClient:self checkoutToken:token completion:block];
	if (start) {
		[self startOperation:operation];
	}
	return operation;
}

- (NSOperation *)postCheckout:(NSDictionary *)checkoutJSON completion:(BUYDataCheckoutBlock)block
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

#pragma mark - Shipping Rates -

- (NSOperation *)getShippingRatesForCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataShippingRatesBlock)block
{
	BUYAssertToken(checkoutToken);
	
	NSURL *url  = [self urlForCheckoutsShippingRatesWithToken:checkoutToken parameters:@{
																						  @"checkout" : @"",
																						  }];
	
	BUYRequestOperation *operation = (BUYRequestOperation *)[self getRequestForURL:url start:NO completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
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

- (NSOperation *)storeCreditCard:(BUYCreditCard *)creditCard checkout:(BUYCheckout *)checkout completion:(BUYDataCreditCardBlock)completion
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

- (NSOperation *)applyGiftCardCode:(NSString *)giftCardCode toCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	BUYAssert(giftCardCode.length > 0, @"Failed to apply gift card code. Invalid gift card code.");
	
	BUYGiftCard *giftCard = [self.modelManager giftCardWithCode:giftCardCode];
	NSURL *route = [self urlForCheckoutsUsingGiftCardWithToken:checkout.token];
	
	return [self postRequestForURL:route object:giftCard completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			
			NSDictionary *giftCardJSON = json[@"gift_card"];
			BUYGiftCard *giftCard      = [self.modelManager insertGiftCardWithJSONDictionary:giftCardJSON];
			
			/* ---------------------------------
			 * We have to update the checkout 
			 * that was passed in with a new 
			 * 'paymentDue' value and the gift 
			 * card.
			 */
			checkout.JSONDictionary = giftCardJSON[@"checkout"];
			[checkout addGiftCard:giftCard];
		}
		block(checkout, error);
	}];
}

- (NSOperation *)removeGiftCard:(BUYGiftCard *)giftCard fromCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	BUYAssert(giftCard.identifier, @"Failed to remove gift card. Gift card must have a valid identifier.");
	
	NSURL *route = [self urlForCheckoutsUsingGiftCard:giftCard.identifier token:checkout.token];
	return [self deleteRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			
			NSDictionary *giftCardJSON = json[@"gift_card"];
			NSNumber *giftCardID       = giftCardJSON[@"id"];
			
			/* ---------------------------------
			 * We have to update the checkout
			 * that was passed in with a new
			 * 'paymentDue' value and the gift
			 * card.
			 */
			checkout.JSONDictionary = giftCardJSON[@"checkout"];
			[checkout removeGiftCardWithIdentifier:giftCardID];
		}
		block(checkout, error);
	}];
}

#pragma mark - Reservations -

- (NSOperation *)removeProductReservationsFromCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssertToken(checkoutToken);
	
	BUYCheckout *checkout    = [[BUYCheckout alloc] initWithModelManager:self.modelManager JSONDictionary:@{}];
	checkout.reservationTime = @0;
	checkout.token           = checkoutToken;
	
	return [self updateCheckout:checkout completion:block];
}

@end

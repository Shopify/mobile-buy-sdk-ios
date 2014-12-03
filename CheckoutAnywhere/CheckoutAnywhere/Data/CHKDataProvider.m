//
//  CHKDataProvider.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-17.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKDataProvider.h"

//Model
#import "CHKCheckout.h"
#import "CHKCart.h"
#import "CHKCreditCard.h"

#define kGET @"GET"
#define kPOST @"POST"
#define kPATCH @"PATCH"

#define kJSONType @"application/json"
#define kShopifyError @"shopify"

@implementation CHKDataProvider {
	NSString *_shopDomain;
	NSString *_apiKey;
	NSOperationQueue *_queue;
	NSURLSession *_session;
}

- (instancetype)initWithShopDomain:(NSString *)shopDomain apiKey:(NSString *)apiKey
{
	self = [super init];
	if (self) {
		_shopDomain = shopDomain;
		_apiKey = apiKey;
		_queue = [[NSOperationQueue alloc] init];
		_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:_queue];
	}
	return self;
}

- (NSURLSessionDataTask *)createCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block
{
	return [self postRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts.json", _shopDomain] object:checkout completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		CHKCheckout *checkout = nil;
		if (error == nil) {
			checkout = [[CHKCheckout alloc] initWithDictionary:json[@"checkout"]];
		}
		block(checkout, error);
	}];
}

- (NSURLSessionDataTask *)getCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block
{
	return [self getRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@.json", _shopDomain, checkout.token] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		CHKCheckout *newCheckout = nil;
		if (error == nil) {
			newCheckout = [[CHKCheckout alloc] initWithDictionary:json[@"checkout"]];
		}
		block(newCheckout, error);
	}];
}

- (NSURLSessionDataTask *)updateCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken]) {
		task = [self patchRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@.json", _shopDomain, checkout.token] object:checkout completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			CHKCheckout *newCheckout = nil;
			if (error == nil) {
				newCheckout = [[CHKCheckout alloc] initWithDictionary:json[@"checkout"]];
			}
			block(newCheckout, error);
		}];
	}
	return task;
}

- (NSURLSessionDataTask*)completeCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken] && [checkout.paymentSessionId length] > 0) {
		NSDictionary *paymentJson = @{ @"payment_session_id" : checkout.paymentSessionId };
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:paymentJson options:0 error:&error];
		if (data && error == nil) {
			task = [self checkoutCompletionRequestWithCheckout:checkout body:data completion:block];
		}
	}
	return task;
}

- (NSURLSessionDataTask *)completeCheckout:(CHKCheckout *)checkout withApplePayToken:(PKPaymentToken *)token completion:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken] && token) {
		NSString *tokenString = [[NSString alloc] initWithData:token.paymentData encoding:NSUTF8StringEncoding];
		NSDictionary *paymentJson = @{ @"payment_token" : @{ @"payment_data" : tokenString, @"type" : @"apple_pay" }};
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:paymentJson options:0 error:&error];
		if (data && error == nil) {
			task = [self checkoutCompletionRequestWithCheckout:checkout body:data completion:block];
		}
	}
	return task;
}

- (NSURLSessionDataTask *)checkoutCompletionRequestWithCheckout:(CHKCheckout *)checkout body:(NSData *)body completion:(CHKDataCheckoutBlock)block
{
	return [self postRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/complete.json", _shopDomain, checkout.token] body:body completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		CHKCheckout *newCheckout = nil;
		if (error == nil) {
			newCheckout = [[CHKCheckout alloc] initWithDictionary:json[@"checkout"]];
		}
		block(newCheckout, error);
	}];
}

- (NSURLSessionDataTask *)getCompletionStatusOfCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutStatusBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken]) {
		task = [self getRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/processing.json", _shopDomain, checkout.token] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
			block(checkout, [CHKDataProvider statusForStatusCode:statusCode error:error], error);
		}];
	}
	return task;
}

#pragma mark - Shipping Rates

- (NSURLSessionDataTask *)getShippingRatesForCheckout:(CHKCheckout *)checkout completion:(CHKDataShippingRatesBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken]) {
		task = [self getRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/shipping_rates.json", _shopDomain, checkout.token] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			NSArray *shippingRates = nil;
			if (error == nil && json) {
				shippingRates = [CHKShippingRate convertJSONArray:json[@"shipping_rates"]];
			}
			
			NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
			block(shippingRates, [CHKDataProvider statusForStatusCode:statusCode error:error], error);
		}];
	}
	return task;
}

#pragma mark - Payments

- (NSURLSessionDataTask *)storeCreditCard:(id <CHKSerializable>)creditCard checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block
{
	NSURLSessionDataTask *task = nil;
	if (checkout.token && creditCard) {
		NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
		json[@"token"] = checkout.token;
		json[@"credit_card"] = [creditCard jsonDictionaryForCheckout];
		if (checkout.billingAddress) {
			json[@"billing_address"] = [checkout.billingAddress jsonDictionaryForCheckout];
		}
		
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:@{ @"checkout" : json } options:0 error:&error];
		if (data && error == nil) {
			task = [self postPaymentRequestWithCheckout:checkout body:data completion:block];
		}
	}
	return task;
}

#pragma mark - Helpers

+ (CHKStatus)statusForStatusCode:(NSUInteger)statusCode error:(NSError *)error
{
	CHKStatus status = CHKStatusUnknown;
	if (error || statusCode == CHKStatusFailed) {
		status = CHKStatusFailed;
	}
	else if (statusCode == CHKStatusProcessing) {
		status = CHKStatusProcessing;
	}
	else if (statusCode == CHKStatusComplete) {
		status = CHKStatusComplete;
	}
	return status;
}

- (NSError *)errorFromJSON:(NSDictionary *)errorDictionary
{
	return [[NSError alloc] initWithDomain:kShopifyError code:422 userInfo:errorDictionary];
}

- (NSURLSessionDataTask *)requestForURL:(NSString *)url method:(NSString *)method object:(id <CHKSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSDictionary *json = [object jsonDictionaryForCheckout];
	NSError *error = nil;
	NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
	NSURLSessionDataTask *task = nil;
	if (error == nil && data) {
		task = [self requestForURL:url method:method body:data completionHandler:completionHandler];
	}
	return task;
}

- (NSURLSessionDataTask *)requestForURL:(NSString *)url method:(NSString *)method body:(NSData *)body completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	request.HTTPBody = body;
	[request addValue:kJSONType forHTTPHeaderField:@"Content-Type"];
	[request addValue:kJSONType forHTTPHeaderField:@"Accept"];
	[request addValue:[self authorizationHeader] forHTTPHeaderField:@"Authorization"];
	request.HTTPMethod = method;
	NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		NSDictionary *json = nil;
		BOOL unauthorized = statusCode == 401;
		BOOL failedValidation = statusCode == 422;
		
		if (unauthorized) {
			error = [[NSError alloc] initWithDomain:kShopifyError code:statusCode userInfo:nil];
		}
		else {
			//2 is the minimum amount of data {} for a JSON Object. Just ignore anything less.
			if ((error == nil || failedValidation) && [data length] > 2) {
				id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
				json = [jsonData isKindOfClass:[NSDictionary class]] ? jsonData : nil;
			}
			
			if (failedValidation) {
				error = [self errorFromJSON:json];
			}
		}
		completionHandler(json, response, error);
	}];
	[task resume];
	return task;
}

- (NSURLSessionDataTask *)postPaymentRequestWithCheckout:(CHKCheckout *)checkout body:(NSData *)body completion:(CHKDataCreditCardBlock)block
{
	return [self requestForURL:[checkout.paymentURL absoluteString] method:kPOST body:body completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSString *paymentSessionId = nil;
		if (error == nil) {
			paymentSessionId = json[@"id"];
			checkout.paymentSessionId = paymentSessionId;
		}
		block(checkout, paymentSessionId, error);
	}];
}

- (NSURLSessionDataTask *)getRequestForURL:(NSString *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kGET body:nil completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)postRequestForURL:(NSString *)url object:(id <CHKSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPOST object:object completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)postRequestForURL:(NSString *)url body:(NSData *)body completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPOST body:body completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)patchRequestForURL:(NSString *)url object:(id <CHKSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPATCH object:object completionHandler:completionHandler];
}

- (NSString *)authorizationHeader
{
	NSData *data = [_apiKey dataUsingEncoding:NSUTF8StringEncoding];
	return [NSString stringWithFormat:@"%@ %@", @"Basic", [data base64EncodedStringWithOptions:0]];
}

@end

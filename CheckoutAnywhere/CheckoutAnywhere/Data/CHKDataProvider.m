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

#define kJSONType @"application/json"
#define kFormType @"application/x-www-form-urlencoded"

@implementation CHKDataProvider {
	NSURLSession *_session;
	NSString *_shopDomain;
}

- (instancetype)initWithShopDomain:(NSString *)shopDomain
{
	self = [super init];
	if (self) {
		_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
		_shopDomain = shopDomain;
	}
	return self;
}

- (NSURLSessionDataTask *)requestForURL:(NSURL *)url method:(NSString *)method object:(id <CHKSerializable>)object contentType:(NSString*)contentType completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSDictionary *json = [object jsonDictionaryForCheckout];
	NSError *error = nil;
	NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
	NSURLSessionDataTask *task = nil;
	if (error == nil && data) {
		task = [self requestForURL:url method:method body:data contentType:contentType completionHandler:completionHandler];
	}
	return task;
}

- (NSURLSessionDataTask *)requestForURL:(NSURL *)url method:(NSString *)method body:(NSData *)body contentType:(NSString*)contentType completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	request.HTTPBody = body;
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	[request addValue:kJSONType forHTTPHeaderField:@"Accept"];
	request.HTTPMethod = method;
	NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSDictionary *json = nil;
		if (error == nil) {
			id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			json = [jsonData isKindOfClass:[NSDictionary class]] ? jsonData : nil;
		}
		completionHandler(json, response, error);
	}];
	[task resume];
	return task;
}

- (NSURLSessionDataTask *)postRequestForURL:(NSURL *)url object:(id <CHKSerializable>)object contentType:(NSString*)contentType completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:@"POST" object:object contentType:contentType completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)patchRequestForURL:(NSURL *)url object:(id <CHKSerializable>)object contentType:(NSString*)contentType completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:@"PATCH" object:object contentType:contentType completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)createCheckoutWithCart:(CHKCart *)cart completion:(CHKDataCheckoutBlock)block
{
	return [self postRequestForURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/anywhere/checkouts.json", _shopDomain]] object:cart contentType:kJSONType completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		CHKCheckout *checkout = nil;
		if (error == nil) {
			checkout = [[CHKCheckout alloc] initWithDictionary:json[@"checkout"]];
		}
		block(checkout, error);
	}];
}

- (NSURLSessionDataTask *)postPaymentRequestWithCheckout:(CHKCheckout *)checkout params:(NSString *)params completion:(CHKDataCreditCardBlock)block
{
	return [self requestForURL:checkout.paymentURL method:@"POST" body:[params dataUsingEncoding:NSUTF8StringEncoding] contentType:kFormType completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSString *paymentSessionId = nil;
		if (error == nil) {
			paymentSessionId = json[@"id"];
			checkout.paymentSessionId = paymentSessionId;
		}
		block(checkout, paymentSessionId, error);
	}];
}

- (NSURLSessionDataTask *)postPaymentRequestWithCheckout:(CHKCheckout *)checkout body:(NSData *)body contentType:(NSString *)type completion:(CHKDataCreditCardBlock)block
{
	return [self requestForURL:checkout.paymentURL method:@"POST" body:body contentType:type completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSString *paymentSessionId = nil;
		if (error == nil) {
			paymentSessionId = json[@"id"];
			checkout.paymentSessionId = paymentSessionId;
		}
		block(checkout, paymentSessionId, error);
	}];
}

- (NSURLSessionDataTask *)storeStripeToken:(STPToken *)stripeToken checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block
{
	NSString *params = [NSString stringWithFormat:@"checkout[token]=%@&checkout[credit_card][number]=%@", checkout.token, stripeToken.tokenId];
	return [self postPaymentRequestWithCheckout:checkout body:[params dataUsingEncoding:NSUTF8StringEncoding] contentType:kFormType completion:block];
}

- (NSURLSessionDataTask *)storeCreditCard:(CHKCreditCard *)creditCard checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block
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
			task = [self postPaymentRequestWithCheckout:checkout body:data contentType:kJSONType completion:block];
		}
	}
	return task;
}

- (NSURLSessionDataTask *)updateCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout.token length] > 0) {
		task = [self patchRequestForURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@.json", _shopDomain, checkout.token]] object:checkout contentType:kJSONType completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			CHKCheckout *newCheckout = nil;
			if (error == nil) {
				newCheckout = [[CHKCheckout alloc] initWithDictionary:json[@"checkout"]];
				NSLog(@"%@", checkout);
			}
			else {
				NSLog(@"ERROR: %@", error);
			}
			block(newCheckout, error);
		}];
	}
	return task;
}

- (NSURLSessionDataTask*)completeCheckout:(CHKCheckout *)checkout block:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout.token length] > 0 && [checkout.paymentSessionId length] > 0) {
		NSDictionary *paymentJson = @{ @"payment_session_id" : checkout.paymentSessionId };
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:paymentJson options:0 error:&error];
		if (data && error == nil) {
			task = [self requestForURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/complete.json", _shopDomain, checkout.token]] method:@"POST" body:data contentType:kJSONType completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
				if (error == nil) {
					NSLog(@"ORDER: %@ (%@)", json, error);
				}
				block(checkout, error);
			}];
		}
	}
	return task;
}

- (NSURLSessionDataTask *)getCompletionStatusOfCheckout:(CHKCheckout *)checkout block:(CHKDataCheckoutStatusBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout.token length] > 0) {
		task = [self requestForURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/progressing.json", _shopDomain, checkout.token]] method:@"GET" body:nil contentType:kJSONType completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
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
			block(checkout, status, error);
		}];
	}
	return task;
}

- (NSURLSessionDataTask *)getAssociatedOrder:(CHKCheckout *)checkout block:(CHKDataOrderBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout orderId]) {
		
	}
	return task;
}

@end

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

- (NSURLSessionDataTask *)postRequestForURL:(NSURL *)url body:(NSData *)body contentType:(NSString*)contentType completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	request.HTTPBody = body;
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	request.HTTPMethod = @"POST";
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

- (NSURLSessionDataTask *)createCheckoutWithCart:(CHKCart *)cart completion:(CHKDataCheckoutBlock)block
{
	NSDictionary *cartJson = [cart jsonDictionaryForCheckout];
	NSError *error = nil;
	NSData *data = [NSJSONSerialization dataWithJSONObject:cartJson options:0 error:&error];
	NSURLSessionDataTask *task = nil;
	if (error == nil && data) {
		[self postRequestForURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/anywhere/checkouts.json", _shopDomain]] body:data contentType:kJSONType completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			CHKCheckout *checkout = nil;
			if (error == nil) {
				checkout = [[CHKCheckout alloc] initWithDictionary:json[@"checkout"]];
				NSLog(@"%@", checkout);
			}
			else {
				NSLog(@"ERROR: %@", error);
			}
			block(checkout, error);
		}];
	}
	return task;
}

- (NSURLSessionDataTask *)postPaymentRequestWithCheckout:(CHKCheckout *)checkout params:(NSString *)params completion:(CHKDataCreditCardBlock)block
{
	return [self postRequestForURL:checkout.paymentURL body:[params dataUsingEncoding:NSUTF8StringEncoding] contentType:kFormType completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSString *paymentSessionId = nil;
		if (error == nil) {
			paymentSessionId = json[@"id"];
			checkout.paymentSessionId = paymentSessionId;
		} else {
			NSLog(@"ERROR: %@", error);
		}
		block(checkout, paymentSessionId, error);
	}];
}

- (NSURLSessionDataTask *)storeStripeToken:(STPToken *)stripeToken checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block
{
	NSString *params = [NSString stringWithFormat:@"checkout[token]=%@&checkout[credit_card][number]=%@", checkout.token, stripeToken.tokenId];
	return [self postPaymentRequestWithCheckout:checkout params:params completion:block];
}

- (NSURLSessionDataTask *)storeCreditCard:(CHKCreditCard *)creditCard checkout:(CHKCheckout *)checkout completion:(CHKDataCreditCardBlock)block
{
	NSURLSessionDataTask *task = nil;
	//TODO: This
	return task;
}

- (NSURLSessionDataTask *)updateCheckout:(CHKCheckout *)checkout completion:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	
	return task;
}

- (NSURLSessionDataTask*)completeCheckout:(CHKCheckout *)checkout block:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	
	return task;
}

@end

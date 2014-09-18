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

@implementation CHKDataProvider {
	NSURLSession *_session;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	}
	return self;
}

- (NSURLSessionDataTask *)createCheckoutWithCart:(CHKCart *)cart completion:(CHKDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	
	return task;
}

- (NSURLSessionDataTask *)postPaymentRequestWithCheckout:(CHKCheckout *)checkout params:(NSString *)params completion:(CHKDataCreditCardBlock)block
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:checkout.paymentURL];
	request.HTTPMethod = @"POST";
	request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
	[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request addValue:@"https://" forHTTPHeaderField:@"Origin"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	
	NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSString *paymentSessionId = nil;
		if (error == nil) {
			NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			paymentSessionId = json[@"id"];
			checkout.paymentSessionId = paymentSessionId;
		} else {
			NSLog(@"ERROR: %@", error);
		}
		block(checkout, paymentSessionId, error);
	}];
	[task resume];
	return task;
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

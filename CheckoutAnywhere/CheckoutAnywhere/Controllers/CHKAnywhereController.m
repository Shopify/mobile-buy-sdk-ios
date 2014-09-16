//
//  CHKAnywhereController.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKAnywhereController.h"

@implementation CHKAnywhereController {
	MERShop *_shop;
}

- (instancetype)initWithShop:(MERShop *)shop
{
	self = [super init];
	if (self) {
		_shop = shop;
	}
	return self;
}

- (NSURLSessionTask *)createCheckoutWithCart:(CHKCart *)cart block:(CHKDataCheckoutBlock)block
{
	/*
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@/anywhere/checkouts.json", _shopDomain]]];
	NSMutableArray *lineItemParams = [NSMutableArray array];
	
	for (MERLineItem* lineItem in lineItems) {
		[lineItemParams addObject:@{@"variant_id": lineItem.variant.identifier, @"quantity": lineItem.quantity}];
	}
	
	NSDictionary *json = @{ @"checkout": @{
									@"line_items": lineItemParams,
									@"email": @"john.smith@example.com",
									@"shipping_address": @{
											@"address1": @"126 York St.",
											@"city": @"Ottawa",
											@"country": @"Canada",
											@"country_code": @"CA",
											@"first_name": @"John",
											@"last_name": @"Smith",
											@"phone": @"(123)456-7890",
											@"province": @"Ontario",
											@"province_code": @"ON",
											@"zip": @"K1N 5T5"
											},
									}
							};
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
	request.HTTPBody = jsonData;
	
	[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	request.HTTPMethod = @"POST";
	
	NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		MERCheckout *checkout = nil;
		if (error == nil) {
			NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			checkout = [[MERCheckout alloc] initWithDictionary:json[@"checkout"]];
			NSLog(@"%@", checkout);
			block(checkout, error);
		}
		else {
			NSLog(@"ERROR: %@", error);
			block(checkout, error);
		}
	}];
	[task resume];
	return task;*/
	return nil;
}

- (NSURLSessionTask *)updateCheckoutWithCart:(CHKCart *)cart block:(CHKDataCheckoutBlock)block
{
	return nil;
}

#pragma mark - Credit Card Support

- (void)processPaymentWithCreditCard:(CHKCreditCard *)creditCard block:(CHKDataCheckoutBlock)block
{
	
}

#pragma mark - Stripe Support

- (void)processPaymentWithStripeToken:(STPToken *)stripeToken forCheckout:(CHKCheckout *)checkout block:(CHKDataCheckoutBlock)block
{
	
}

@end

//
//  BUYCheckoutOperation.m
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

#import "BUYCheckoutOperation.h"
#import "BUYClient+Checkout.h"
#import "BUYPaymentToken.h"
#import "BUYCheckout.h"
#import "BUYRequestOperation.h"

@interface BUYClient (PrivateCheckout)

- (BUYRequestOperation *)beginCheckout:(BUYCheckout *)checkout paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block;
- (BUYRequestOperation *)getCompletionStatusOfCheckoutToken:(NSString *)token start:(BOOL)start completion:(BUYDataStatusBlock)block;
- (BUYRequestOperation *)getCheckout:(BUYCheckout *)checkout start:(BOOL)start completion:(BUYDataCheckoutBlock)block;

@end

@interface BUYCheckoutOperation ()

@property (strong, nonatomic, readonly) BUYCheckout *checkout;
@property (strong, nonatomic, readonly) id<BUYPaymentToken> token;
@property (strong, nonatomic, readonly) BUYCheckoutOperationCompletion completion;

@property (strong, nonatomic, readonly) NSArray *operations;

@end

@implementation BUYCheckoutOperation

#pragma mark - Init -

+ (instancetype)operationWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout token:(id<BUYPaymentToken>)token completion:(BUYCheckoutOperationCompletion)completion
{
	return [[[self class] alloc] initWithClient:client checkout:checkout token:token completion:completion];
}

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout token:(id<BUYPaymentToken>)token completion:(BUYCheckoutOperationCompletion)completion
{
	self = [super init];
	if (self) {
		_client     = client;
		_checkout   = checkout;
		_token      = token;
		_completion = completion;
	}
	return self;
}

#pragma mark - Finishing -

- (void)finishWithCheckout:(BUYCheckout *)checkout
{
	[self finishExecution];
	self.completion(checkout, nil);
}

- (void)finishWithError:(NSError *)error
{
	[self finishExecution];
	self.completion(nil, error);
}

#pragma mark - Execution -

- (void)startExecution
{
	[super startExecution];
	
	__weak typeof(self) weakSelf = self;
	
	BUYRequestOperation *beginOperation = [self.client beginCheckout:self.checkout paymentToken:self.token completion:^(BUYCheckout *checkout, NSError *error) {
		if (weakSelf.isCancelled || !checkout) {
			[weakSelf cancel];
			return;
		}
	}];
	
	BUYRequestOperation *pollingOperation = [self.client getCompletionStatusOfCheckoutToken:self.checkout.token start:NO completion:^(BUYStatus status, NSError *error) {
		if (weakSelf.isCancelled || status != BUYStatusComplete) {
			[weakSelf cancel];
			return;
		}
	}];
	pollingOperation.pollingHandler = ^BOOL (NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		return response.statusCode == BUYStatusProcessing;
	};
	
	BUYRequestOperation *getOperation = [self.client getCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
		if (weakSelf.isCancelled || !checkout) {
			[weakSelf cancel];
			return;
		}
	}];
	
	
	[self locked:^{
		_operations = @[beginOperation, pollingOperation, getOperation];
	}];
	[self.client.requestQueue addOperations:self.operations waitUntilFinished:NO];
}

- (void)cancelExecution
{
	[super cancelExecution];
	
	for (NSOperation *operation in self.operations) {
		[operation cancel];
	}
}

@end

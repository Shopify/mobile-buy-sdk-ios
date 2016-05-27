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
#import "BUYClient+Internal.h"
#import "BUYPaymentToken.h"
#import "BUYCheckout.h"
#import "BUYRequestOperation.h"

@interface BUYCheckoutOperation ()

@property (strong, nonatomic, readonly) BUYCheckout *checkout;
@property (strong, nonatomic, readonly) id<BUYPaymentToken> token;
@property (strong, nonatomic, readonly) BUYCheckoutOperationCompletion completion;

@property (strong, atomic) NSArray *operations;

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
	if (self.isCancelled) {
		return;
	}
	
	[self finishExecution];
	self.completion(checkout, nil);
}

- (void)finishWithError:(NSError *)error
{
	if (self.isCancelled) {
		return;
	}
	
	[self cancelAllOperations];
	
	[self finishExecution];
	self.completion(nil, error);
}

#pragma mark - Execution -

- (void)startExecution
{
	if (self.isCancelled) {
		return;
	}
	
	[super startExecution];
	
	BUYRequestOperation *beginOperation = [self createBeginOperation];
	BUYRequestOperation *pollOperation  = [self createPollOperation];
	BUYRequestOperation *getOperation   = [self createGetOperation];
	
	[pollOperation addDependency:beginOperation];
	[getOperation addDependency:pollOperation];
	
	self.operations = @[
						beginOperation,
						pollOperation,
						getOperation,
						];
	
	[self startAllOperations];
}

- (void)cancelExecution
{
	[super cancelExecution];
	[self cancelAllOperations];
}

#pragma mark - Start / Stop -

- (void)startAllOperations
{
	for (BUYRequestOperation *operation in self.operations) {
		[self.client startOperation:operation];
	}
}

- (void)cancelAllOperations
{
	for (BUYRequestOperation *operation in self.operations) {
		[operation cancel];
	}
}

#pragma mark - Operations -

- (BUYRequestOperation *)createBeginOperation
{
	return [self.client beginCheckout:self.checkout paymentToken:self.token completion:^(BUYCheckout *checkout, NSError *error) {
		if (!checkout) {
			[self finishWithError:error];
		}
	}];
}

- (BUYRequestOperation *)createPollOperation
{
	BUYRequestOperation *operation =[self.client getCompletionStatusOfCheckoutToken:self.checkout.token start:NO completion:^(BUYStatus status, NSError *error) {
		if (status != BUYStatusComplete) {
			[self finishWithError:error];
		}
	}];
	operation.pollingHandler = ^BOOL (NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		return response.statusCode == BUYStatusProcessing;
	};
	
	return operation;
}

- (BUYRequestOperation *)createGetOperation
{
	return [self.client getCheckout:self.checkout start:NO completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout) {
			[self finishWithCheckout:checkout];
		} else {
			[self finishWithError:error];
		}
	}];
}

@end

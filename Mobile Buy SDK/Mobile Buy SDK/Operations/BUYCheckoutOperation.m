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
#import "BUYRequestOperation.h"
#import "BUYStatusOperation.h"

@interface BUYCheckoutOperation ()

@property (strong, nonatomic, readonly) BUYClient *client;
@property (strong, nonatomic, readonly) NSString *checkoutToken;
@property (strong, nonatomic, readonly) id<BUYPaymentToken> token;
@property (strong, nonatomic, readonly) BUYCheckoutOperationCompletion completion;

@end

@implementation BUYCheckoutOperation

#pragma mark - Init -

+ (instancetype)operationWithClient:(BUYClient *)client checkoutToken:(NSString *)checkoutToken token:(id<BUYPaymentToken>)token completion:(BUYCheckoutOperationCompletion)completion
{
	return [[[self class] alloc] initWithClient:client checkoutToken:checkoutToken token:token completion:completion];
}

- (instancetype)initWithClient:(BUYClient *)client checkoutToken:(NSString *)checkoutToken token:(id<BUYPaymentToken>)token completion:(BUYCheckoutOperationCompletion)completion
{
	self = [super initWithRequestQueue:client.requestQueue operations:nil];
	if (self) {
		_client        = client;
		_token         = token;
		_completion    = completion;
		_checkoutToken = checkoutToken;
	}
	return self;
}

#pragma mark - Finishing -

- (void)finishWithObject:(id)object
{
	[super finishWithObject:object];
	
	if (self.cancelled) {
		return;
	}
	self.completion(object, nil);
}

- (void)finishWithError:(NSError *)error
{
	[super finishWithError:error];
	
	if (self.cancelled) {
		return;
	}
	self.completion(nil, error);
}

#pragma mark - Execution -

- (void)startExecution
{
	if (self.cancelled) {
		return;
	}
	
	self.operations = @[
						[self createBeginOperation],
						[self createStatusOperation],
						];
	
	[super startExecution];
}

#pragma mark - Operations -

- (NSOperation *)createBeginOperation
{
	return [self.client beginCheckoutWithToken:self.checkoutToken paymentToken:self.token completion:^(BUYCheckout *checkout, NSError *error) {
		if (!checkout) {
			[self finishWithError:error];
		}
	}];
}

- (NSOperation *)createStatusOperation
{
	return [self.client pollCompletionStatusAndGetCheckoutWithToken:self.checkoutToken start:NO completion:^(BUYStatus status, BUYCheckout *checkout, NSError *error) {
		if (checkout) {
			[self finishWithObject:checkout];
		} else {
			[self finishWithError:error];
		}
	}];
}

@end

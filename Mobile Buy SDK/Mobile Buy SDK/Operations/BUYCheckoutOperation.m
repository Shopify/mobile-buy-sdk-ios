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
#import "BUYCheckout.h"
#import "BUYClient.h"

@interface BUYOperation (Private)
- (void)setExecuting:(BOOL)executing;
- (void)setFinished:(BOOL)finished;
@end

@interface BUYCheckoutOperation ()

@property (strong, nonatomic) BUYCheckout *checkout;
@property (strong, nonatomic) id<BUYPaymentToken> token;
@property (strong, nonatomic) BUYClient *client;

@end

@implementation BUYCheckoutOperation

#pragma mark - Init -

- (instancetype)initWithCheckout:(BUYCheckout *)checkout token:(id<BUYPaymentToken>)token client:(BUYClient *)client completion:(BUYOperationCheckoutCompletion)completion
{
	self = [super init];
	if (self) {
		_checkout   = checkout;
		_token      = token;
		_client     = client;
		_completion = completion;
	}
	return self;
}

#pragma mark - Actions -

- (void)finishWithCheckout:(BUYCheckout *)checkout
{
	[self setExecuting:NO];
	self.completion(checkout, nil);
}

- (void)finishWithError:(NSError *)error
{
	[self setExecuting:NO];
	self.completion(nil, error);
}

- (void)finishByCancellation
{
	[self setFinished:YES];
	[self setExecuting:NO];
}

#pragma mark - Start -

- (void)start
{
	[super start];
	[self setExecuting:YES];
	
	if (self.isCancelled) {
		[self finishByCancellation];
		return;
	}
	
	/* ---------------------------------
	 * Initiate the checkout process by
	 * sending the checkout object to the
	 * backend for processing.
	 */
	[self.client completeCheckout:self.checkout paymentToken:self.token completion:^(BUYCheckout *checkout, NSError *error) {
		if (self.isCancelled) {
			[self finishByCancellation];
			return;
			
		} else if (checkout) {
			
			/* ----------------------------------------
			 * Recursively poll for checkout completion
			 * status until we encounter an error or
			 * get a successful completion status.
			 */
			[self pollUntilCheckoutCompletion:^(BOOL success, NSError *error) {
				if (self.isCancelled ) {
					[self finishByCancellation];
					return;
					
				} else if (success) {
					
					/* ---------------------------------
					 * Finally, after the checkout is
					 * complete, we'll need to fetch the
					 * completed checkout object.
					 */
					[self.client getCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
						if (self.isCancelled) {
							[self finishByCancellation];
							return;
							
						} else if (checkout) {
							[self finishWithCheckout:checkout];
						} else {
							[self finishWithError:error];
						}
					}];
					
				} else {
					[self finishWithError:error];
				}
			}];
			
		} else {
			[self finishWithError:error];
		}
	}];
}

#pragma mark - Requests -

- (void)pollUntilCheckoutCompletion:(void(^)(BOOL success, NSError *error))completion {
	[self.client getCompletionStatusOfCheckout:self.checkout completion:^(BUYStatus status, NSError *error) {
		if (self.isCancelled) {
			[self finishByCancellation];
			return;
			
		} else if (status == BUYStatusComplete) {
			completion(YES, nil);
		} else if (error) {
			completion(NO, error);
		} else {
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				[self pollUntilCheckoutCompletion:completion];
			});
		}
	}];
}

@end

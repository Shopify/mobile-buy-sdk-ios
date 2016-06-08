//
//  BUYStatusOperation.m
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

#import "BUYStatusOperation.h"
#import "BUYClient+Checkout.h"
#import "BUYClient+Internal.h"
#import "BUYRequestOperation.h"

@interface BUYStatusOperation ()

@property (strong, nonatomic, readonly) BUYClient *client;
@property (strong, nonatomic, readonly) NSString *checkoutToken;
@property (strong, nonatomic, readonly) BUYCheckoutStatusOperationCompletion completion;

- (void)finishWithError:(NSError *)error NS_UNAVAILABLE;

@end

@implementation BUYStatusOperation

#pragma mark - Init -

+ (instancetype)operationWithClient:(BUYClient *)client checkoutToken:(NSString *)checkoutToken completion:(BUYCheckoutStatusOperationCompletion)completion
{
	return [[[self class] alloc] initWithClient:client checkoutToken:checkoutToken completion:completion];
}

- (instancetype)initWithClient:(BUYClient *)client checkoutToken:(NSString *)checkoutToken completion:(BUYCheckoutStatusOperationCompletion)completion
{
	self = [super initWithRequestQueue:client.requestQueue operations:nil];
	if (self) {
		_client        = client;
		_completion    = completion;
		_checkoutToken = checkoutToken;
	}
	return self;
}

#pragma mark - Execution -

- (void)startExecution
{
	if (self.cancelled) {
		return;
	}
	
	self.operations = @[
						[self createPollOperation],
						[self createGetOperation],
						];
	
	[super startExecution];
}

#pragma mark - Finishing -

- (void)finishWithObject:(id)object
{
	[super finishWithObject:object];
	
	if (self.cancelled) {
		return;
	}
	self.completion(BUYStatusComplete, object, nil);
}

- (void)finishWithStatus:(BUYStatus)status error:(NSError *)error
{
	[super finishWithError:error];
	
	if (self.cancelled) {
		return;
	}
	self.completion(status, nil, error);
}

#pragma mark - Operations -

- (NSOperation *)createPollOperation
{
	BUYRequestOperation *operation = (BUYRequestOperation *)[self.client getCompletionStatusOfCheckoutWithToken:self.checkoutToken start:NO completion:^(BUYStatus status, NSError *error) {
		if (status != BUYStatusComplete) {
			[self finishWithStatus:status error:error];
		}
	}];
	operation.pollingHandler = ^BOOL (NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		return response.statusCode == BUYStatusProcessing;
	};
	
	return operation;
}

- (NSOperation *)createGetOperation
{
	return [self.client getCheckoutWithToken:self.checkoutToken start:NO completion:^(BUYCheckout *checkout, NSError *error) {
		if (checkout) {
			[self finishWithObject:checkout];
		} else {
			[self finishWithStatus:BUYStatusComplete error:error]; // Assumed because the polling operation has to success for us to get here
		}
	}];
}

@end

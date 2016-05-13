//
//  BUYCheckoutOperation.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-12.
//  Copyright © 2016 Shopify Inc. All rights reserved.
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

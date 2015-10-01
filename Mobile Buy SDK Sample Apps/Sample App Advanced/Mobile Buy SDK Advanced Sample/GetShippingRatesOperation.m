//
//  GetShippingRatesOperations.m
//  Mobile Buy SDK Advanced Sample
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

#import "GetShippingRatesOperation.h"
@import Buy;

@interface GetShippingRatesOperation ()

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, assign) BOOL done;

@property (nonatomic, strong) NSURLSessionDataTask *task;

@property (nonatomic, strong) NSArray *shippingRates;

@end

@implementation GetShippingRatesOperation

- (instancetype)initWithClient:(BUYClient *)client withCheckout:(BUYCheckout *)checkout;
{
    NSParameterAssert(client);
    NSParameterAssert(checkout);
    
    self = [super init];
    
    if (self) {
        self.checkout = checkout;
        self.client = client;
    }
    
    return self;
}

- (BOOL)isFinished
{
    return [super isFinished] && self.done;
}

- (void)cancel
{
    [self.task cancel];
    [super cancel];
}

- (void)main
{
    // We're now fetching the rates from Shopify. This will will calculate shipping rates very similarly to how our web checkout.
    // We then turn our BUYShippingRate objects into PKShippingMethods for Apple to present to the user.
    
    if ([self.checkout requiresShipping] == NO) {
        
        [self willChangeValueForKey:@"isFinished"];
        self.done = YES;
        [self didChangeValueForKey:@"isFinished"];
        
        [self.delegate operation:self didReceiveShippingRates:nil];
    }
    else {
        
        [self pollForShippingRates];
        
    }
}

- (void)pollForShippingRates
{
    __block BUYStatus shippingStatus = BUYStatusUnknown;
    
    self.task = [self.client getShippingRatesForCheckout:self.checkout completion:^(NSArray *shippingRates, BUYStatus status, NSError *error) {
        
        shippingStatus = status;
        
        if (error) {
            
            [self willChangeValueForKey:@"isFinished"];
            self.done = YES;
            [self didChangeValueForKey:@"isFinished"];
            
            [self.delegate operation:self failedToReceiveShippingRates:error];
        }
        else if (shippingStatus == BUYStatusComplete) {
            self.shippingRates = shippingRates;
            
            [self willChangeValueForKey:@"isFinished"];
            self.done = YES;
            [self didChangeValueForKey:@"isFinished"];
            
            [self.delegate operation:self didReceiveShippingRates:self.shippingRates];
        }
        else if (shippingStatus == BUYStatusProcessing) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self pollForShippingRates];
                
            });
        }
    }];
}

@end

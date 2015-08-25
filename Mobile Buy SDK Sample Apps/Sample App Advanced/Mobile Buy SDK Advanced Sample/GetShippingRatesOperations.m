//
//  GetShippingRatesOperations.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-25.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "GetShippingRatesOperations.h"
@import Buy;

@interface GetShippingRatesOperations ()

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, assign) BOOL done;

@property (nonatomic, strong) NSArray *shippingRates;

@end

@implementation GetShippingRatesOperations

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

    [self.client getShippingRatesForCheckout:self.checkout completion:^(NSArray *shippingRates, BUYStatus status, NSError *error) {
        
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

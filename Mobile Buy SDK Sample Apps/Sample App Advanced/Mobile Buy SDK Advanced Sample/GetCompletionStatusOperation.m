//
//  GetCompletionStatusOperation.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-31.
//  Copyright © 2015 Shopify. All rights reserved.
//

#import "GetCompletionStatusOperation.h"

@interface GetCompletionStatusOperation ()

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, assign) BOOL done;

@property (nonatomic) BUYStatus completionStatus;

@end

@implementation GetCompletionStatusOperation


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
    [self pollForCompletionStatus];
}

- (void)pollForCompletionStatus
{
    __block BUYStatus completionStatus = BUYStatusUnknown;
    
    if (self.isCancelled) {
        return;
    }
    
    [self.client getCompletionStatusOfCheckout:self.checkout completion:^(BUYStatus status, NSError *error) {
       
        completionStatus = status;
        
        if (status == BUYStatusProcessing) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self pollForCompletionStatus];
            });
        }
        else {
            self.completionStatus = status;
            
            [self willChangeValueForKey:@"isFinished"];
            self.done = YES;
            [self didChangeValueForKey:@"isFinished"];
            
            if (error) {
                [self.delegate operation:self failedToReceiveCompletionStatus:error];
            }
            else {
                [self.delegate operation:self didReceiveCompletionStatus:status];
            }
        }
    }];
}


@end

//
//  GetCompletionStatusOperation.h
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-31.
//  Copyright © 2015 Shopify. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Buy;

@class GetCompletionStatusOperation;

@protocol GetCompletionStatusOperationDelegate <NSObject>

- (void)operation:(GetCompletionStatusOperation *)operation didReceiveCompletionStatus:(BUYStatus)completionStatus;

- (void)operation:(GetCompletionStatusOperation *)operation failedToReceiveCompletionStatus:(NSError *)error;

@end

@interface GetCompletionStatusOperation : NSOperation

- (instancetype)initWithClient:(BUYClient *)client withCheckout:(BUYCheckout *)checkout;

@property (nonatomic, weak) id <GetCompletionStatusOperationDelegate> delegate;

@property (nonatomic, readonly) BUYStatus completionStatus;

@end

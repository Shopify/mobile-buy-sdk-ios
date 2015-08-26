//
//  GetShippingRatesOperations.h
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-25.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BUYCheckout;
@class BUYClient;
@class GetShippingRatesOperation;

@protocol GetShippingRatesOperationDelegate <NSObject>

- (void)operation:(GetShippingRatesOperation *)operation didReceiveShippingRates:(NSArray *)shippingRates;

- (void)operation:(GetShippingRatesOperation *)operation failedToReceiveShippingRates:(NSError *)error;

@end

@interface GetShippingRatesOperation : NSOperation

- (instancetype)initWithClient:(BUYClient *)client withCheckout:(BUYCheckout *)checkout;

@property (nonatomic, weak) id <GetShippingRatesOperationDelegate> delegate;

@property (nonatomic, strong, readonly) BUYCheckout *checkout;

@property (nonatomic, strong, readonly) NSArray *shippingRates;

@end

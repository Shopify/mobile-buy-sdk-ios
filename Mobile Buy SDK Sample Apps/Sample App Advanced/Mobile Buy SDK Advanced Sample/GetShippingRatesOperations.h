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
@class GetShippingRatesOperations;

@protocol GetShippingRatesOperationsDelegate <NSObject>

- (void)operation:(GetShippingRatesOperations *)operation didReceiveShippingRates:(NSArray *)shippingRates;

- (void)operation:(GetShippingRatesOperations *)operation failedToReceiveShippingRates:(NSError *)error;

@end

@interface GetShippingRatesOperations : NSOperation

- (instancetype)initWithClient:(BUYClient *)client withCheckout:(BUYCheckout *)checkout;

@property (nonatomic, weak) id <GetShippingRatesOperationsDelegate> delegate;

@property (nonatomic, strong, readonly) BUYCheckout *checkout;

@property (nonatomic, strong, readonly) NSArray *shippingRates;

@end

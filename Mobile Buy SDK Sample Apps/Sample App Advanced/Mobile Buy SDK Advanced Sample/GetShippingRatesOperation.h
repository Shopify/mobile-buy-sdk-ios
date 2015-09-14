//
//  GetShippingRatesOperations.h
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

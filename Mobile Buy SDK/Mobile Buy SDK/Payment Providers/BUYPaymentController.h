//
//  BUYPaymentController.h
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

@import Foundation;
#import <Buy/BUYPaymentProvider.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUYPaymentController : NSObject

/**
 *  The registered payment providers
 */
@property (nonatomic, strong, readonly) NSOrderedSet <id <BUYPaymentProvider>> *providers;

/**
 *  The registered payment providers
 */
- (NSArray< id<BUYPaymentProvider> > *)providersArray;

/**
 *  Register a payment provider
 *
 *  @param paymentProvider a payment provider
 *
 *  @note can only add 1 provider per type
 */
- (void)addPaymentProvider:(id <BUYPaymentProvider>)paymentProvider;

/**
 *  Convenience method to retrieve a BUYPaymentProvider by the identifier
 *
 *  @param type The identifier for the payment provider
 *
 *  @return The payment provider matching the given identifier
 */
- (id <BUYPaymentProvider> _Nullable)providerForType:(NSString *)type;

/**
 *  Start a checkout
 *
 *  @param checkout the `BUYCheckout` to start
 *  @param type     the type of payment provider to use
 */
- (void)startCheckout:(BUYCheckout *)checkout withProviderType:(NSString *)typeIdentifier;

@end

NS_ASSUME_NONNULL_END

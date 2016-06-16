//
//  BUYPaymentProvider.h
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

@import UIKit;

#import <Buy/BUYClient.h>

NS_ASSUME_NONNULL_BEGIN

@class BUYCheckout;
@protocol BUYPaymentProvider;

extern NSString *const BUYPaymentProviderWillStartCheckoutNotificationKey;
extern NSString *const BUYPaymentProviderDidDismissCheckoutNotificationKey;
extern NSString *const BUYPaymentProviderDidFailToUpdateCheckoutNotificationKey;
extern NSString *const BUYPaymentProviderDidFailCheckoutNotificationKey;
extern NSString *const BUYPaymentProviderDidCompleteCheckoutNotificationKey;

@protocol BUYPaymentProviderDelegate <NSObject>

@required

/**
 *  Called when a view controller needs to be presented
 *
 *  @param provider   the `BUYPaymentProvider`
 *  @param controller the `UIViewController` to be presented
 */
- (void)paymentProvider:(id <BUYPaymentProvider>)provider wantsControllerPresented:(UIViewController *)controller;

/**
 *  Called when the view controller
 *
 *  @param provider   the `BUYPaymentProvider`
 */
- (void)paymentProviderWantsControllerDismissed:(id <BUYPaymentProvider>)provider;

@optional

/**
 *  Called when the checkout process has started
 *
 *  @param provider   the `BUYPaymentProvider`
 */
- (void)paymentProviderWillStartCheckout:(id <BUYPaymentProvider>)provider;

/**
 *  Called when the checkout has been dismissed
 *
 *  @param provider   the `BUYPaymentProvider`
 */
- (void)paymentProviderDidDismissCheckout:(id <BUYPaymentProvider>)provider;

/**
 *  Called when a checkout payment operation has failed
 *
 *  @param provider   the `BUYPaymentProvider`
 *  @param error    the optional `NSError`
 */
- (void)paymentProvider:(id <BUYPaymentProvider>)provider didFailWithError:(nullable NSError *)error;

/**
 *  Called when the checkout has completed
 *
 *  @param provider   the `BUYPaymentProvider`
 *  @param checkout the `BUYCheckout`
 *  @param status   the `BUYStatus` of the checkout
 */
- (void)paymentProvider:(id <BUYPaymentProvider>)provider didCompleteCheckout:(BUYCheckout *)checkout withStatus:(BUYStatus)status;

@end

@protocol BUYPaymentProvider <NSObject>

/**
 *  Starts the checkout process
 *
 *  @param checkout the `BUYCheckout`
 */
- (void)startCheckout:(BUYCheckout *)checkout;

/**
 *  Clears the current checkout in progress
 */
- (void)cancelCheckout;

/**
 *  The payment type identifier
 */
@property (nonatomic, readonly) NSString *identifier;

/**
 * The checkout object. If checkout has started, the checkout token will be set.
 */
@property (nonatomic, readonly) BUYCheckout *checkout;

/**
 *  Whether the payment provider is currently available given the current device and configuration of the `BUYPaymentProvider`
 */
@property (nonatomic, readonly, getter=isAvailable) BOOL available;

/**
 *  Returns YES if the checkout is currently in progress.  `startPaymentForCheckout` should not be called when a checkout is already in progress
 */
@property (nonatomic, readonly, getter=isInProgress) BOOL inProgress;

/**
 *  Delegate to receive callback messages
 */
@property (nonatomic, weak) id <BUYPaymentProviderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

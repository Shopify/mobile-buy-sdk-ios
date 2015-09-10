//
//  BUYApplePayHelpers.h
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
@import PassKit;

@class BUYClient;
@class BUYCheckout;

@interface BUYApplePayHelpers : NSObject

/**
 *  Initializes a helper to support Apple Pay
 *
 *  @param client   A configured client
 *  @param checkout The checkout which is to be completed using Apple Pay
 *
 *  @return helper object
 */
- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout;

/**
 *  Call this method in the PKPaymentAuthorizationViewControllerDelegate `paymentAuthorizationViewController:didAuthorizePayment:completion`
 *
 *  @param payment    the authorized payment
 *  @param completion completion block thats called after Shopify authorizes the payment
 */
- (void)updateAndCompleteCheckoutWithPayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus status))completion;

/**
 *  Call this method in the PKPaymentAuthorizationViewControllerDelegate `paymentAuthorizationViewController:didSelectPaymentMethod:completion`
 *
 *  @param shippingMethod The selected shipping method
 *  @param completion     the completion block called after shipping method is updated on the checkout
 */
- (void)updateCheckoutWithShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *methods))completion;

/**
 *  Call this method in the PKPaymentAuthorizationViewControllerDelegate `paymentAuthorizationViewController:didSelectShippingAddress:completion`
 *
 *  @param address    The selected shipping address
 *  @param completion the completion block called after the shipping address is updated on the checkout
 */
- (void)updateCheckoutWithAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray *shippingMethods, NSArray *summaryItems))completion NS_DEPRECATED_IOS(8_0, 9_0, "Use the CNContact backed `updateCheckoutWithContact:completion:` instead");

/**
 *  Call this method in the PKPaymentAuthorizationViewControllerDelegate `paymentAuthorizationViewController:didSelectShippingAddress:completion`
 *
 *  @param contact    The selected contact
 *  @param completion the completion block called after the shipping address is updated on the checkout
 */
- (void)updateCheckoutWithContact:(PKContact*)contact completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *shippingMethods, NSArray *summaryItems))completion NS_AVAILABLE_IOS(9_0);

/**
 *  The current checkout
 */
@property (nonatomic, strong, readonly) BUYCheckout *checkout;

/**
 *  The client used to communicate with Shopify
 */
@property (nonatomic, strong, readonly) BUYClient *client;

/**
 *  The last error message
 */
@property (nonatomic, strong, readonly) NSError *lastError;

@end

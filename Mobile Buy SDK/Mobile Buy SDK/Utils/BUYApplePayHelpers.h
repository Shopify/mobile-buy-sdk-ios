//
//  BUYApplePayHelpers.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-05-27.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
/**
 *  Call this method in the PKPaymentAuthorizationViewControllerDelegate `paymentAuthorizationViewController:didSelectShippingAddress:completion`
 *
 *  @param contact    The selected contact
 *  @param completion the completion block called after the shipping address is updated on the checkout
 */
- (void)updateCheckoutWithContact:(PKContact*)contact completion:(void (^)(PKPaymentAuthorizationStatus, NSArray *shippingMethods, NSArray *summaryItems))completion NS_AVAILABLE_IOS(9_0);
#endif

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

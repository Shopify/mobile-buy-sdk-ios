//
//  BUYViewController.h
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
@import PassKit;
#import "BUYClient.h"
#import "BUYCart.h"
#import "BUYCheckout.h"

@class BUYViewController;

@protocol BUYViewControllerDelegate <NSObject>

@optional

/**
 *  This is called if there is an error in creating the BUYCheckout. These problems include not being connected to the Internet,
 *  or if there is a validation error in the checkout.
 *
 *  @param controller The BUYViewController
 *  @param error      An NSError describing the failure
 */
- (void)controller:(BUYViewController *)controller failedToCreateCheckout:(NSError *)error;

/**
 *  This failure occurs when either the application is not properly configured to handle Apple Pay,
 *  or if the user does not have any credit cards configured in PassBook or cannot add any credit cards.
 *
 *  @param controller The BUYViewController
 */
- (void)controllerFailedToStartApplePayProcess:(BUYViewController *)controller;

/**
 *  This failure occurs whenever an update to BUYCheckout fails (shipping address, billing address, etc.)
 *
 *  @param controller The BUYViewController
 *  @param checkout   The BUYCheckout
 *  @param error      An NSError describing the failure
 */
- (void)controller:(BUYViewController *)controller failedToUpdateCheckout:(BUYCheckout *)checkout withError:(NSError *)error;

/**
 *  This failure occurs when shipping rates cannot be retrieved.
 *
 *  @param controller The BUYViewController
 *  @param checkout   The BUYCheckout
 *  @param error      An NSError describing the failure
 */
- (void)controller:(BUYViewController *)controller failedToGetShippingRates:(BUYCheckout *)checkout withError:(NSError *)error;

/**
 *  This failure occurs whenever completing a checkout fails.
 *  This can occur if there is missing payment information or if the shop is improperly configured.
 *
 *  @param controller The BUYViewController
 *  @param checkout   The BUYCheckout
 *  @param error      An NSError describing the failure
 */
- (void)controller:(BUYViewController *)controller failedToCompleteCheckout:(BUYCheckout *)checkout withError:(NSError *)error;

/**
 *  This is called whenever the checkout fully completes, success or failure.
 *
 *  @param controller The BUYViewController
 *  @param checkout   The BUYCheckout
 *  @param status     Checkout status BUYStatus
 */
- (void)controller:(BUYViewController *)controller didCompleteCheckout:(BUYCheckout *)checkout status:(BUYStatus)status;

/**
 *  This is called when the Apple Pay Authorization View Controller has been dismissed.
 *  It will be called if the user cancels Apple Pay or the authorization was successful and the Apple Pay
 *  payment confirmation was shown to the user.
 *
 *  Note: If the PKPaymentAuthorizationStatus is not PKPaymentAuthorizationStatusSuccess we will expire the checkout by
 *  calling `expireCheckout:completion:` to release the hold on the product inventory.
 *
 *  @param controller The BUYViewController
 *  @param checkout   The BUYCheckout
 */
- (void)controller:(BUYViewController *)controller didDismissApplePayControllerWithStatus:(PKPaymentAuthorizationStatus)status forCheckout:(BUYCheckout *)checkout;

/**
 *  This is called when the SFSafariViewController has been dismissed before checkout completion.
 *
 *  @param controller The BUYViewController
 *  @param checkout   The BUYCheckout
 */
- (void)controller:(BUYViewController *)controller didDismissWebCheckout:(BUYCheckout *)checkout;

/**
 *  The view controller has been dismissed
 *
 *  @param controller The BUYViewController
 */
- (void)didDismissViewController:(BUYViewController *)controller;

@optional

/**
 *  Called when the user chooses to checkout via web checkout which will open Safari
 *
 *  @param viewController the view controller
 */
- (void)controllerWillCheckoutViaWeb:(BUYViewController *)viewController;

/**
 *  Called when the user chooses to checkout via Apple Pay
 *
 *  @param viewController the view controller
 */
- (void)controllerWillCheckoutViaApplePay:(BUYViewController *)viewController;

@end

/**
 *  This base class guides you through the entire Apple Pay process.
 */
@interface BUYViewController : UIViewController <PKPaymentAuthorizationViewControllerDelegate>

/**
 *  Register yourself as a BUYViewControllerDelegate to handle all errors, and status changes.
 */
@property (nonatomic, weak) id <BUYViewControllerDelegate> delegate;

/**
 *  Set the BUYClient using the provided initializer method `initWithClient:` or
 *  if using Storyboards, override after Storyboard initialization.
 */
@property (nonatomic, strong) BUYClient *client;

/**
 *  The associated shop. setting this prior to displaying will prevent another network request
 */
@property (nonatomic, strong) BUYShop *shop;

/**
 *  The merchant ID used for Apple Pay
 */
@property (nonatomic, strong) NSString *merchantId;

/**
 *  Returns YES if the following conditions are met:
 *  - the device hardware is capable of using Apple Pay
 *  - the device has a payment card setup
 *  - the merchant ID has been set to use Apple Pay
 */
@property (nonatomic, assign, readonly) BOOL isApplePayAvailable;

/**
 *  The current checkout object
 */
@property (nonatomic, strong, readonly) BUYCheckout *checkout;

/**
 *  Loads the shop details
 *
 *  @param block callback block called on completion
 */
- (void)loadShopWithCallback:(void (^)(BOOL, NSError *))block;

#pragma mark - Apple Pay Overrides

/**
 *  The supported credit card payment networks. 
 *  iOS 8.3: PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa.
 *  iOS 9.0: PKPaymentNetworkAmex, PKPaymentNetworkDiscover, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa.
 */
@property (nonatomic, copy) NSArray *supportedNetworks;

/**
 *  Override point to return a custom payment request
 *
 *  The default merchantCapability is PKMerchantCapability3DS
 *
 *  @return a new payment request object
 */
- (PKPaymentRequest *)paymentRequest;

#pragma mark - Checkout Process

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Creates a BUYViewController using your
 *
 *  @param client A BUYClient configured to your shop
 *
 *  @return		  A BUYViewController
 */
- (instancetype)initWithClient:(BUYClient *)client;

/**
 *  Start an Apple Pay checkout with a BUYCheckout object.
 *  The checkout object will be created or updated on Shopify 
 *  before proceeding with the Apple Pay checkout
 *
 *  @param checkout A BUYCheckout object to start an Apple Pay checkout with
 */
- (void)startApplePayCheckout:(BUYCheckout *)checkout;

/**
 *  Start a responsive web checkout with a BUYCheckout object.
 *  This call will jump out to Safari and the shop's responsive web checkout.
 *  The checkout object will be created or updated on Shopify
 *  before proceeding with the responsive web checkout
 *
 *  @param checkout A BUYCheckout object to start a web checkout with
 */
- (void)startWebCheckout:(BUYCheckout *)checkout;

/**
 *  Creates a checkout using a web cart's token.
 *  This is useful when handing off the cart from a WKWebView to an Apple Pay checkout.
 *
 *  @param token Cart token from your Shopify store's storefront
 */
- (void)startCheckoutWithCartToken:(NSString *)token;

/**
 *  Override this method if you want to perform any actions before information the delegate
 *
 *  @param checkout The completed BUYCheckout
 *  @param status   The status of the BUYCheckout
 */
- (void)checkoutCompleted:(BUYCheckout *)checkout status:(BUYStatus)status;

/**
 *  Call this method from the application delegate method openURL:sourceApplication:annotation when returning from a web checkout
 *
 *  @param url the NSURL passed in to the app delegate
 */
+ (void)completeCheckoutFromLaunchURL:(NSURL *)url;

@end

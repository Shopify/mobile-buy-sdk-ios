//
//  BUYViewController.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
@import PassKit;
#import "BUYClient.h"
#import "BUYCart.h"
#import "BUYCheckout.h"

@class BUYViewController;

@protocol BUYViewControllerDelegate <NSObject>

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

@end

/**
 *  This base class guides you through the entire Apple Pay process.
 */
@interface BUYViewController : UIViewController

/**
 *  Register yourself as a BUYViewControllerDelegate to handle all errors, and status changes.
 */
@property (nonatomic, weak) id <BUYViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) BUYClient *provider;

#pragma mark - Apple Pay Overrides

/**
 *  The supported credit card payment networks. As of iOS 8.3: PKPaymentNetworkAmex, PKPaymentNetworkMasterCard and PKPaymentNetworkVisa are the only valid options.
 *
 *  The default value is to support all three.
 */
@property (nonatomic, copy) NSArray *supportedNetworks;

/**
 *  The country code for the PKPaymentRequest.
 *
 *  The default value is `US`
 */
@property (nonatomic, copy) NSString *countryCode;

/**
 *  The currency code for the PKPaymentRequest.
 *
 *  The default value is `USD`
 */
@property (nonatomic, copy) NSString *currencyCode;

/**
 *  The merchant capabilities (see PKMerchantCapability).
 *
 *  The default value is PKMerchantCapability3DS
 */
@property (nonatomic, assign) PKMerchantCapability merchantCapability;

#pragma mark - Checkout Process

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Creates a BUYViewController using your
 *
 *  @param dataProvider a dataProvider configured to your shop
 *
 *  @return A BUYViewController
 */
- (instancetype)initWithDataProvider:(BUYClient *)dataProvider;

/**
 *  Creates a checkout with a pre-existing cart.
 *
 *  @param cart A pre-existing BUYCart to start a checkout with
 */
- (void)startCheckoutWithCart:(BUYCart *)cart;

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

@end

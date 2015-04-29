//
//  CHKViewController.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
@import PassKit;

#import "CHKDataProvider.h"
#import "CHKCart.h"
#import "CHKCheckout.h"

@class CHKViewController;

@protocol CHKViewControllerDelegate <NSObject>

/**
 * This is called if there is an error in creating the checkout. These problems may range from not being connected to the internet, or if there is a validation error in the checkout.
 */
- (void)controller:(CHKViewController *)controller failedToCreateCheckout:(NSError *)error;

/**
 * This failure occurs when either the application is not properly configured to handle ApplePay, or if the user does not have any credit cards configured in PassBook / cannot add any.
 */
- (void)controllerFailedToStartApplePayProcess:(CHKViewController *)controller;

/**
 * This failure occurs whenever an update to checkout fails (shipping address, billing address, etc.)
 */
- (void)controller:(CHKViewController *)controller failedToUpdateCheckout:(CHKCheckout *)checkout withError:(NSError *)error;

/**
 * This failure occurs whenever a fetch of shipping rates fails.
 */
- (void)controller:(CHKViewController *)controller failedToGetShippingRates:(CHKCheckout *)checkout withError:(NSError *)error;

/**
 * This failure occurs whenever completing a checkout fails. This will occur if there is missing payment information or if the shop is improperly configured.
 */
- (void)controller:(CHKViewController *)controller failedToCompleteCheckout:(CHKCheckout *)checkout withError:(NSError *)error;

/**
 * This is called whenever the checkout fully completes, success or failure.
 */
- (void)controller:(CHKViewController *)controller didCompleteCheckout:(CHKCheckout *)checkout status:(CHKStatus)status;

@end

/**
 * This base class effectively walks you through the entire ApplePay process.
 */
@interface CHKViewController : UIViewController

/**
 * Register yourself as a delegate to handle all errors, and status changes.
 */
@property (nonatomic, weak) id <CHKViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) CHKDataProvider *provider;

#pragma mark - Apple Pay Overrides

/**
 * The supported credit card payment networks. As of iOS 8: PKPaymentNetworkAmex, PKPaymentNetworkMasterCard and PKPaymentNetworkVisa are the only valid options.
 *
 * The default value is to support all three.
 */
@property (nonatomic, copy) NSArray *supportedNetworks;

/**
 * The country code for the PKPaymentRequest.
 *
 * The default value is `US`
 */
@property (nonatomic, copy) NSString *countryCode;

/**
 * The currency code for the PKPaymentRequest.
 *
 * The default value is `USD`
 */
@property (nonatomic, copy) NSString *currencyCode;

/**
 * The merchant capabilities (see PKMerchantCapability).
 *
 * The default value is PKMerchantCapability3DS
 */
@property (nonatomic, assign) PKMerchantCapability merchantCapability;

#pragma mark - Checkout Process

/**
 * Creates a CHKCheckout controller using your shop address, api key, and merchant id
 *
 * `shopAddress` - This is your shopify domain. For example "snowdevil.myshopify.com"
 * `apiKey` - This is the API Key for your application on Shopify.
 * `merchantId` - This is the merchant id you have set up with Apple.
 */
- (instancetype)initWithShopAddress:(NSString *)shopAddress apiKey:(NSString *)apiKey merchantId:(NSString *)merchantId NS_DESIGNATED_INITIALIZER;

/**
 * Creates a checkout with a pre-existing cart.
 */
- (void)startCheckoutWithCart:(CHKCart *)cart;

/**
 * Creates a checkout using a web cart's token. This is useful when handing off the cart from a WebView to an Apple Pay checkout.
 */
- (void)startCheckoutWithCartToken:(NSString *)token;

/**
 * You can override this if you want to perform any actions before informing the delegate
 */
- (void)checkoutCompleted:(CHKCheckout *)checkout status:(CHKStatus)status;

@end

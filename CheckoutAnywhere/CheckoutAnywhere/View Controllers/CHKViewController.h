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
 *  This is called if there is an error in creating the CHKCheckout. These problems include not being connected to the Internet, 
 *  or if there is a validation error in the checkout.
 *
 *  @param controller The CHKViewController
 *  @param error      An NSError describing the failure
 */
- (void)controller:(CHKViewController *)controller failedToCreateCheckout:(NSError *)error;

/**
 *  This failure occurs when either the application is not properly configured to handle Apple Pay, 
 *  or if the user does not have any credit cards configured in PassBook or cannot add any credit cards.
 *
 *  @param controller The CHKViewController
 */
- (void)controllerFailedToStartApplePayProcess:(CHKViewController *)controller;

/**
 *  This failure occurs whenever an update to CHKCheckout fails (shipping address, billing address, etc.)
 *
 *  @param controller The CHKViewController
 *  @param checkout   The CHKCheckout
 *  @param error      An NSError describing the failure
 */
- (void)controller:(CHKViewController *)controller failedToUpdateCheckout:(CHKCheckout *)checkout withError:(NSError *)error;

/**
 *  This failure occurs when shipping rates cannot be retrieved.
 *
 *  @param controller The CHKViewController
 *  @param checkout   The CHKCheckout
 *  @param error      An NSError describing the failure
 */
- (void)controller:(CHKViewController *)controller failedToGetShippingRates:(CHKCheckout *)checkout withError:(NSError *)error;

/**
 *  This failure occurs whenever completing a checkout fails. 
 *  This can occur if there is missing payment information or if the shop is improperly configured.
 *
 *  @param controller The CHKViewController
 *  @param checkout   The CHKCheckout
 *  @param error      An NSError describing the failure
 */
- (void)controller:(CHKViewController *)controller failedToCompleteCheckout:(CHKCheckout *)checkout withError:(NSError *)error;

/**
 *  This is called whenever the checkout fully completes, success or failure.
 *
 *  @param controller The CHKViewController
 *  @param checkout   The CHKCheckout
 *  @param status     Checkout status CHKStatus
 */
- (void)controller:(CHKViewController *)controller didCompleteCheckout:(CHKCheckout *)checkout status:(CHKStatus)status;

@end

/**
 *  This base class guides you through the entire Apple Pay process.
 */
@interface CHKViewController : UIViewController

/**
*  Register yourself as a CHKViewControllerDelegate to handle all errors, and status changes.
*/
@property (nonatomic, weak) id <CHKViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) CHKDataProvider *provider;

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

/**
 *  Creates a CHKViewController using your shop address, api key, and merchant id
 *
 *  @param shopAddress This is your shopify domain. For example "snowdevil.myshopify.com"
 *  @param apiKey      This is the API Key for your application on Shopify.
 *  @param merchantId  This is the merchant id you have set up with Apple.
 *
 *  @return A CHKViewController
 */
- (instancetype)initWithShopAddress:(NSString *)shopAddress apiKey:(NSString *)apiKey merchantId:(NSString *)merchantId NS_DESIGNATED_INITIALIZER;

/**
 *  Creates a checkout with a pre-existing cart.
 *
 *  @param cart A pre-existing CHKCart to start a checkout with
 */
- (void)startCheckoutWithCart:(CHKCart *)cart;

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
 *  @param checkout The completed CHKCHeckout
 *  @param status   The status of the CHKCheckout
 */
- (void)checkoutCompleted:(CHKCheckout *)checkout status:(CHKStatus)status;

@end

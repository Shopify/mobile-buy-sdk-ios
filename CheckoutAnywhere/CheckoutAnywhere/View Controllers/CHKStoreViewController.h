//
//  CHKStoreViewController.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
#import "CHKViewController.h"

extern NSString * const CHKShopifyError;

typedef NS_ENUM(NSUInteger, CHKCheckoutType){
	CHKheckoutTypeNormal,
	CHKCheckoutTypeApplePay,
	CHKCheckoutTypeCancel
};

typedef NS_ENUM(NSUInteger, CHKCheckoutError) {
    CHKCheckoutError_CartFetchError
};

typedef void (^CHKCheckoutTypeBlock)(CHKCheckoutType type);

@class CHKStoreViewController;

/**
 *  The CHKStoreViewControllerDelegate protocol implements methods related to the checkout process
 */
@protocol CHKStoreViewControllerDelegate <CHKViewControllerDelegate>

/**
 *  Tells the delegate that the user has proceeded to checkout. Use this opportunity to present an interface to a
 *  user to choose between checking out with Apple Pay or standard webcheckout.
 *  Note: Before presenting an option for Apple Pay, check if the device is setup to do so by calling `[PKPaymentAuthorizationViewController canMakePayments]`
 *
 *  @param controller        The controller with an embedded WKWebView displaying the Shopify store
 *  @param completionHandler (^CHKCheckoutTypeBlock)(CHKCheckoutType type);
 */
- (void)controller:(CHKStoreViewController *)controller shouldProceedWithCheckoutType:(CHKCheckoutTypeBlock)completionHandler;

@end

/**
 *  This controller shows you how to build a controller that embeds a WKWebView (iOS 8+) with your store in it.
 *  This means that you can show off your store and its sleek responsive design without having to build a full native app to showcase it.
 *
 *  There are a few approaches that you can take, this app shows you a couple:
 *
 *  1. Only present Apple Pay in your /checkout. When the user taps 'Checkout' you can present the user an 
 *     Apple Pay button, or allow them to continue on as normal. This approach does NOT require any changes
 *     to the web storefront.
 *
 *  2. Add 'Buy With  Pay' buttons on individual product pages and/or a ' Pay' button in your /checkout.
 *     This approach REQUIRES a few small changes to the web storefront to work. Refer to the app.js file 
 *     located within the SDK. General knowledge of Liquid and Shopify's theming is required system to get this working.
 */
@interface CHKStoreViewController : CHKViewController

- (instancetype)initWithShopAddress:(NSString *)shopAddress apiKey:(NSString *)apiKey merchantId:(NSString *)merchantId url:(NSURL *)url;

@property (nonatomic, weak) id <CHKStoreViewControllerDelegate> delegate;

@end

//
//  CHKViewController.h
//  Checkout
//
//  Created by Joshua Tessier on 2015-02-10.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;

#import "CHKViewController.h"

@class CHKStoreController;

@protocol CHKStoreController <CHKControllerDelegate>

- (void)controllerShouldPresentPaymentSelection:(CHKStoreController *)controller;

@end

/**
 * This example controller shows you how to build a controller that embeds a WKWebView (iOS 8+) with your store in it. This means that
 * you can show off your store and its sleek responsive design without having to build a full native app to showcase it.
 *
 * There are a few approaches that you can take, this app shows you a couple:
 *
 * 1. Only present ApplePay to /checkout. When the user attempts to press 'Checkout' you can present the user the ApplePay button, or allow them to continue on as normal.
 *    This approach does NOT require any changes to the actual storefront.
 *
 * 2. Add ApplePay 'Pay' buttons on individual product pages and on checkout.
 *    This approach REQUIRES a few small changes to the storefront to work. (See .m file)
 *    You will need **some** knowledge of liquid and Shopify's theming system to get this working.
 */
@interface CHKStoreController : CHKViewController

- (instancetype)initWithShopAddress:(NSString *)shopAddress apiKey:(NSString *)apiKey merchantId:(NSString *)merchantId url:(NSURL *)url;

@property (nonatomic, weak) id <CHKStoreController> delegate;

- (void)checkoutWithApplePay;

- (void)checkoutWithNormalCheckout;

@end

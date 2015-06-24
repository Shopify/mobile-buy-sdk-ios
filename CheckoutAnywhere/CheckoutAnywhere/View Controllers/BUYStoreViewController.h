//
//  BUYStoreViewController.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
#import "BUYViewController.h"

extern NSString * const BUYShopifyError;

typedef NS_ENUM(NSUInteger, BUYCheckoutType){
	BUYCheckoutTypeNormal,
	BUYCheckoutTypeApplePay,
	BUYCheckoutTypeCancel
};

typedef NS_ENUM(NSUInteger, BUYCheckoutError) {
	BUYCheckoutError_CartFetchError
};

typedef void (^BUYCheckoutTypeBlock)(BUYCheckoutType type);

@class BUYStoreViewController;

/**
 *  The BUYStoreViewControllerDelegate protocol implements methods related to the checkout process
 */
@protocol BUYStoreViewControllerDelegate <BUYViewControllerDelegate>

/**
 *  Tells the delegate that the user has proceeded to checkout. Use this opportunity to present an interface to a
 *  user to choose between checking out with Apple Pay or standard webcheckout.
 *  Note: Before presenting an option for Apple Pay, check if the device is setup to do so by calling `[PKPaymentAuthorizationViewController canMakePayments]`
 *
 *  @param controller        The controller with an embedded WKWebView displaying the Shopify store
 *  @param completionHandler (^BUYCheckoutTypeBlock)(BUYCheckoutType type);
 */
- (void)controller:(BUYStoreViewController *)controller shouldProceedWithCheckoutType:(BUYCheckoutTypeBlock)completionHandler;

@end

/**
 *  This controller shows you how to build a controller that embeds a WKWebView (iOS 8+) with your store in it.
 *  This means that you can show off your store and its sleek responsive design without having to build a full native app to showcase it.
 */
@interface BUYStoreViewController : BUYViewController

/**
 *  Creates a view controller with an embedded webview to show the shops storefront
 *
 *  @param client    The client configured to your shop
 *  @param url       The address where the shop can be viewed
 *
 *  @return the BUYStoreViewController instance
 */
- (instancetype)initWithClient:(BUYClient *)client url:(NSURL *)url;

@property (nonatomic, weak) id <BUYStoreViewControllerDelegate> delegate;

@end

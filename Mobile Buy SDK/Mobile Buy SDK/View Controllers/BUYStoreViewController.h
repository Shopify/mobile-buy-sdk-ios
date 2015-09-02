//
//  BUYStoreViewController.h
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
#import "BUYViewController.h"
#import "BUYError.h"

typedef NS_ENUM(NSUInteger, BUYCheckoutType){
	BUYCheckoutTypeNormal,
	BUYCheckoutTypeApplePay,
	BUYCheckoutTypeCancel
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

/**
 *  Jumps back to the shops home page
 */
- (void)reloadHomePage;

@property (nonatomic, weak) id <BUYStoreViewControllerDelegate> delegate;

@end

//
//  ProductViewController.h
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
@import Buy;

#import "Theme.h"
#import "PaymentViewController.h"

@interface ProductViewController : PaymentViewController

/**
 *  Creates a BUYProductViewController with a BUYClient and a theme
 *  Note: Use this initializer to instatiate a BUYProdctViewController
 *  with a custom theme. If you don't need to customize the theme
 *  use `initWithClient:`
 *
 *  @param client A BUYClient configured to your shop
 *  @param theme  A Theme
 *
 *  @return		  A PaymentViewController
 */
- (instancetype)initWithClient:(BUYClient *)client theme:(Theme *)theme;

/**
 *  Creates a BUYProductViewController with a BUYClient and a cart
 *
 *  @param client A BUYClient configured to your shop
 *  @param cart   A cart that enables a "Add to cart" button instead of the web checout button
 *
 *  @return		  A PaymentViewController with an "Add to cart" button
 */
- (instancetype)initWithClient:(BUYClient *)client cart:(BUYCart *)cart;

/**
 *  Alternative method when setting the product (and optionally, shop) directly on the view controller
 *
 *  @param product  the product to display
 *  @param completion block called when view controller is ready for display. Called on main thread
 */
- (void)loadWithProduct:(BUYProduct *)product completion:(void (^)(BOOL success, NSError *error))completion;

/**
 *  The loaded product ID
 */
@property (nonatomic, strong, readonly) NSString *productId;

/**
 *  The product to be displayed.  This can be set before presentation instead of calling loadProduct:completion:
 */
@property (nonatomic, strong, readonly) BUYProduct *product;

/**
 *  Returns YES when the view controller is loading data.  loadProduct: or loadWithProduct: should not be called when data is already loading
 */
@property (nonatomic, assign, readonly) BOOL isLoading;

/**
 *  This is a convenience method as an alternative to presentViewController: which will force portrait orientation.  This method is only 
 *  required when presenting from a landscape view controller.
 *
 *  @param controller The view controller where the BUYProductViewController is to be presented on
 */
- (void)presentPortraitInViewController:(UIViewController *)controller;

@end



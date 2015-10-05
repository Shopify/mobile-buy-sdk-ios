//
//  BUYProductView.h
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
@class BUYProductViewHeader;
@class BUYProductViewHeaderBackgroundImageView;
@class BUYProductViewFooter;
@class BUYGradientView;
@class BUYTheme;
@class BUYImage;
@class BUYProduct;

/**
 *  The BUYProductViewController's main view, containing everything needed to display the UI for the product
 */
@interface BUYProductView : UIView

/**
 *  The table view containg the product's image(s) in the tableHeaderView, title, price, 
 *  description and variant options
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  The product view includes a blurred product image as the background. The table view's background 
 *  is clear for this reason. This view ensures the bottom part of the table view is always opaque and only
 *  the background of the product image(s) shows a blurred product image.
 */
@property (nonatomic, strong) UIView *stickyFooterView;

/**
 *  A constraint that managed the height for the stickyFooterView
 */
@property (nonatomic, strong) NSLayoutConstraint *footerHeightLayoutConstraint;

/**
 *  A constraint that managed the offset for the stickyFooterView based on the current scroll offset
 */
@property (nonatomic, strong) NSLayoutConstraint *footerOffsetLayoutConstraint;

/**
 *  The tableHeaderView containting the product image(s) (if available)
 */
@property (nonatomic, strong) BUYProductViewHeader *productViewHeader;
@property (nonatomic, strong) BUYProductViewHeaderBackgroundImageView *backgroundImageView;

/**
 *  The footer view containing the Checkout button, and - if enabled - Apple Pay button.
 */
@property (nonatomic, strong) BUYProductViewFooter *productViewFooter;

/**
 *  A gradient view that sits at the top of the product images (if available).
 *  This view is invisible when the navigation bar is visible.
 */
@property (nonatomic, strong) BUYGradientView *topGradientView;

/**
 *  The theme of the product view.
 */
@property (nonatomic, weak) BUYTheme *theme;

/**
 *  Helps determine logic for setting up product images in the BUYProductViewController
 */
@property (nonatomic, assign) BOOL hasSetVariantOnCollectionView;

/**
 *  Initializer for the product view using a rect, product to display and theme
 *
 *  @param rect              The rect is needed for the UICollectionView in the BUYProductViewHeader to setup the cell's bounds
 *  @param product           The product to display in the product view. Only used in the initializer to
 *  @param theme             The theme for the product view
 *  @param showApplePaySetup Show Apple Pay button with 'Set Up Apple Pay' text as determined by the presenter
 *
 *  @return An instance of the BUYProductView
 */
- (instancetype)initWithFrame:(CGRect)rect product:(BUYProduct*)product theme:(BUYTheme*)theme shouldShowApplePaySetup:(BOOL)showApplePaySetup;

/**
 *  The BUYProductViewController is the UITableViewDelegate, so it receives the UIScrollView delegate method calls. 
 *  This method allows for forward-handling of these calls to update the product images and other UI elements accordingly.
 *
 *  @param scrollView The UIScrollView being scrolled in the BUYProductViewController
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 *  Updates the blurred product image behind the table view when the product image change.
 *
 *  @param images An array of product images.
 */
- (void)updateBackgroundImage:(NSArray *)images;

/**
 *  An toast error view above the checkout button(s) to use for display of an error when creating a checkout for Apple Pay.
 *
 *  @param errorMessage The error message to display.
 */
- (void)showErrorWithMessage:(NSString*)errorMessage;

/**
 *  The inset for the table view and scroll indicator, allowing for custom insets.
 *
 *  @param edgeInsets           The edge inset to set for the table view.
 *  @param appendToCurrentInset A flag that allows for adding the edge insets to the current edgeinsets of the table view.
 */
- (void)setInsets:(UIEdgeInsets)edgeInsets appendToCurrentInset:(BOOL)appendToCurrentInset;

/**
 *  Sets the top inset specifically for when the product view is pushed into a navigation controller stack
 *  instead of presented modally.
 *
 *  @param topInset The inset to use for insetting the product view inside the container.
 */
- (void)setTopInset:(CGFloat)topInset;

@end

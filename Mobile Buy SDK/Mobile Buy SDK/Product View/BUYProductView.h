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

#import <UIKit/UIKit.h>
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
@property (nonatomic, strong) BUYGradientView *topGradientView;
@property (nonatomic, weak) BUYTheme *theme;
@property (nonatomic, assign) BOOL hasSetVariantOnCollectionView;

- (instancetype)initWithFrame:(CGRect)rect product:(BUYProduct*)product theme:(BUYTheme*)theme;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)updateBackgroundImage:(NSArray *)images;
- (void)showErrorWithMessage:(NSString*)errorMessage;
- (void)setInsets:(UIEdgeInsets)edgeInsets appendToCurrentInset:(BOOL)appendToCurrentInset;

@end

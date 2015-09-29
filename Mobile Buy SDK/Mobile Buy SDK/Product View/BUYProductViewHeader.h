//
//  BUYProductViewHeader.h
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
@class BUYImageView;
@class BUYProductVariant;
@class BUYTheme;
@class BUYProductViewHeaderOverlay;

/**
 *  The tableHeaderView containing a horizontally scrolling collection view
 *  that display product images.
 */
@interface BUYProductViewHeader : UIView

/**
 *  A horiztonally scrolling collection view containing product images.
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  An overlay view containing effects views (light or dark view and a UIVisualEffectsView) that becomes
 *  visible as the user scrolls the contents up. This provides a more seamless transition for the navigation bar.
 */
@property (nonatomic, strong) BUYProductViewHeaderOverlay *productViewHeaderOverlay;

/**
 *  Initializer with a frame to setup the product image collection view and theme the header
 *
 *  @param frame Used for setting up the correct size of the collection view cells
 *  @param theme The theme for the product view
 *
 *  @return The product view header to display in the BUYProductViewController's table view tableHeaderView
 */
- (instancetype)initWithFrame:(CGRect)frame theme:(BUYTheme*)theme;

/**
 *  A method to set the content offset of the table view and calculate the height of the image
 *  used to set the correct height and offset for the stickyFooterView in the BUYProductView.
 *
 *  @param scrollView The table view being scrolled
 *
 *  @return The height for the product image.
 */
- (CGFloat)imageHeightWithScrollViewDidScroll:(UIScrollView *)scrollView;

/**
 *  Updates the page control with the currently display product image index.
 *
 *  @param currentPage The current index for the product image displayed.
 */
- (void)setCurrentPage:(NSInteger)currentPage;

/**
 *  When a BUYProductVariant is set update the product images accordingly by scrolling to the image
 *  matching the selected product variant.
 *
 *  @param productVariant The selected product variant.
 *  @param images         An array of product images for a product.
 */
- (void)setImageForSelectedVariant:(BUYProductVariant*)productVariant withImages:(NSArray*)images;

@end

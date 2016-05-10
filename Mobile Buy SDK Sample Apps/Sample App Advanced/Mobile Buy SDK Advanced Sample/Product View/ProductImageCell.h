//
//  ProductImageCell.h
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
@class AsyncImageView;

/**
 *  A custom collection view cell for the BUYProductViewController's product image(s)
 */
@interface ProductImageCell : UICollectionViewCell

/**
 *  The image view containing a product image
 */
@property (nonatomic, strong) AsyncImageView *productImageView;

/**
 *  The height to display the product image
 */
@property (nonatomic, strong) NSLayoutConstraint *productImageViewConstraintHeight;

/**
 *  The bottom contraints which takes care of the parallax effect when scrolling up
 */
@property (nonatomic, strong) NSLayoutConstraint *productImageViewConstraintBottom;

/**
 *  Forward the BUYProductViewController's table view scroll content offset to adjust the image height and parallax effect
 *
 *  @param offset The current table view content offset
 */
- (void)setContentOffset:(CGPoint)offset;

@end

//
//  ImageKit.h
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

@import Foundation;
@import UIKit;

/**
 *  Image generator for a variety of images using the BUYProductViewController.
 */
@interface ImageKit : NSObject

/**
 *  Generates a close button image for the variant selection navigation bar.
 *
 *  @param frame The frame size of the image
 *
 *  @return A close button image
 */
+ (UIImage*)imageOfVariantCloseImageWithFrame: (CGRect)frame;

/**
 *  Generates a checkmark image for use of displaying the previously selected variant
 *
 *  @param frame The frame size of the image
 *
 *  @return A checkmark for the previous variant selection
 */
+ (UIImage*)imageOfPreviousSelectionIndicatorImageWithFrame: (CGRect)frame;

/**
 *  Generates a custom disclosure indicator image
 *
 *  @param frame The frame size of the image
 *  @param color The color for the disclosure indicator
 *
 *  @return A disclusore indicator image
 */
+ (UIImage*)imageOfDisclosureIndicatorImageWithFrame: (CGRect)frame color:(UIColor*)color;

/**
 *  Generates a close button image for the product view's navigation bar
 *
 *  @param frame     The frame size of the image
 *  @param color     The color for the close button image
 *  @param hasShadow True if the X should have a drop shadow
 *
 *  @return A close button image
 */
+ (UIImage*)imageOfProductViewCloseImageWithFrame: (CGRect)frame color:(UIColor*)color hasShadow:(BOOL)hasShadow;

/**
 *  Generates a custom back button image for the variant selection navigation bar
 *
 *  @param frame The frame size of the image
 *
 *  @return A custom back button image
 */
+ (UIImage*)imageOfVariantBackImageWithFrame: (CGRect)frame;

@end

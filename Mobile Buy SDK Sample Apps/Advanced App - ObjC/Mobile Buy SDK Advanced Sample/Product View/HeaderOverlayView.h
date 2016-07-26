//
//  HeaderOverlayView.h
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

/**
 *  An overlay + blur effect when the product view scrolls up
 *  to hide the image view and create a nice transition into
 *  the navigation bar.
 */
@interface HeaderOverlayView : UIView

@property (nonatomic) UIColor *overlayBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 *  Used to determine the current visibility of the effect based on content offset and the navigationbar height.
 *
 *  @param scrollView          The product view's table view being scrolled.
 *  @param navigationBarHeight The navigation bar height so the effect is at 100% when the content reaches the navigation bar's bottom.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView withNavigationBarHeight:(CGFloat)navigationBarHeight;

@end

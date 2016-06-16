//
//  OptionBreadCrumbsView.h
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
 *  A view containing the current selection of variant option values that sits below the navigation controller for the variant selection.
 */
@interface OptionBreadCrumbsView : UIView

/**
 *  Auto Layout constraint for setting the bread crumbs as hidden
 */
@property (nonatomic, strong) NSLayoutConstraint *hiddenConstraint;

/**
 *  Auto Layout constraint for setting the bread crumbs as visible
 */
@property (nonatomic, strong) NSLayoutConstraint *visibleConstraint;

/**
 *  Sets the text on the labels and animates the view and the labels
 *
 *  @param optionValues The current selection (may be empty) of option values
 */
- (void)setSelectedBuyOptionValues:(NSArray*)optionValues;

/**
 *  The color of the labels
 */
-(void)setVariantOptionTextColor:(UIColor*)color UI_APPEARANCE_SELECTOR;

@end

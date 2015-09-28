//
//  BUYOptionValueCell.h
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
@class BUYTheme;
@class BUYOptionValue;
@class BUYProductVariant;

/**
 *  A table view cell displaying the option value
 */
@interface BUYOptionValueCell : UITableViewCell

/**
 *  Image view containing a checkmark for current option value selection
 */
@property (nonatomic, strong) UIImageView *selectedImageView;

/**
 *  Sets the option value and adds additional values such as price/sold out text based on the product variant's available
 *
 *  @param optionValue       The option value to display
 *  @param productVariant    The product variant matching the option value
 *  @param currencyFormatter A formatter with the shop's currency
 *  @param theme             The current theme
 */
- (void)setOptionValue:(BUYOptionValue *)optionValue productVariant:(BUYProductVariant*)productVariant currencyFormatter:(NSNumberFormatter*)currencyFormatter theme:(BUYTheme *)theme;

@end


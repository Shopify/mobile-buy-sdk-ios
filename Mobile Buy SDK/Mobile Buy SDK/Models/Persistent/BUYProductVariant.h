//
//  _BUYProductVariant.h
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

#import <Buy/_BUYProductVariant.h>
NS_ASSUME_NONNULL_BEGIN

@class BUYOptionValue;

@interface BUYProductVariant : _BUYProductVariant {}

/**
 *  Returns the option value for the given name
 *
 *  @param optionName name of the option
 *
 *  @return the option value
 */
- (nullable BUYOptionValue *)optionValueForName:(NSString *)optionName;

/**
 *  Filters array of product variants filtered based on a selected option value
 *
 *  @param productVariants BUYProductVariant objects to filter
 *  @param optionValue     The option value to filter with
 *
 *  @return A filtered copy of the original array
 */
+ (NSArray *)filterProductVariants:(NSArray *)productVariants forOptionValue:(BUYOptionValue *)optionValue;

@end

NS_ASSUME_NONNULL_END

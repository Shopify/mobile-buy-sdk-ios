//
//  _BUYCartLineItem.h
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

#import <Buy/_BUYCartLineItem.h>
NS_ASSUME_NONNULL_BEGIN

/**
 * Newly inserted `CartLineItem`s have an initial quantity of 1.
 */
@interface BUYCartLineItem : _BUYCartLineItem {}

/**
 * Convenience method for access the identifier of the underlying variant.
 */
- (NSNumber *)variantId;

/**
 * The variant price times the quantity.
 */
@property (nonatomic, readonly) NSDecimalNumber *linePrice;

/**
 * Add the amount to the current quantity.
 */
- (NSDecimalNumber *)addQuantity:(NSDecimalNumber *)amount;

/**
 * Subtract the amount from the current quantity.
 */
- (NSDecimalNumber *)subtractQuantity:(NSDecimalNumber *)amount;

/**
 * Add 1 to the existing quantity;
 */
- (NSDecimalNumber *)incrementQuantity;

/**
 * Subtract 1 from the existing quantity.
 */
- (NSDecimalNumber *)decrementQuantity;

@end

@interface BUYModelManager (BUYCartLineItemCreation)

- (BUYCartLineItem *)cartLineItemWithVariant:(BUYProductVariant *)variant;

@end

NS_ASSUME_NONNULL_END

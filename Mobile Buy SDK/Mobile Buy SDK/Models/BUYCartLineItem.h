//
//  BUYCartLineItem.h
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

#import <Buy/Buy.h>

/**
 *  BUYCartLineItem is a subclass of BUYLineItem that extends the object
 *  by exposing the BUYProductVariant that the line item was initialized with
 *  using `initWithVariant:`.
 *
 *  Note that this object is only used for a BUYCart and line item objects on
 *  BUYCheckout are represented by BUYLineItem objects that only contain the
 *  variant ID (if created from a BUYProductVariant).
 */
@interface BUYCartLineItem : BUYLineItem

/**
 *  The BUYProductVariant object associated with the line item
 *  when created using the preferred `initWithVariant:` initializer.
 */
@property (nonatomic, strong, readonly) BUYProductVariant *variant;

@end

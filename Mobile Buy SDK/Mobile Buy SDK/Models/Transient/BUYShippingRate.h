//
//  BUYShippingRate.h
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

#import "BUYObject.h"
#import "BUYSerializable.h"

/**
 *  BUYShippingRate represents the amount that the merchant is charging a customer for shipping to the specified address.
 */
@interface BUYShippingRate : BUYObject <BUYSerializable>

/**
 *  A reference to the shipping method.
 */
@property (nonatomic, strong, readonly) NSString *shippingRateIdentifier;

/**
 *  The shipping method name.
 */
@property (nonatomic, strong, readonly) NSString *title;

/**
 *  The price of this shipping method.
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *price;

/**
 *  One or two NSDate objects of the potential delivery dates.
 */
@property (nonatomic, strong, readonly) NSArray *deliveryRange;

@end

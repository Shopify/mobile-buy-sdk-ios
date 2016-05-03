//
//  BUYDiscount.h
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
 *   BUYDiscount represents a discount that is applied to the BUYCheckout.
 */
@interface BUYDiscount : BUYObject <BUYSerializable>

/**
 *  The unique identifier for the discount code.
 */
@property (nonatomic, copy) NSString *code;

/**
 *  The amount that is deducted from `paymentDue` on BUYCheckout.
 */
@property (nonatomic, strong) NSDecimalNumber *amount;

/**
 *  Whether this discount code can be applied to the checkout.
 */
@property (nonatomic, assign) BOOL applicable;

/**
 *  Created a BUYDiscount with a code
 *
 *  @param code The discount code
 *
 *  @return BUYDiscount object
 */
- (instancetype)initWithCode:(NSString *)code;

@end

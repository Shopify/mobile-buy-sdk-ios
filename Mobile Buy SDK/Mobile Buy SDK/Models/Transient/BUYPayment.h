//
//  BUYPayment.h
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

@class BUYCheckout;

@interface BUYPayment : BUYObject

/**
 *  The total amount reported in the `BUYCheckout` object
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *amount;

/**
 *  TODO:
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *amountIn;

/**
 *  TODO:
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *amountOut;

/**
 *  TODO:
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *amountRounding;

/**
 *  TODO:
 */
@property (nonatomic, strong, readonly) NSString *authorization;

/**
 * Creation date of the payment
 */
@property (nonatomic, strong, readonly) NSDate *createdAt;

/**
 * Three-letter currency code used for this payment
 */
@property (nonatomic, strong, readonly) NSString *currency;

/**
 * The error code, if one occured, for this payment
 */
@property (nonatomic, strong, readonly) NSNumber *errorCode;

/**
 *  TODO:
 */
@property (nonatomic, strong, readonly) NSString *gateway;

/**
 *  TODO:
 */
@property (nonatomic, strong, readonly) NSString *kind;

/**
 * A short message describing the status of the operation
 */
@property (nonatomic, strong, readonly) NSString *message;

/**
 * A status for the operation
 */
@property (nonatomic, strong, readonly) NSString *status;

/**
 * Checkout objects tied to this payment
 */
@property (nonatomic, strong, readonly) BUYCheckout *checkout;

/**
 *  TODO:
 */
@property (nonatomic, assign, readonly) BOOL isTest;

@end

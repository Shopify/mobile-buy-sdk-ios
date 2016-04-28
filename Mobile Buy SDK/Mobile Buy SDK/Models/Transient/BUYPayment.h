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
 *  The amount charged or that will be charged to the customer.
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *amount;

/**
 * The authorization number returned by the payment provider
 */
@property (nonatomic, strong, readonly) NSString *authorization;

/**
 * The date and time when the checkout was created. The API returns this value in ISO 8601 format.
 */
@property (nonatomic, strong, readonly) NSDate *createdAt;

/**
 * The currency used to complete the transaction.
 */
@property (nonatomic, strong, readonly) NSString *currency;

/**
 * The error code returned by the payment provider.
 */
@property (nonatomic, strong, readonly) NSNumber *errorCode;

/**
 * The gateway used by shopify to complete the transaction.
 */
@property (nonatomic, strong, readonly) NSString *gateway;

/**
 * The kind of authorization. Can be either an authorization or a sale.
 */
@property (nonatomic, strong, readonly) NSString *kind;

/**
 * An informative message returned by the payment provider.
 */
@property (nonatomic, strong, readonly) NSString *message;

/**
 * The status of the transaction. Can be either a 'success' or a 'failure'.
 */
@property (nonatomic, strong, readonly) NSString *status;

/**
 * Checkout objects tied to this payment
 */
@property (nonatomic, strong, readonly) BUYCheckout *checkout;

/**
 * Indicates if the transaction was a test or not.
 */
@property (nonatomic, assign, readonly) BOOL isTest;

@end

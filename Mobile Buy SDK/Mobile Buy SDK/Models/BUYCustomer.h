//
//  BUYCustomer.h
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

@interface BUYCustomer : BUYObject

/**
 * Indicates whether the customer should be charged taxes when placing orders. Valid values are `true` and `false`
 */
@property (nonatomic, assign) BOOL taxExempt;

/**
 * States whether or not the email address has been verified.
 */
@property (nonatomic, assign) BOOL verifiedEmail;

/**
 * Indicates whether the customer has consented to be sent marketing material via email. Valid values are `true` and `false`
 */
@property (nonatomic, assign) BOOL acceptsMarketing;

/**
 * The state of the customer in a shop. Customers start out as `disabled`. They are invited by email to setup an account with a shop. The customer can then:
 *
 * - `decline`: decline the invite to start an account that saves their customer settings.
 * - `invited`: accept the invite to start an account that saves their customer settings. Customers then change from `disabled` to `enabled`.
 *
 * Shop owners also have the ability to disable a customer. This will cancel a customer's membership with a shop.
 */
@property (nonatomic, assign) BOOL customerState;

/**
 * The email address of the customer.
 */
@property (nonatomic, strong) NSString *email;

/**
 * The customer's first name.
 */
@property (nonatomic, strong) NSString *firstName;

/**
 * The customer's last name.
 */
@property (nonatomic, strong) NSString *lastName;

/**
 * The customer's combined first and last name.
 */
@property (nonatomic, strong, readonly) NSString *fullName;

/**
 * The id of the customer's last order.
 */
@property (nonatomic, strong) NSNumber *lastOrderID;

/**
 * The name of the customer's last order. This is directly related to the Order's name field.
 */
@property (nonatomic, strong) NSString *lastOrderName;

/**
 * The customer's identifier used with Multipass login
 */
@property (nonatomic, strong) NSString *multipassIdentifier;

/**
 * A note about the customer.
 */
@property (nonatomic, strong) NSString *note;

/**
 * Tags are additional short descriptors formatted as a string of comma-separated values. For example, if a customer has three tags: `tag1, tag2, tag3`
 */
@property (nonatomic, strong) NSString *tags;

/**
 * The number of orders associated with this customer.
 */
@property (nonatomic, strong) NSNumber *ordersCount;

/**
 * The total amount of money that the customer has spent at the shop.
 */
@property (nonatomic, strong) NSDecimalNumber *totalSpent;

/**
 * The date and time when the customer was created. The API returns this value in ISO 8601 format.
 */
@property (nonatomic, strong) NSDate *createdAt;

/**
 * The date and time when the customer information was updated. The API returns this value in ISO 8601 format.
 */
@property (nonatomic, strong) NSDate *updatedAt;

@end

//
//  BUYCustomer.h
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-04-28.
//  Copyright © 2016 Shopify Inc. All rights reserved.
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

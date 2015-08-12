//
//  BUYShippingRate.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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

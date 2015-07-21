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

@property (nonatomic, strong, readonly) NSString *shippingRateIdentifier;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSDecimalNumber *price;
@property (nonatomic, strong, readonly) NSArray *deliveryRange;

@end

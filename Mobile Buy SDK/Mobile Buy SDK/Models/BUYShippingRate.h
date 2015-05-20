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

@property (nonatomic, strong) NSString *shippingRateIdentifier;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, copy) NSString *title;

@end

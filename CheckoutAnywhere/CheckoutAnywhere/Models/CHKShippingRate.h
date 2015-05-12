//
//  CHKShippingRate.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"
#import "CHKSerializable.h"

/**
 *  CHKShippingRate represents the amount that the merchant is charging a customer for shipping to the specified address.
 */
@interface CHKShippingRate : CHKObject <CHKSerializable>

@property (nonatomic, strong) NSString *shippingRateIdentifier;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, copy) NSString *title;

@end

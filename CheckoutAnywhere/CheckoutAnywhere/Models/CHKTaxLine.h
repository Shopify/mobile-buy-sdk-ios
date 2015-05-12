//
//  CHKTaxLine.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"
#import "CHKSerializable.h"

/**
 *  CHKTaxLine represents a single tax line on a checkout. Use this to display an itemized list of taxes that a customer is being charged for.
 */
@interface CHKTaxLine : CHKObject

@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *rate;
@property (nonatomic, copy) NSString *title;

@end

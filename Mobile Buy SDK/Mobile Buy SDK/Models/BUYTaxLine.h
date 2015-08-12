//
//  BUYTaxLine.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"
#import "BUYSerializable.h"

/**
 *  BUYTaxLine represents a single tax line on a checkout. Use this to display an itemized list of taxes that a customer is being charged for.
 */
@interface BUYTaxLine : BUYObject

/**
 *  The amount of tax to be charged.
 */
@property (nonatomic, strong) NSDecimalNumber *price;

/**
 *  The rate of tax to be applied.
 */
@property (nonatomic, strong) NSDecimalNumber *rate;

/**
 *  The name of the tax.
 */
@property (nonatomic, copy) NSString *title;

@end

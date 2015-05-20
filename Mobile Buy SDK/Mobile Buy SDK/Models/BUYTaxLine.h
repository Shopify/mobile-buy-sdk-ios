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

@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *rate;
@property (nonatomic, copy) NSString *title;

@end

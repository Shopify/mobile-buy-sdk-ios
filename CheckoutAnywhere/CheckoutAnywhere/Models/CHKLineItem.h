//
//  CHKLineItem.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKSerializable.h"
#import "CHKObject.h"

@class CHKProductVariant;

/**
 * This represents a line item on a Cart or on a Checkout.
 */
@interface CHKLineItem : CHKObject <CHKSerializable>

/**
 * Optional product variant.
 */
@property (nonatomic, strong) CHKProductVariant *variant;

/**
 * The quantity of the line item.
 */
@property (nonatomic, strong) NSDecimalNumber *quantity;

/**
 * The price of the line item. This price does not need to match the product variant.
 */
@property (nonatomic, strong) NSDecimalNumber *price;

/**
 * The title of the line item. The title does not need to match the product variant.
 */
@property (nonatomic, copy) NSString *title;

/**
 * YES if this line item requires shipping. This needs to match the product variant.
 */
@property (nonatomic, strong) NSNumber *requiresShipping;

- (instancetype)initWithVariant:(CHKProductVariant *)variant;

@end

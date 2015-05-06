//
//  CHKOption.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"

/**
 *  This represent a CHKOption on a CHKProduct
 */
@interface CHKOption : CHKObject

/**
 *  Custom product property names like "Size", "Color", and "Material".
 *  255 characters limit each.
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 *  The order in which the option should optionally appear
 */
@property (nonatomic, readonly, strong) NSNumber *position;

@end

//
//  BUYOption.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"

/**
 *  This represent a BUYOption on a BUYProduct
 */
@interface BUYOption : BUYObject

/**
 *  Custom product property names like "Size", "Color", and "Material".
 *  255 characters limit each.
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 *  The order in which the option should optionally appear
 */
@property (nonatomic, readonly, strong) NSNumber *position;

/**
 *  The associated product ID for this option
 */
@property (nonatomic, readonly, copy) NSNumber *productId;

@end

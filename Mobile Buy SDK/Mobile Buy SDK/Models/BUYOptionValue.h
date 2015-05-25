//
//  BUYOptionValue.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"

@interface BUYOptionValue : BUYObject

/**
 *  Custom product property names like "Size", "Color", and "Material".
 *  255 characters limit each.
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 *  The value of the option
 */
@property (nonatomic, readonly, strong) NSString *value;

/**
 *  the option identifier
 */
@property (nonatomic, readonly, strong) NSNumber *optionId;

@end

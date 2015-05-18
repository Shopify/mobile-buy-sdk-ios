//
//  BUYImage.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"

/**
 *  Products are easier to sell if customers can see pictures of them, which is why there are product images.
 */
@interface BUYImage : BUYObject

/**
 *  Specifies the location of the product image.
 */
@property (nonatomic, readonly, copy) NSString *src;

/**
 *  An array of variant ids associated with the image.
 */
@property (nonatomic, readonly, copy) NSArray *variantIds;

@end

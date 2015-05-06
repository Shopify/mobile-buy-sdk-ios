//
//  CHKImage.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"

@interface CHKImage : CHKObject

/**
 *  The location of a CHKImage
 */
@property (nonatomic, readonly, copy) NSString *src;

/**
 *  CHKProductVarient's identifier associated with the CHKImage
 */
@property (nonatomic, readonly, copy) NSArray *variantIds;

@end

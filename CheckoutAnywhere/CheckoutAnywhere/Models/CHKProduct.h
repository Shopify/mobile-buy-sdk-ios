//
//  CHKProduct.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"

@class CHKProductVariant;
@class CHKImage;
@class CHKOption;

@interface CHKProduct : CHKObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *vendor;
@property (nonatomic, readonly, copy) NSString *productType;
@property (nonatomic, readonly, copy) NSArray *variants;
@property (nonatomic, readonly, copy) NSArray *images;
@property (nonatomic, readonly, copy) NSArray *options;
@property (nonatomic, readonly, copy) NSString *htmlDescription;

@end

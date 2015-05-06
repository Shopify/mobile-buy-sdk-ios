//
//  CHKProductVariant.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"

@class CHKProduct;

@interface CHKProductVariant : CHKObject

@property (nonatomic, strong) CHKProduct *product;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *option1;
@property (nonatomic, readonly, copy) NSString *option2;
@property (nonatomic, readonly, copy) NSString *option3;
@property (nonatomic, readonly, strong) NSDecimalNumber *price;
@property (nonatomic, readonly, strong) NSDecimalNumber *compareAtPrice;
@property (nonatomic, readonly, strong) NSDecimalNumber *grams;
@property (nonatomic, readonly, strong) NSNumber *requiresShipping;
@property (nonatomic, readonly, strong) NSNumber *taxable;
@property (nonatomic, readonly, strong) NSNumber *position;

@end

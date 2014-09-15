//
//  MERProductVariant.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "MERObject.h"

@class MERProduct;

@interface MERProductVariant : MERObject

@property (nonatomic, strong) MERProduct *product;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *option1;
@property (nonatomic, copy) NSString *option2;
@property (nonatomic, copy) NSString *option3;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *compareAtPrice;
@property (nonatomic, strong) NSDecimalNumber *grams;
@property (nonatomic, strong) NSNumber *requiresShipping;
@property (nonatomic, strong) NSNumber *taxable;
@property (nonatomic, strong) NSNumber *position;

@end

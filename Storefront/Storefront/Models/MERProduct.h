//
//  MERProduct.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

//Base
#import "MERObject.h"

@class MERProductVariant;
@class MERImage;
@class MEROption;

@interface MERProduct : MERObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *vendor;
@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSArray *variants;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *options;
@property (nonatomic, copy) NSString *htmlDescription;

@end

//
//  MERProduct.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

//Base
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

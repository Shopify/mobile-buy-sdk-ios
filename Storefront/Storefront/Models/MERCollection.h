//
//  MERCollection.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "MERObject.h"

@class MERImage;

@interface MERCollection : MERObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *handle;
@property (nonatomic, strong) MERImage *image;
@property (nonatomic, assign) NSNumber *productsCount;
@property (nonatomic, assign) BOOL featured;

@end

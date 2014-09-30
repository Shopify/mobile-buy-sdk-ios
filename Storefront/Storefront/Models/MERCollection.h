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

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *handle;
@property (nonatomic, readonly, strong) MERImage *image;
@property (nonatomic, readonly, assign) NSNumber *productsCount;
@property (nonatomic, readonly, assign) BOOL featured;

@end

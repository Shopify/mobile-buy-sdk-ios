//
//  MERCollection.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKObject.h"

@class CHKImage;

@interface CHKCollection : CHKObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *handle;
@property (nonatomic, readonly, strong) CHKImage *image;
@property (nonatomic, readonly, assign) NSNumber *productsCount;
@property (nonatomic, readonly, assign) BOOL featured;

@end

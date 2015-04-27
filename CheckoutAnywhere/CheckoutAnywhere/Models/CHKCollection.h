//
//  CHKCollection.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKObject.h"

@class CHKImage;

@interface CHKCollection : CHKObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *handle;
@property (nonatomic, readonly, strong) CHKImage *image;
@property (nonatomic, readonly, strong) NSNumber *productsCount;
@property (nonatomic, readonly, assign) BOOL featured;

@end

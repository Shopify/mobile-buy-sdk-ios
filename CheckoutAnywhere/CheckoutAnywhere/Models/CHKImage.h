//
//  CHKImage.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKObject.h"

@interface CHKImage : CHKObject

@property (nonatomic, readonly, copy) NSString *src;
@property (nonatomic, readonly, copy) NSArray *variantIds;

@end

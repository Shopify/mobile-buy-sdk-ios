//
//  CHKImage.h
//  Checkout
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKObject.h"

@interface CHKImage : CHKObject

@property (nonatomic, readonly, copy) NSString *src;
@property (nonatomic, readonly, copy) NSArray *variantIds;

@end

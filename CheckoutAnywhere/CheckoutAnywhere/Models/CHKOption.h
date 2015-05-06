//
//  CHKOption.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"

@interface CHKOption : CHKObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, strong) NSNumber *position;

@end

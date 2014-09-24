//
//  MERImage.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "MERObject.h"

@interface MERImage : MERObject

@property (nonatomic, readonly, copy) NSString *src;
@property (nonatomic, readonly, copy) NSArray *variantIds;

@end

//
//  CHKOption.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKObject.h"

@interface CHKOption : CHKObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, strong) NSNumber *position;

@end

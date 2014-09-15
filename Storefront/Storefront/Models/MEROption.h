//
//  MEROption.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "MERObject.h"

@interface MEROption : MERObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *position;

@end

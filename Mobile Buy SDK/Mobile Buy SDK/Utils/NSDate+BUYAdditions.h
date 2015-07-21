//
//  NSDate+BUYAdditions.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-21.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BUYAdditions)

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

@end

//
//  BUYDateFormatter.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-21.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (BUYAdditions)

+ (NSDateFormatter*)dateFormatterForShippingRates;
+ (NSDateFormatter*)dateFormatterForPublications;

@end

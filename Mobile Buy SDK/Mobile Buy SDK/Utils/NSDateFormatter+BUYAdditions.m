//
//  BUYDateFormatter.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-21.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "NSDateFormatter+BUYAdditions.h"

@implementation NSDateFormatter (BUYAdditions)

+ (NSDateFormatter*)dateFormatterForShippingRates
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
	return dateFormatter;
}

+ (NSDateFormatter*)dateFormatterForPublications
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
	return dateFormatter;
}

@end

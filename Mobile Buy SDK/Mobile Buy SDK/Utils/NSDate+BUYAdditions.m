//
//  NSDate+BUYAdditions.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-21.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "NSDate+BUYAdditions.h"

@implementation NSDate (BUYAdditions)

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
	NSDate *fromDate;
	NSDate *toDate;
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	[calendar rangeOfUnit:NSCalendarUnitDay
				startDate:&fromDate
				 interval:NULL
				  forDate:fromDateTime];
	[calendar rangeOfUnit:NSCalendarUnitDay
				startDate:&toDate
				 interval:NULL
				  forDate:toDateTime];
	
	NSDateComponents *difference = [calendar components:NSCalendarUnitDay
											   fromDate:fromDate
												 toDate:toDate
												options:0];
	
	return [difference day];
}

@end

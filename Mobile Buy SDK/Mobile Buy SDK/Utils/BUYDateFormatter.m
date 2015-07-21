//
//  BUYDateFormatter.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-21.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYDateFormatter.h"

@implementation BUYDateFormatter

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
	}
	return self;
}

@end

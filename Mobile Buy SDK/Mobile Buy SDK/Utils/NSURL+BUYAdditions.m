//
//  NSURL+BUYAdditions.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-08-04.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "NSURL+BUYAdditions.h"

@implementation NSURL (BUYAdditions)

+ (NSURL *)buy_urlWithString:(NSString *)string
{
	NSURL *url = nil;
	
	if ([string isKindOfClass:[NSString class]]) {
		url = [NSURL URLWithString:string];
	}
	
	return url;
}


@end

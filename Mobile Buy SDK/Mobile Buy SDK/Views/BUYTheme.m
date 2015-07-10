//
//  BUYTheme.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYTheme.h"

@implementation BUYTheme

- (instancetype)init
{
	self = [super init];
	
	if (self) {
		_tintColor = [UIColor colorWithRed:0.48 green:0.71 blue:0.36 alpha:1];
		_style = BUYThemeStyleLight;
	}
	
	return self;
}

@end

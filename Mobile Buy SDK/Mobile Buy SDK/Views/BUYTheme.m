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
		_tintColor = [UIColor blackColor];
		_style = BUYThemeStyle_Light;
	}
	
	return self;
}

@end

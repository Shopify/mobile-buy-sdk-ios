//
//  BUYProductVariant+Options.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-22.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductVariant+Options.h"

@implementation BUYProductVariant (Options)

- (BUYOptionValue *)optionValueForName:(NSString *)optionName
{
	for (BUYOptionValue *value in self.options) {
		if ([value.name isEqualToString:optionName]) {
			return value;
		}
	}
	
	return nil;
}

@end

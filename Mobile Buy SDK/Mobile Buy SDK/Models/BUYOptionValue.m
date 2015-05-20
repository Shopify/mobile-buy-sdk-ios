//
//  BUYOptionValue.m
//  CheckoutAnywhere
//
//  Created by David Muzi on 2015-05-19.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYOptionValue.h"

@implementation BUYOptionValue

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_name = [dictionary[@"name"] copy];
	_value = [dictionary[@"value"] copy];
	_optionId = [dictionary[@"option_id"] copy];
}

@end

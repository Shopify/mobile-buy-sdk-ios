//
//  BUYOption.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYOption.h"

@implementation BUYOption

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_name = [dictionary[@"name"] copy];
	_position = dictionary[@"position"];
	_productId = [dictionary[@"product_id"] copy];
}

@end

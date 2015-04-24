//
//  CHKOption.m
//  Checkout
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKOption.h"

@implementation CHKOption

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_name = [dictionary[@"name"] copy];
	_position = dictionary[@"position"];
}

@end

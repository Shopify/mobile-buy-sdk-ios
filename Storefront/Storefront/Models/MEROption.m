//
//  MEROption.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MEROption.h"

@implementation MEROption

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	self.name = dictionary[@"name"];
	self.position = dictionary[@"position"];
}

@end

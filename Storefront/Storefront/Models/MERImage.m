//
//  MERImage.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERImage.h"

@implementation MERImage

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	self.src = dictionary[@"src"];
	self.variantIds = dictionary[@"variant_ids"];
}

@end

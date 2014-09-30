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
	
	_src = [dictionary[@"src"] copy];
	_variantIds = [dictionary[@"variant_ids"] copy];
}

@end

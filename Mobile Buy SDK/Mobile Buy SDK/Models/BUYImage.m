//
//  BUYImage.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYImage.h"

@implementation BUYImage

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_src = [dictionary[@"src"] copy];
	_variantIds = [dictionary[@"variant_ids"] copy];
}

@end

//
//  BUYImage.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYImage.h"
#import "NSDateFormatter+BUYAdditions.h"

@implementation BUYImage

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_src = [dictionary[@"src"] copy];
	_variantIds = [dictionary[@"variant_ids"] copy];
	_productId = [dictionary[@"product_id"] copy];
	_position = [dictionary[@"position"] copy];
	
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	_creationDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	_lastUpdatedDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
}

@end

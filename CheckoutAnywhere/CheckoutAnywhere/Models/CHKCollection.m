//
//  MERCollection.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKCollection.h"

//Models
#import "CHKImage.h"

@implementation CHKCollection

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	_handle = [dictionary[@"handle"] copy];
	_image = [CHKImage convertObject:dictionary[@"image"]];
	_productsCount = dictionary[@"products_count"];
	_featured = [dictionary[@"featured"] boolValue];
}

- (NSComparisonResult)compare:(CHKCollection*)otherCollection
{
	NSComparisonResult result = NSOrderedDescending;
	if (self.featured == otherCollection.featured) {
		result = [self.title compare:otherCollection.title];
	}
	else if (self.featured) {
		result = NSOrderedAscending;
	}
	return result;
}

@end

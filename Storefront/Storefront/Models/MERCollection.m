//
//  MERCollection.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERCollection.h"

//Models
#import "MERImage.h"

@implementation MERCollection

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super initWithDictionary:dictionary];
	if (self) {
		self.title = dictionary[@"title"];
		self.handle = dictionary[@"handle"];
		self.image = [MERImage convertObject:dictionary[@"image"]];
		self.productsCount = dictionary[@"products_count"];
	}
	return self;
}

- (NSComparisonResult)compare:(MERCollection*)otherCollection
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

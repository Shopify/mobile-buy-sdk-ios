//
//  MERProduct.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERProduct.h"

//Models
#import "MERImage.h"
#import "MEROption.h"
#import "MERProductVariant.h"

@implementation MERProduct

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super initWithDictionary:dictionary];
	if (self) {
		self.title = dictionary[@"title"];
		self.vendor = dictionary[@"vendor"];
		self.productType = dictionary[@"product_type"];

		self.variants = [MERProductVariant convertJSONArray:dictionary[@"variants"] block:^(MERProductVariant *variant) {
			variant.product = self;
		}];
		self.images = [MERImage convertJSONArray:dictionary[@"images"]];
		self.options = [MEROption convertJSONArray:dictionary[@"options"]];
		self.htmlDescription = dictionary[@"body_html"];
	}
	return self;
}

@end

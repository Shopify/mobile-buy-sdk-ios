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

		self.variants = [MERObject convertJSONArray:dictionary[@"variants"] toArrayOfClass:[MERProductVariant class] block:^(MERProductVariant *variant) {
			variant.product = self;
		}];
		self.images = [MERObject convertJSONArray:dictionary[@"images"] toArrayOfClass:[MERImage class]];
		self.options = [MERObject convertJSONArray:dictionary[@"options"] toArrayOfClass:[MEROption class]];
		self.htmlDescription = dictionary[@"body_html"];
	}
	return self;
}

@end

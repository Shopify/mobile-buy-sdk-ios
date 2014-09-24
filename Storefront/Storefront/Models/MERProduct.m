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

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	_vendor = [dictionary[@"vendor"] copy];
	_productType = [dictionary[@"product_type"] copy];
	_variants = [MERProductVariant convertJSONArray:dictionary[@"variants"] block:^(MERProductVariant *variant) {
		variant.product = self;
	}];
	_images = [MERImage convertJSONArray:dictionary[@"images"]];
	_options = [MEROption convertJSONArray:dictionary[@"options"]];
	_htmlDescription = dictionary[@"body_html"];
}

@end

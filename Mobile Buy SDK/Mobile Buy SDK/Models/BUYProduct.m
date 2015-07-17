//
//  BUYProduct.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYImage.h"
#import "BUYOption.h"
#import "BUYProduct.h"
#import "BUYProductVariant.h"

@implementation BUYProduct

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	_productId = [dictionary[@"product_id"] copy];
	_vendor = [dictionary[@"vendor"] copy];
	_productType = [dictionary[@"product_type"] copy];
	_variants = [BUYProductVariant convertJSONArray:dictionary[@"variants"] block:^(BUYProductVariant *variant) {
		variant.product = self;
	}];
	_images = [BUYImage convertJSONArray:dictionary[@"images"]];
	_options = [BUYOption convertJSONArray:dictionary[@"options"]];
	_htmlDescription = dictionary[@"body_html"];
	_available = [dictionary[@"available"] boolValue];
}

@end

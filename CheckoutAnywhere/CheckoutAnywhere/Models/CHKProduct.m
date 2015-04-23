//
//  CHKProduct.m
//  Checkout
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKProduct.h"

//Models
#import "CHKImage.h"
#import "CHKOption.h"
#import "CHKProductVariant.h"

@implementation CHKProduct

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	_vendor = [dictionary[@"vendor"] copy];
	_productType = [dictionary[@"product_type"] copy];
	_variants = [CHKProductVariant convertJSONArray:dictionary[@"variants"] block:^(CHKProductVariant *variant) {
		variant.product = self;
	}];
	_images = [CHKImage convertJSONArray:dictionary[@"images"]];
	_options = [CHKOption convertJSONArray:dictionary[@"options"]];
	_htmlDescription = dictionary[@"body_html"];
}

@end

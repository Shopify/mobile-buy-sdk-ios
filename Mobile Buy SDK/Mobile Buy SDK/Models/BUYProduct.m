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
#import "NSDateFormatter+BUYAdditions.h"

@implementation BUYProduct

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	_handle = [dictionary[@"handle"] copy];
	_productId = [dictionary[@"product_id"] copy];
	_vendor = [dictionary[@"vendor"] copy];
	_productType = [dictionary[@"product_type"] copy];
	_variants = [BUYProductVariant convertJSONArray:dictionary[@"variants"] block:^(BUYProductVariant *variant) {
		variant.product = self;
	}];
	_images = [BUYImage convertJSONArray:dictionary[@"images"]];
	_options = [BUYOption convertJSONArray:dictionary[@"options"]];
	_htmlDescription = [dictionary[@"body_html"] isKindOfClass:[NSNull class]] ? nil : dictionary[@"body_html"];
	_available = [dictionary[@"available"] boolValue];
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	_createdAtDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	_updatedAtDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
	_publishedAtDate = [dateFormatter dateFromString:dictionary[@"published_at"]];
}

@end

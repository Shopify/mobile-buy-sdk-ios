//
//  BUYProduct.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "BUYImage.h"
#import "BUYOption.h"
#import "BUYProduct.h"
#import "BUYProductVariant.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSDictionary+Additions.h"

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
	_htmlDescription = [dictionary buy_objectForKey:@"body_html"];
	_available = [dictionary[@"available"] boolValue];
	_published = [dictionary[@"published"] boolValue];
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	_createdAtDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	_updatedAtDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
	_publishedAtDate = [dateFormatter dateFromString:dictionary[@"published_at"]];
	NSArray *tagsArray = [dictionary[@"tags"] componentsSeparatedByString:@", "];
	NSSet *tagsSet = [NSSet setWithArray:tagsArray];
	_tags = [tagsSet copy];
}

@end

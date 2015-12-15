//
//  BUYImage.m
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
	_createdAtDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	_updatedAtDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
}

#pragma mark - BUYPersistence

- (NSDictionary *)plistDictionary
{
	NSMutableDictionary *dictionary = [[super plistDictionary] mutableCopy];
	
	if (self.src)           dictionary[@"src"] = self.src;
	if (self.variantIds)    dictionary[@"variant_ids"] = self.variantIds;
	if (self.productId)     dictionary[@"product_id"] = self.productId;
	if (self.position)      dictionary[@"position"] = self.position;
	
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	if (self.createdAtDate) dictionary[@"created_at"] = [dateFormatter stringFromDate:self.createdAtDate];
	if (self.updatedAtDate) dictionary[@"updated_at"] = [dateFormatter stringFromDate:self.updatedAtDate];
	
	return dictionary;
}

@end

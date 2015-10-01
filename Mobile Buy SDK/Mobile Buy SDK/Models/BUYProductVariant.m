//
//  BUYProductVariant.m
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

#import "BUYProductVariant.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "BUYOptionValue.h"

@implementation BUYProductVariant

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	
	_options = [BUYOptionValue convertJSONArray:dictionary[@"option_values"]];
	
	_price = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"price"]];
	_compareAtPrice = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"compare_at_price"]];
	_grams = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"grams"]];
	
	_requiresShipping = dictionary[@"requires_shipping"];
	_sku = dictionary[@"sku"];
	_taxable = dictionary[@"taxable"];
	_position = dictionary[@"position"];
	
	_available = [dictionary[@"available"] boolValue];
}

@end

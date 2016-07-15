//
//  _BUYCollection.m
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

#import "BUYCollection.h"
#import "BUYImageLink.h"
#import "NSString+BUYAdditions.h"

@implementation BUYCollection

@synthesize stringDescription = _stringDescription;

- (NSArray<BUYProduct *> *)productsArray
{
	return self.products.array ?: @[];
}

- (void)updateStringDescription
{
	// Force early cache of this value to prevent spooky behaviour
	_stringDescription = [[self.htmlDescription buy_stringByStrippingHTML] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)setJSONDictionary:(NSDictionary *)JSONDictionary
{
	[super setJSONDictionary:JSONDictionary];
	[self updateStringDescription];
}

+ (NSString *)sortOrderParameterForCollectionSort:(BUYCollectionSort)sort
{
	switch (sort) {
		case BUYCollectionSortBestSelling:
			return @"best-selling";
		case BUYCollectionSortCreatedAscending:
			return @"created-ascending";
		case BUYCollectionSortCreatedDescending:
			return @"created-descending";
		case BUYCollectionSortPriceAscending:
			return @"price-ascending";
		case BUYCollectionSortPriceDescending:
			return @"price-descending";
		case BUYCollectionSortTitleAscending:
			return @"title-ascending";
		case BUYCollectionSortTitleDescending:
			return @"title-descending";
		default:
			return @"collection-default";
	}
}

@end

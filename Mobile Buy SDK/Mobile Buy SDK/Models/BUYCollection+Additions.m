//
//  BUYCollection+Additions.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-29.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYCollection+Additions.h"

@implementation BUYCollection (Additions)

+(NSString *)sortOrderParameterForCollectionSort:(BUYCollectionSort)sort
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

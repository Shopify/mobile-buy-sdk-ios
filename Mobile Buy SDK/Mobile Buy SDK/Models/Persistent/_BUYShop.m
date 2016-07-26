//
//  _BUYShop.h
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
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BUYShop.m instead.

#import "_BUYShop.h"

const struct BUYShopAttributes BUYShopAttributes = {
	.city = @"city",
	.country = @"country",
	.currency = @"currency",
	.domain = @"domain",
	.identifier = @"identifier",
	.moneyFormat = @"moneyFormat",
	.myShopifyURL = @"myShopifyURL",
	.name = @"name",
	.province = @"province",
	.publishedCollectionsCount = @"publishedCollectionsCount",
	.publishedProductsCount = @"publishedProductsCount",
	.shipsToCountries = @"shipsToCountries",
	.shopDescription = @"shopDescription",
	.shopURL = @"shopURL",
};

const struct BUYShopUserInfo BUYShopUserInfo = {
	.documentation = @"The BUYShop object is a collection of the general settings and information about the shop.",
};

@implementation _BUYShop

+ (NSString *)entityName {
	return @"Shop";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"publishedCollectionsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"publishedCollectionsCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"publishedProductsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"publishedProductsCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic city;
@dynamic country;
@dynamic currency;
@dynamic domain;
@dynamic identifier;
@dynamic moneyFormat;
@dynamic myShopifyURL;
@dynamic name;
@dynamic province;
@dynamic publishedCollectionsCount;
@dynamic publishedProductsCount;
@dynamic shipsToCountries;
@dynamic shopDescription;
@dynamic shopURL;
#endif

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (int64_t)publishedCollectionsCountValue {
	NSNumber *result = [self publishedCollectionsCount];
	return [result longLongValue];
}

- (void)setPublishedCollectionsCountValue:(int64_t)value_ {
	[self setPublishedCollectionsCount:@(value_)];
}

- (int64_t)publishedProductsCountValue {
	NSNumber *result = [self publishedProductsCount];
	return [result longLongValue];
}

- (void)setPublishedProductsCountValue:(int64_t)value_ {
	[self setPublishedProductsCount:@(value_)];
}

@end

#pragma mark -

@implementation BUYModelManager (BUYShopInserting)

- (BUYShop *)insertShopWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYShop *)[self buy_objectWithEntityName:@"Shop" JSONDictionary:dictionary];
}

- (NSArray<BUYShop *> *)insertShopsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYShop *> *)[self buy_objectsWithEntityName:@"Shop" JSONArray:array];
}

- (NSArray<BUYShop *> *)allShopObjects
{
	return (NSArray<BUYShop *> *)[self buy_objectsWithEntityName:@"Shop" identifiers:nil];
}

- (BUYShop *)fetchShopWithIdentifierValue:(int64_t)identifier
{
    return (BUYShop *)[self buy_objectWithEntityName:@"Shop" identifier:@(identifier)];
}

@end

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
- (NSString*)city {
    [self willAccessValueForKey:@"city"];
    id value = [self primitiveValueForKey:@"city"];
    [self didAccessValueForKey:@"city"];
    return value;
}

- (void)setCity:(NSString*)value_ {
    [self willChangeValueForKey:@"city"];
    [self setPrimitiveValue:value_ forKey:@"city"];
    [self didChangeValueForKey:@"city"];
}

- (NSString*)country {
    [self willAccessValueForKey:@"country"];
    id value = [self primitiveValueForKey:@"country"];
    [self didAccessValueForKey:@"country"];
    return value;
}

- (void)setCountry:(NSString*)value_ {
    [self willChangeValueForKey:@"country"];
    [self setPrimitiveValue:value_ forKey:@"country"];
    [self didChangeValueForKey:@"country"];
}

- (NSString*)currency {
    [self willAccessValueForKey:@"currency"];
    id value = [self primitiveValueForKey:@"currency"];
    [self didAccessValueForKey:@"currency"];
    return value;
}

- (void)setCurrency:(NSString*)value_ {
    [self willChangeValueForKey:@"currency"];
    [self setPrimitiveValue:value_ forKey:@"currency"];
    [self didChangeValueForKey:@"currency"];
}

- (NSString*)domain {
    [self willAccessValueForKey:@"domain"];
    id value = [self primitiveValueForKey:@"domain"];
    [self didAccessValueForKey:@"domain"];
    return value;
}

- (void)setDomain:(NSString*)value_ {
    [self willChangeValueForKey:@"domain"];
    [self setPrimitiveValue:value_ forKey:@"domain"];
    [self didChangeValueForKey:@"domain"];
}

- (NSNumber*)identifier {
    [self willAccessValueForKey:@"identifier"];
    id value = [self primitiveValueForKey:@"identifier"];
    [self didAccessValueForKey:@"identifier"];
    return value;
}

- (void)setIdentifier:(NSNumber*)value_ {
    [self willChangeValueForKey:@"identifier"];
    [self setPrimitiveValue:value_ forKey:@"identifier"];
    [self didChangeValueForKey:@"identifier"];
}

- (NSString*)moneyFormat {
    [self willAccessValueForKey:@"moneyFormat"];
    id value = [self primitiveValueForKey:@"moneyFormat"];
    [self didAccessValueForKey:@"moneyFormat"];
    return value;
}

- (void)setMoneyFormat:(NSString*)value_ {
    [self willChangeValueForKey:@"moneyFormat"];
    [self setPrimitiveValue:value_ forKey:@"moneyFormat"];
    [self didChangeValueForKey:@"moneyFormat"];
}

- (NSURL*)myShopifyURL {
    [self willAccessValueForKey:@"myShopifyURL"];
    id value = [self primitiveValueForKey:@"myShopifyURL"];
    [self didAccessValueForKey:@"myShopifyURL"];
    return value;
}

- (void)setMyShopifyURL:(NSURL*)value_ {
    [self willChangeValueForKey:@"myShopifyURL"];
    [self setPrimitiveValue:value_ forKey:@"myShopifyURL"];
    [self didChangeValueForKey:@"myShopifyURL"];
}

- (NSString*)name {
    [self willAccessValueForKey:@"name"];
    id value = [self primitiveValueForKey:@"name"];
    [self didAccessValueForKey:@"name"];
    return value;
}

- (void)setName:(NSString*)value_ {
    [self willChangeValueForKey:@"name"];
    [self setPrimitiveValue:value_ forKey:@"name"];
    [self didChangeValueForKey:@"name"];
}

- (NSString*)province {
    [self willAccessValueForKey:@"province"];
    id value = [self primitiveValueForKey:@"province"];
    [self didAccessValueForKey:@"province"];
    return value;
}

- (void)setProvince:(NSString*)value_ {
    [self willChangeValueForKey:@"province"];
    [self setPrimitiveValue:value_ forKey:@"province"];
    [self didChangeValueForKey:@"province"];
}

- (NSNumber*)publishedCollectionsCount {
    [self willAccessValueForKey:@"publishedCollectionsCount"];
    id value = [self primitiveValueForKey:@"publishedCollectionsCount"];
    [self didAccessValueForKey:@"publishedCollectionsCount"];
    return value;
}

- (void)setPublishedCollectionsCount:(NSNumber*)value_ {
    [self willChangeValueForKey:@"publishedCollectionsCount"];
    [self setPrimitiveValue:value_ forKey:@"publishedCollectionsCount"];
    [self didChangeValueForKey:@"publishedCollectionsCount"];
}

- (NSNumber*)publishedProductsCount {
    [self willAccessValueForKey:@"publishedProductsCount"];
    id value = [self primitiveValueForKey:@"publishedProductsCount"];
    [self didAccessValueForKey:@"publishedProductsCount"];
    return value;
}

- (void)setPublishedProductsCount:(NSNumber*)value_ {
    [self willChangeValueForKey:@"publishedProductsCount"];
    [self setPrimitiveValue:value_ forKey:@"publishedProductsCount"];
    [self didChangeValueForKey:@"publishedProductsCount"];
}

- (NSArray*)shipsToCountries {
    [self willAccessValueForKey:@"shipsToCountries"];
    id value = [self primitiveValueForKey:@"shipsToCountries"];
    [self didAccessValueForKey:@"shipsToCountries"];
    return value;
}

- (void)setShipsToCountries:(NSArray*)value_ {
    [self willChangeValueForKey:@"shipsToCountries"];
    [self setPrimitiveValue:value_ forKey:@"shipsToCountries"];
    [self didChangeValueForKey:@"shipsToCountries"];
}

- (NSString*)shopDescription {
    [self willAccessValueForKey:@"shopDescription"];
    id value = [self primitiveValueForKey:@"shopDescription"];
    [self didAccessValueForKey:@"shopDescription"];
    return value;
}

- (void)setShopDescription:(NSString*)value_ {
    [self willChangeValueForKey:@"shopDescription"];
    [self setPrimitiveValue:value_ forKey:@"shopDescription"];
    [self didChangeValueForKey:@"shopDescription"];
}

- (NSURL*)shopURL {
    [self willAccessValueForKey:@"shopURL"];
    id value = [self primitiveValueForKey:@"shopURL"];
    [self didAccessValueForKey:@"shopURL"];
    return value;
}

- (void)setShopURL:(NSURL*)value_ {
    [self willChangeValueForKey:@"shopURL"];
    [self setPrimitiveValue:value_ forKey:@"shopURL"];
    [self didChangeValueForKey:@"shopURL"];
}

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

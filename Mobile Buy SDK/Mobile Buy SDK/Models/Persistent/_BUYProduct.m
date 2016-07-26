//
//  _BUYProduct.h
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
// Make changes to BUYProduct.m instead.

#import "_BUYProduct.h"

const struct BUYProductAttributes BUYProductAttributes = {
	.available = @"available",
	.createdAt = @"createdAt",
	.handle = @"handle",
	.htmlDescription = @"htmlDescription",
	.identifier = @"identifier",
	.productType = @"productType",
	.published = @"published",
	.publishedAt = @"publishedAt",
	.tags = @"tags",
	.title = @"title",
	.updatedAt = @"updatedAt",
	.vendor = @"vendor",
};

const struct BUYProductRelationships BUYProductRelationships = {
	.collections = @"collections",
	.images = @"images",
	.options = @"options",
	.variants = @"variants",
};

const struct BUYProductUserInfo BUYProductUserInfo = {
	.documentation = @"A BUYProduct is an individual item for sale in a Shopify shop.",
};

@implementation _BUYProduct

+ (NSString *)entityName {
	return @"Product";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"availableValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"available"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"publishedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"published"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic available;
@dynamic createdAt;
@dynamic handle;
@dynamic htmlDescription;
@dynamic identifier;
@dynamic productType;
@dynamic published;
@dynamic publishedAt;
@dynamic tags;
@dynamic title;
@dynamic updatedAt;
@dynamic vendor;
#endif

- (BOOL)availableValue {
	NSNumber *result = [self available];
	return [result boolValue];
}

- (void)setAvailableValue:(BOOL)value_ {
	[self setAvailable:@(value_)];
}

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (BOOL)publishedValue {
	NSNumber *result = [self published];
	return [result boolValue];
}

- (void)setPublishedValue:(BOOL)value_ {
	[self setPublished:@(value_)];
}

#if defined CORE_DATA_PERSISTENCE
@dynamic collections;
#endif

- (NSMutableSet *)collectionsSet {
	[self willAccessValueForKey:@"collections"];

	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"collections"];

	[self didAccessValueForKey:@"collections"];
	return result;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic images;
#endif

- (NSMutableOrderedSet *)imagesSet {
	[self willAccessValueForKey:@"images"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet *)[self mutableOrderedSetValueForKey:@"images"];

	[self didAccessValueForKey:@"images"];
	return result;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic options;
#endif

- (NSMutableOrderedSet *)optionsSet {
	[self willAccessValueForKey:@"options"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet *)[self mutableOrderedSetValueForKey:@"options"];

	[self didAccessValueForKey:@"options"];
	return result;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic variants;
#endif

- (NSMutableOrderedSet *)variantsSet {
	[self willAccessValueForKey:@"variants"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet *)[self mutableOrderedSetValueForKey:@"variants"];

	[self didAccessValueForKey:@"variants"];
	return result;
}

@end

#pragma mark -

@implementation BUYModelManager (BUYProductInserting)

- (BUYProduct *)insertProductWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYProduct *)[self buy_objectWithEntityName:@"Product" JSONDictionary:dictionary];
}

- (NSArray<BUYProduct *> *)insertProductsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYProduct *> *)[self buy_objectsWithEntityName:@"Product" JSONArray:array];
}

- (NSArray<BUYProduct *> *)allProductObjects
{
	return (NSArray<BUYProduct *> *)[self buy_objectsWithEntityName:@"Product" identifiers:nil];
}

- (BUYProduct *)fetchProductWithIdentifierValue:(int64_t)identifier
{
    return (BUYProduct *)[self buy_objectWithEntityName:@"Product" identifier:@(identifier)];
}

@end

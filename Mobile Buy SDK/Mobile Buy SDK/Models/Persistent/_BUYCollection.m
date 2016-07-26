//
//  _BUYCollection.h
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
// Make changes to BUYCollection.m instead.

#import "_BUYCollection.h"

const struct BUYCollectionAttributes BUYCollectionAttributes = {
	.createdAt = @"createdAt",
	.handle = @"handle",
	.htmlDescription = @"htmlDescription",
	.identifier = @"identifier",
	.published = @"published",
	.publishedAt = @"publishedAt",
	.title = @"title",
	.updatedAt = @"updatedAt",
};

const struct BUYCollectionRelationships BUYCollectionRelationships = {
	.image = @"image",
	.products = @"products",
};

const struct BUYCollectionUserInfo BUYCollectionUserInfo = {
	.documentation = @"Represents a collection of products on the shop.",
};

@implementation _BUYCollection

+ (NSString *)entityName {
	return @"Collection";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

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
@dynamic createdAt;
@dynamic handle;
@dynamic htmlDescription;
@dynamic identifier;
@dynamic published;
@dynamic publishedAt;
@dynamic title;
@dynamic updatedAt;
#endif

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
@dynamic image;
#endif

#if defined CORE_DATA_PERSISTENCE
@dynamic products;
#endif

- (NSMutableOrderedSet *)productsSet {
	[self willAccessValueForKey:@"products"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet *)[self mutableOrderedSetValueForKey:@"products"];

	[self didAccessValueForKey:@"products"];
	return result;
}

@end

#pragma mark -

@implementation BUYModelManager (BUYCollectionInserting)

- (BUYCollection *)insertCollectionWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYCollection *)[self buy_objectWithEntityName:@"Collection" JSONDictionary:dictionary];
}

- (NSArray<BUYCollection *> *)insertCollectionsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYCollection *> *)[self buy_objectsWithEntityName:@"Collection" JSONArray:array];
}

- (NSArray<BUYCollection *> *)allCollectionObjects
{
	return (NSArray<BUYCollection *> *)[self buy_objectsWithEntityName:@"Collection" identifiers:nil];
}

- (BUYCollection *)fetchCollectionWithIdentifierValue:(int64_t)identifier
{
    return (BUYCollection *)[self buy_objectWithEntityName:@"Collection" identifier:@(identifier)];
}

@end

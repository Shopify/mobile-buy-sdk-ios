//
//  _BUYImageLink.h
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
// Make changes to BUYImageLink.m instead.

#import "_BUYImageLink.h"

const struct BUYImageLinkAttributes BUYImageLinkAttributes = {
	.createdAt = @"createdAt",
	.identifier = @"identifier",
	.position = @"position",
	.sourceURL = @"sourceURL",
	.updatedAt = @"updatedAt",
	.variantIds = @"variantIds",
};

const struct BUYImageLinkRelationships BUYImageLinkRelationships = {
	.collection = @"collection",
	.product = @"product",
};

const struct BUYImageLinkUserInfo BUYImageLinkUserInfo = {
	.documentation = @"A link to an image representing a product or collection.",
};

@implementation _BUYImageLink

+ (NSString *)entityName {
	return @"ImageLink";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"positionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"position"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic createdAt;
@dynamic identifier;
@dynamic position;
@dynamic sourceURL;
@dynamic updatedAt;
@dynamic variantIds;
#endif

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (int32_t)positionValue {
	NSNumber *result = [self position];
	return [result intValue];
}

- (void)setPositionValue:(int32_t)value_ {
	[self setPosition:@(value_)];
}

#if defined CORE_DATA_PERSISTENCE
@dynamic collection;
#endif

#if defined CORE_DATA_PERSISTENCE
@dynamic product;
#endif

@end

#pragma mark -

@implementation BUYModelManager (BUYImageLinkInserting)

- (BUYImageLink *)insertImageLinkWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYImageLink *)[self buy_objectWithEntityName:@"ImageLink" JSONDictionary:dictionary];
}

- (NSArray<BUYImageLink *> *)insertImageLinksWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYImageLink *> *)[self buy_objectsWithEntityName:@"ImageLink" JSONArray:array];
}

- (NSArray<BUYImageLink *> *)allImageLinkObjects
{
	return (NSArray<BUYImageLink *> *)[self buy_objectsWithEntityName:@"ImageLink" identifiers:nil];
}

- (BUYImageLink *)fetchImageLinkWithIdentifierValue:(int64_t)identifier
{
    return (BUYImageLink *)[self buy_objectWithEntityName:@"ImageLink" identifier:@(identifier)];
}

@end

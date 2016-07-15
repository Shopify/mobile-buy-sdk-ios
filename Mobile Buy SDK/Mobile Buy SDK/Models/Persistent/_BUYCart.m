//
//  _BUYCart.h
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
// Make changes to BUYCart.m instead.

#import "_BUYCart.h"

const struct BUYCartRelationships BUYCartRelationships = {
	.lineItems = @"lineItems",
};

const struct BUYCartUserInfo BUYCartUserInfo = {
	.discussion = @"The BUYCart is the starting point for the Checkout API. You are responsible for building a cart, then transforming it into a BUYCheckout using the BUYDataClient. Private to app.",
	.documentation = @"A collection of products the user intends to purchase.",
	.private = @"YES",
};

@implementation _BUYCart

+ (NSString *)entityName {
	return @"Cart";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
#endif

#if defined CORE_DATA_PERSISTENCE
@dynamic lineItems;
#endif

- (NSMutableOrderedSet *)lineItemsSet {
	[self willAccessValueForKey:@"lineItems"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet *)[self mutableOrderedSetValueForKey:@"lineItems"];

	[self didAccessValueForKey:@"lineItems"];
	return result;
}

@end

#pragma mark -

@implementation BUYModelManager (BUYCartInserting)

- (BUYCart *)insertCartWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYCart *)[self buy_objectWithEntityName:@"Cart" JSONDictionary:dictionary];
}

- (NSArray<BUYCart *> *)insertCartsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYCart *> *)[self buy_objectsWithEntityName:@"Cart" JSONArray:array];
}

- (NSArray<BUYCart *> *)allCartObjects
{
	return (NSArray<BUYCart *> *)[self buy_objectsWithEntityName:@"Cart" identifiers:nil];
}

- (BUYCart *)fetchCartWithIdentifierValue:(int64_t)identifier
{
    return (BUYCart *)[self buy_objectWithEntityName:@"Cart" identifier:@(identifier)];
}

@end

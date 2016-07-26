//
//  _BUYCartLineItem.h
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
// Make changes to BUYCartLineItem.m instead.

#import "_BUYCartLineItem.h"

const struct BUYCartLineItemAttributes BUYCartLineItemAttributes = {
	.quantity = @"quantity",
};

const struct BUYCartLineItemRelationships BUYCartLineItemRelationships = {
	.cart = @"cart",
	.variant = @"variant",
};

const struct BUYCartLineItemUserInfo BUYCartLineItemUserInfo = {
	.documentation = @"A line item that references a product variant. Private to app.",
	.private = @"YES",
};

@implementation _BUYCartLineItem

+ (NSString *)entityName {
	return @"CartLineItem";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic quantity;
#endif

#if defined CORE_DATA_PERSISTENCE
@dynamic cart;
#endif

#if defined CORE_DATA_PERSISTENCE
@dynamic variant;
#endif

@end

#pragma mark -

@implementation BUYModelManager (BUYCartLineItemInserting)

- (BUYCartLineItem *)insertCartLineItemWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYCartLineItem *)[self buy_objectWithEntityName:@"CartLineItem" JSONDictionary:dictionary];
}

- (NSArray<BUYCartLineItem *> *)insertCartLineItemsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYCartLineItem *> *)[self buy_objectsWithEntityName:@"CartLineItem" JSONArray:array];
}

- (NSArray<BUYCartLineItem *> *)allCartLineItemObjects
{
	return (NSArray<BUYCartLineItem *> *)[self buy_objectsWithEntityName:@"CartLineItem" identifiers:nil];
}

- (BUYCartLineItem *)fetchCartLineItemWithIdentifierValue:(int64_t)identifier
{
    return (BUYCartLineItem *)[self buy_objectWithEntityName:@"CartLineItem" identifier:@(identifier)];
}

@end

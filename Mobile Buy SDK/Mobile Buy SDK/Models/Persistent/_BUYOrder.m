//
//  _BUYOrder.h
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
// Make changes to BUYOrder.m instead.

#import "_BUYOrder.h"

const struct BUYOrderAttributes BUYOrderAttributes = {
	.identifier = @"identifier",
	.name = @"name",
	.orderStatusURL = @"orderStatusURL",
	.processedAt = @"processedAt",
	.statusURL = @"statusURL",
	.subtotalPrice = @"subtotalPrice",
	.totalPrice = @"totalPrice",
};

const struct BUYOrderRelationships BUYOrderRelationships = {
	.checkout = @"checkout",
	.lineItems = @"lineItems",
};

const struct BUYOrderUserInfo BUYOrderUserInfo = {
	.attributeValueClassName = @"URL",
	.documentation = @"URL for the website showing the order status, doesn't require a customer token.",
};

@implementation _BUYOrder

+ (NSString *)entityName {
	return @"Order";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
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

- (NSURL*)orderStatusURL {
    [self willAccessValueForKey:@"orderStatusURL"];
    id value = [self primitiveValueForKey:@"orderStatusURL"];
    [self didAccessValueForKey:@"orderStatusURL"];
    return value;
}

- (void)setOrderStatusURL:(NSURL*)value_ {
    [self willChangeValueForKey:@"orderStatusURL"];
    [self setPrimitiveValue:value_ forKey:@"orderStatusURL"];
    [self didChangeValueForKey:@"orderStatusURL"];
}

- (NSDate*)processedAt {
    [self willAccessValueForKey:@"processedAt"];
    id value = [self primitiveValueForKey:@"processedAt"];
    [self didAccessValueForKey:@"processedAt"];
    return value;
}

- (void)setProcessedAt:(NSDate*)value_ {
    [self willChangeValueForKey:@"processedAt"];
    [self setPrimitiveValue:value_ forKey:@"processedAt"];
    [self didChangeValueForKey:@"processedAt"];
}

- (NSURL*)statusURL {
    [self willAccessValueForKey:@"statusURL"];
    id value = [self primitiveValueForKey:@"statusURL"];
    [self didAccessValueForKey:@"statusURL"];
    return value;
}

- (void)setStatusURL:(NSURL*)value_ {
    [self willChangeValueForKey:@"statusURL"];
    [self setPrimitiveValue:value_ forKey:@"statusURL"];
    [self didChangeValueForKey:@"statusURL"];
}

- (NSDecimalNumber*)subtotalPrice {
    [self willAccessValueForKey:@"subtotalPrice"];
    id value = [self primitiveValueForKey:@"subtotalPrice"];
    [self didAccessValueForKey:@"subtotalPrice"];
    return value;
}

- (void)setSubtotalPrice:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"subtotalPrice"];
    [self setPrimitiveValue:value_ forKey:@"subtotalPrice"];
    [self didChangeValueForKey:@"subtotalPrice"];
}

- (NSDecimalNumber*)totalPrice {
    [self willAccessValueForKey:@"totalPrice"];
    id value = [self primitiveValueForKey:@"totalPrice"];
    [self didAccessValueForKey:@"totalPrice"];
    return value;
}

- (void)setTotalPrice:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"totalPrice"];
    [self setPrimitiveValue:value_ forKey:@"totalPrice"];
    [self didChangeValueForKey:@"totalPrice"];
}

#endif

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

#if defined CORE_DATA_PERSISTENCE
@dynamic checkout;
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

@implementation BUYModelManager (BUYOrderInserting)

- (BUYOrder *)insertOrderWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYOrder *)[self buy_objectWithEntityName:@"Order" JSONDictionary:dictionary];
}

- (NSArray<BUYOrder *> *)insertOrdersWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYOrder *> *)[self buy_objectsWithEntityName:@"Order" JSONArray:array];
}

- (NSArray<BUYOrder *> *)allOrderObjects
{
	return (NSArray<BUYOrder *> *)[self buy_objectsWithEntityName:@"Order" identifiers:nil];
}

- (BUYOrder *)fetchOrderWithIdentifierValue:(int64_t)identifier
{
    return (BUYOrder *)[self buy_objectWithEntityName:@"Order" identifier:@(identifier)];
}

@end

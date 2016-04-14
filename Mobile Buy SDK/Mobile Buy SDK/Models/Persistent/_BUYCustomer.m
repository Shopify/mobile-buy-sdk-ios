//
//  _BUYCustomer.h
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
// Make changes to BUYCustomer.m instead.

#import "_BUYCustomer.h"

const struct BUYCustomerAttributes BUYCustomerAttributes = {
	.acceptsMarketing = @"acceptsMarketing",
	.createdAt = @"createdAt",
	.customerState = @"customerState",
	.email = @"email",
	.firstName = @"firstName",
	.identifier = @"identifier",
	.lastName = @"lastName",
	.lastOrderID = @"lastOrderID",
	.lastOrderName = @"lastOrderName",
	.multipassIdentifier = @"multipassIdentifier",
	.note = @"note",
	.ordersCount = @"ordersCount",
	.tags = @"tags",
	.taxExempt = @"taxExempt",
	.totalSpent = @"totalSpent",
	.updatedAt = @"updatedAt",
	.verifiedEmail = @"verifiedEmail",
};

@implementation _BUYCustomer

+ (NSString *)entityName {
	return @"Customer";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"acceptsMarketingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"acceptsMarketing"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"customerStateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"customerState"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"lastOrderIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lastOrderID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ordersCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ordersCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"taxExemptValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"taxExempt"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"verifiedEmailValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"verifiedEmail"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
- (NSNumber*)acceptsMarketing {
    [self willAccessValueForKey:@"acceptsMarketing"];
    id value = [self primitiveValueForKey:@"acceptsMarketing"];
    [self didAccessValueForKey:@"acceptsMarketing"];
    return value;
}

- (void)setAcceptsMarketing:(NSNumber*)value_ {
    [self willChangeValueForKey:@"acceptsMarketing"];
    [self setPrimitiveValue:value_ forKey:@"acceptsMarketing"];
    [self didChangeValueForKey:@"acceptsMarketing"];
}

- (NSDate*)createdAt {
    [self willAccessValueForKey:@"createdAt"];
    id value = [self primitiveValueForKey:@"createdAt"];
    [self didAccessValueForKey:@"createdAt"];
    return value;
}

- (void)setCreatedAt:(NSDate*)value_ {
    [self willChangeValueForKey:@"createdAt"];
    [self setPrimitiveValue:value_ forKey:@"createdAt"];
    [self didChangeValueForKey:@"createdAt"];
}

- (NSNumber*)customerState {
    [self willAccessValueForKey:@"customerState"];
    id value = [self primitiveValueForKey:@"customerState"];
    [self didAccessValueForKey:@"customerState"];
    return value;
}

- (void)setCustomerState:(NSNumber*)value_ {
    [self willChangeValueForKey:@"customerState"];
    [self setPrimitiveValue:value_ forKey:@"customerState"];
    [self didChangeValueForKey:@"customerState"];
}

- (NSString*)email {
    [self willAccessValueForKey:@"email"];
    id value = [self primitiveValueForKey:@"email"];
    [self didAccessValueForKey:@"email"];
    return value;
}

- (void)setEmail:(NSString*)value_ {
    [self willChangeValueForKey:@"email"];
    [self setPrimitiveValue:value_ forKey:@"email"];
    [self didChangeValueForKey:@"email"];
}

- (NSString*)firstName {
    [self willAccessValueForKey:@"firstName"];
    id value = [self primitiveValueForKey:@"firstName"];
    [self didAccessValueForKey:@"firstName"];
    return value;
}

- (void)setFirstName:(NSString*)value_ {
    [self willChangeValueForKey:@"firstName"];
    [self setPrimitiveValue:value_ forKey:@"firstName"];
    [self didChangeValueForKey:@"firstName"];
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

- (NSString*)lastName {
    [self willAccessValueForKey:@"lastName"];
    id value = [self primitiveValueForKey:@"lastName"];
    [self didAccessValueForKey:@"lastName"];
    return value;
}

- (void)setLastName:(NSString*)value_ {
    [self willChangeValueForKey:@"lastName"];
    [self setPrimitiveValue:value_ forKey:@"lastName"];
    [self didChangeValueForKey:@"lastName"];
}

- (NSNumber*)lastOrderID {
    [self willAccessValueForKey:@"lastOrderID"];
    id value = [self primitiveValueForKey:@"lastOrderID"];
    [self didAccessValueForKey:@"lastOrderID"];
    return value;
}

- (void)setLastOrderID:(NSNumber*)value_ {
    [self willChangeValueForKey:@"lastOrderID"];
    [self setPrimitiveValue:value_ forKey:@"lastOrderID"];
    [self didChangeValueForKey:@"lastOrderID"];
}

- (NSString*)lastOrderName {
    [self willAccessValueForKey:@"lastOrderName"];
    id value = [self primitiveValueForKey:@"lastOrderName"];
    [self didAccessValueForKey:@"lastOrderName"];
    return value;
}

- (void)setLastOrderName:(NSString*)value_ {
    [self willChangeValueForKey:@"lastOrderName"];
    [self setPrimitiveValue:value_ forKey:@"lastOrderName"];
    [self didChangeValueForKey:@"lastOrderName"];
}

- (NSString*)multipassIdentifier {
    [self willAccessValueForKey:@"multipassIdentifier"];
    id value = [self primitiveValueForKey:@"multipassIdentifier"];
    [self didAccessValueForKey:@"multipassIdentifier"];
    return value;
}

- (void)setMultipassIdentifier:(NSString*)value_ {
    [self willChangeValueForKey:@"multipassIdentifier"];
    [self setPrimitiveValue:value_ forKey:@"multipassIdentifier"];
    [self didChangeValueForKey:@"multipassIdentifier"];
}

- (NSString*)note {
    [self willAccessValueForKey:@"note"];
    id value = [self primitiveValueForKey:@"note"];
    [self didAccessValueForKey:@"note"];
    return value;
}

- (void)setNote:(NSString*)value_ {
    [self willChangeValueForKey:@"note"];
    [self setPrimitiveValue:value_ forKey:@"note"];
    [self didChangeValueForKey:@"note"];
}

- (NSNumber*)ordersCount {
    [self willAccessValueForKey:@"ordersCount"];
    id value = [self primitiveValueForKey:@"ordersCount"];
    [self didAccessValueForKey:@"ordersCount"];
    return value;
}

- (void)setOrdersCount:(NSNumber*)value_ {
    [self willChangeValueForKey:@"ordersCount"];
    [self setPrimitiveValue:value_ forKey:@"ordersCount"];
    [self didChangeValueForKey:@"ordersCount"];
}

- (NSString*)tags {
    [self willAccessValueForKey:@"tags"];
    id value = [self primitiveValueForKey:@"tags"];
    [self didAccessValueForKey:@"tags"];
    return value;
}

- (void)setTags:(NSString*)value_ {
    [self willChangeValueForKey:@"tags"];
    [self setPrimitiveValue:value_ forKey:@"tags"];
    [self didChangeValueForKey:@"tags"];
}

- (NSNumber*)taxExempt {
    [self willAccessValueForKey:@"taxExempt"];
    id value = [self primitiveValueForKey:@"taxExempt"];
    [self didAccessValueForKey:@"taxExempt"];
    return value;
}

- (void)setTaxExempt:(NSNumber*)value_ {
    [self willChangeValueForKey:@"taxExempt"];
    [self setPrimitiveValue:value_ forKey:@"taxExempt"];
    [self didChangeValueForKey:@"taxExempt"];
}

- (NSDecimalNumber*)totalSpent {
    [self willAccessValueForKey:@"totalSpent"];
    id value = [self primitiveValueForKey:@"totalSpent"];
    [self didAccessValueForKey:@"totalSpent"];
    return value;
}

- (void)setTotalSpent:(NSDecimalNumber*)value_ {
    [self willChangeValueForKey:@"totalSpent"];
    [self setPrimitiveValue:value_ forKey:@"totalSpent"];
    [self didChangeValueForKey:@"totalSpent"];
}

- (NSDate*)updatedAt {
    [self willAccessValueForKey:@"updatedAt"];
    id value = [self primitiveValueForKey:@"updatedAt"];
    [self didAccessValueForKey:@"updatedAt"];
    return value;
}

- (void)setUpdatedAt:(NSDate*)value_ {
    [self willChangeValueForKey:@"updatedAt"];
    [self setPrimitiveValue:value_ forKey:@"updatedAt"];
    [self didChangeValueForKey:@"updatedAt"];
}

- (NSNumber*)verifiedEmail {
    [self willAccessValueForKey:@"verifiedEmail"];
    id value = [self primitiveValueForKey:@"verifiedEmail"];
    [self didAccessValueForKey:@"verifiedEmail"];
    return value;
}

- (void)setVerifiedEmail:(NSNumber*)value_ {
    [self willChangeValueForKey:@"verifiedEmail"];
    [self setPrimitiveValue:value_ forKey:@"verifiedEmail"];
    [self didChangeValueForKey:@"verifiedEmail"];
}

#endif

- (BOOL)acceptsMarketingValue {
	NSNumber *result = [self acceptsMarketing];
	return [result boolValue];
}

- (void)setAcceptsMarketingValue:(BOOL)value_ {
	[self setAcceptsMarketing:@(value_)];
}

- (BOOL)customerStateValue {
	NSNumber *result = [self customerState];
	return [result boolValue];
}

- (void)setCustomerStateValue:(BOOL)value_ {
	[self setCustomerState:@(value_)];
}

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (int64_t)lastOrderIDValue {
	NSNumber *result = [self lastOrderID];
	return [result longLongValue];
}

- (void)setLastOrderIDValue:(int64_t)value_ {
	[self setLastOrderID:@(value_)];
}

- (int16_t)ordersCountValue {
	NSNumber *result = [self ordersCount];
	return [result shortValue];
}

- (void)setOrdersCountValue:(int16_t)value_ {
	[self setOrdersCount:@(value_)];
}

- (BOOL)taxExemptValue {
	NSNumber *result = [self taxExempt];
	return [result boolValue];
}

- (void)setTaxExemptValue:(BOOL)value_ {
	[self setTaxExempt:@(value_)];
}

- (BOOL)verifiedEmailValue {
	NSNumber *result = [self verifiedEmail];
	return [result boolValue];
}

- (void)setVerifiedEmailValue:(BOOL)value_ {
	[self setVerifiedEmail:@(value_)];
}

@end

#pragma mark -

@implementation BUYModelManager (BUYCustomerInserting)

- (BUYCustomer *)insertCustomerWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYCustomer *)[self buy_objectWithEntityName:@"Customer" JSONDictionary:dictionary];
}

- (NSArray<BUYCustomer *> *)insertCustomersWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYCustomer *> *)[self buy_objectsWithEntityName:@"Customer" JSONArray:array];
}

- (NSArray<BUYCustomer *> *)allCustomerObjects
{
	return (NSArray<BUYCustomer *> *)[self buy_objectsWithEntityName:@"Customer" identifiers:nil];
}

- (BUYCustomer *)fetchCustomerWithIdentifierValue:(int64_t)identifier
{
    return (BUYCustomer *)[self buy_objectWithEntityName:@"Customer" identifier:@(identifier)];
}

@end

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

const struct BUYCustomerRelationships BUYCustomerRelationships = {
	.addresses = @"addresses",
	.defaultAddress = @"defaultAddress",
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
@dynamic acceptsMarketing;
@dynamic createdAt;
@dynamic customerState;
@dynamic email;
@dynamic firstName;
@dynamic identifier;
@dynamic lastName;
@dynamic lastOrderID;
@dynamic lastOrderName;
@dynamic multipassIdentifier;
@dynamic note;
@dynamic ordersCount;
@dynamic tags;
@dynamic taxExempt;
@dynamic totalSpent;
@dynamic updatedAt;
@dynamic verifiedEmail;
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

#if defined CORE_DATA_PERSISTENCE
@dynamic addresses;
#endif

- (NSMutableSet *)addressesSet {
	[self willAccessValueForKey:@"addresses"];

	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"addresses"];

	[self didAccessValueForKey:@"addresses"];
	return result;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic defaultAddress;
#endif

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

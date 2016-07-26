//
//  _BUYAddress.h
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
// Make changes to BUYAddress.m instead.

#import "_BUYAddress.h"

const struct BUYAddressAttributes BUYAddressAttributes = {
	.address1 = @"address1",
	.address2 = @"address2",
	.city = @"city",
	.company = @"company",
	.country = @"country",
	.countryCode = @"countryCode",
	.firstName = @"firstName",
	.identifier = @"identifier",
	.isDefault = @"isDefault",
	.lastName = @"lastName",
	.phone = @"phone",
	.province = @"province",
	.provinceCode = @"provinceCode",
	.zip = @"zip",
};

const struct BUYAddressRelationships BUYAddressRelationships = {
	.customer = @"customer",
};

const struct BUYAddressUserInfo BUYAddressUserInfo = {
	.documentation = @"A BUYAddress represents a shipping or billing address on an order. This will be associated with the customer upon completion.",
};

@implementation _BUYAddress

+ (NSString *)entityName {
	return @"Address";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isDefaultValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isDefault"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
@dynamic address1;
@dynamic address2;
@dynamic city;
@dynamic company;
@dynamic country;
@dynamic countryCode;
@dynamic firstName;
@dynamic identifier;
@dynamic isDefault;
@dynamic lastName;
@dynamic phone;
@dynamic province;
@dynamic provinceCode;
@dynamic zip;
#endif

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (BOOL)isDefaultValue {
	NSNumber *result = [self isDefault];
	return [result boolValue];
}

- (void)setIsDefaultValue:(BOOL)value_ {
	[self setIsDefault:@(value_)];
}

#if defined CORE_DATA_PERSISTENCE
@dynamic customer;
#endif

@end

#pragma mark -

@implementation BUYModelManager (BUYAddressInserting)

- (BUYAddress *)insertAddressWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYAddress *)[self buy_objectWithEntityName:@"Address" JSONDictionary:dictionary];
}

- (NSArray<BUYAddress *> *)insertAddresssWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYAddress *> *)[self buy_objectsWithEntityName:@"Address" JSONArray:array];
}

- (NSArray<BUYAddress *> *)allAddressObjects
{
	return (NSArray<BUYAddress *> *)[self buy_objectsWithEntityName:@"Address" identifiers:nil];
}

- (BUYAddress *)fetchAddressWithIdentifierValue:(int64_t)identifier
{
    return (BUYAddress *)[self buy_objectWithEntityName:@"Address" identifier:@(identifier)];
}

@end

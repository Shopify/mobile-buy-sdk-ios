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

	return keyPaths;
}

#if defined CORE_DATA_PERSISTENCE
- (NSString*)address1 {
    [self willAccessValueForKey:@"address1"];
    id value = [self primitiveValueForKey:@"address1"];
    [self didAccessValueForKey:@"address1"];
    return value;
}

- (void)setAddress1:(NSString*)value_ {
    [self willChangeValueForKey:@"address1"];
    [self setPrimitiveValue:value_ forKey:@"address1"];
    [self didChangeValueForKey:@"address1"];
}

- (NSString*)address2 {
    [self willAccessValueForKey:@"address2"];
    id value = [self primitiveValueForKey:@"address2"];
    [self didAccessValueForKey:@"address2"];
    return value;
}

- (void)setAddress2:(NSString*)value_ {
    [self willChangeValueForKey:@"address2"];
    [self setPrimitiveValue:value_ forKey:@"address2"];
    [self didChangeValueForKey:@"address2"];
}

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

- (NSString*)company {
    [self willAccessValueForKey:@"company"];
    id value = [self primitiveValueForKey:@"company"];
    [self didAccessValueForKey:@"company"];
    return value;
}

- (void)setCompany:(NSString*)value_ {
    [self willChangeValueForKey:@"company"];
    [self setPrimitiveValue:value_ forKey:@"company"];
    [self didChangeValueForKey:@"company"];
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

- (NSString*)countryCode {
    [self willAccessValueForKey:@"countryCode"];
    id value = [self primitiveValueForKey:@"countryCode"];
    [self didAccessValueForKey:@"countryCode"];
    return value;
}

- (void)setCountryCode:(NSString*)value_ {
    [self willChangeValueForKey:@"countryCode"];
    [self setPrimitiveValue:value_ forKey:@"countryCode"];
    [self didChangeValueForKey:@"countryCode"];
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

- (NSString*)phone {
    [self willAccessValueForKey:@"phone"];
    id value = [self primitiveValueForKey:@"phone"];
    [self didAccessValueForKey:@"phone"];
    return value;
}

- (void)setPhone:(NSString*)value_ {
    [self willChangeValueForKey:@"phone"];
    [self setPrimitiveValue:value_ forKey:@"phone"];
    [self didChangeValueForKey:@"phone"];
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

- (NSString*)provinceCode {
    [self willAccessValueForKey:@"provinceCode"];
    id value = [self primitiveValueForKey:@"provinceCode"];
    [self didAccessValueForKey:@"provinceCode"];
    return value;
}

- (void)setProvinceCode:(NSString*)value_ {
    [self willChangeValueForKey:@"provinceCode"];
    [self setPrimitiveValue:value_ forKey:@"provinceCode"];
    [self didChangeValueForKey:@"provinceCode"];
}

- (NSString*)zip {
    [self willAccessValueForKey:@"zip"];
    id value = [self primitiveValueForKey:@"zip"];
    [self didAccessValueForKey:@"zip"];
    return value;
}

- (void)setZip:(NSString*)value_ {
    [self willChangeValueForKey:@"zip"];
    [self setPrimitiveValue:value_ forKey:@"zip"];
    [self didChangeValueForKey:@"zip"];
}

#endif

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

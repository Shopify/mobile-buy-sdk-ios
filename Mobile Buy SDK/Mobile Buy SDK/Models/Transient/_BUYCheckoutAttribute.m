//
//  _BUYCheckoutAttribute.h
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
// Make changes to BUYCheckoutAttribute.m instead.

#import "_BUYCheckoutAttribute.h"

const struct BUYCheckoutAttributeAttributes BUYCheckoutAttributeAttributes = {
	.name = @"name",
	.value = @"value",
};

const struct BUYCheckoutAttributeRelationships BUYCheckoutAttributeRelationships = {
	.checkout = @"checkout",
};

const struct BUYCheckoutAttributeUserInfo BUYCheckoutAttributeUserInfo = {
	.documentation = @"The attribute name.",
};

@implementation _BUYCheckoutAttribute

+ (NSString *)entityName {
	return @"CheckoutAttribute";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@end

#pragma mark -

@implementation BUYModelManager (BUYCheckoutAttributeInserting)

- (BUYCheckoutAttribute *)insertCheckoutAttributeWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYCheckoutAttribute *)[self buy_objectWithEntityName:@"CheckoutAttribute" JSONDictionary:dictionary];
}

- (NSArray<BUYCheckoutAttribute *> *)insertCheckoutAttributesWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYCheckoutAttribute *> *)[self buy_objectsWithEntityName:@"CheckoutAttribute" JSONArray:array];
}

- (NSArray<BUYCheckoutAttribute *> *)allCheckoutAttributeObjects
{
    return (NSArray<BUYCheckoutAttribute *> *)[self buy_objectsWithEntityName:@"CheckoutAttribute" identifiers:nil];
}

- (BUYCheckoutAttribute *)fetchCheckoutAttributeWithIdentifierValue:(int64_t)identifier
{
    return (BUYCheckoutAttribute *)[self buy_objectWithEntityName:@"CheckoutAttribute" identifier:@(identifier)];
}

@end

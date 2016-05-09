//
//  _BUYMaskedCreditCard.h
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
// Make changes to BUYMaskedCreditCard.m instead.

#import "_BUYMaskedCreditCard.h"

const struct BUYMaskedCreditCardAttributes BUYMaskedCreditCardAttributes = {
	.expiryMonth = @"expiryMonth",
	.expiryYear = @"expiryYear",
	.firstDigits = @"firstDigits",
	.firstName = @"firstName",
	.lastDigits = @"lastDigits",
	.lastName = @"lastName",
};

const struct BUYMaskedCreditCardRelationships BUYMaskedCreditCardRelationships = {
	.checkout = @"checkout",
};

const struct BUYMaskedCreditCardUserInfo BUYMaskedCreditCardUserInfo = {
	.Transient = @"YES",
	.documentation = @"This represents a masked credit card that has been applied to a checkout.",
};

@implementation _BUYMaskedCreditCard

+ (NSString *)entityName {
	return @"MaskedCreditCard";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"expiryMonthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"expiryMonth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"expiryYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"expiryYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

- (int16_t)expiryMonthValue {
	NSNumber *result = [self expiryMonth];
	return [result shortValue];
}

- (void)setExpiryMonthValue:(int16_t)value_ {
	[self setExpiryMonth:@(value_)];
}

- (int32_t)expiryYearValue {
	NSNumber *result = [self expiryYear];
	return [result intValue];
}

- (void)setExpiryYearValue:(int32_t)value_ {
	[self setExpiryYear:@(value_)];
}

@end

#pragma mark -

@implementation BUYModelManager (BUYMaskedCreditCardInserting)

- (BUYMaskedCreditCard *)insertMaskedCreditCardWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYMaskedCreditCard *)[self buy_objectWithEntityName:@"MaskedCreditCard" JSONDictionary:dictionary];
}

- (NSArray<BUYMaskedCreditCard *> *)insertMaskedCreditCardsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYMaskedCreditCard *> *)[self buy_objectsWithEntityName:@"MaskedCreditCard" JSONArray:array];
}

- (NSArray<BUYMaskedCreditCard *> *)allMaskedCreditCardObjects
{
    return (NSArray<BUYMaskedCreditCard *> *)[self buy_objectsWithEntityName:@"MaskedCreditCard" identifiers:nil];
}

- (BUYMaskedCreditCard *)fetchMaskedCreditCardWithIdentifierValue:(int64_t)identifier
{
    return (BUYMaskedCreditCard *)[self buy_objectWithEntityName:@"MaskedCreditCard" identifier:@(identifier)];
}

@end

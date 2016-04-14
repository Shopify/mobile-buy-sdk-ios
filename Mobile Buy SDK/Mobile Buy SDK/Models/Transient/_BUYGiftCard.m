//
//  _BUYGiftCard.h
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
// Make changes to BUYGiftCard.m instead.

#import "_BUYGiftCard.h"

const struct BUYGiftCardAttributes BUYGiftCardAttributes = {
	.amountUsed = @"amountUsed",
	.balance = @"balance",
	.code = @"code",
	.identifier = @"identifier",
	.lastCharacters = @"lastCharacters",
};

const struct BUYGiftCardRelationships BUYGiftCardRelationships = {
	.redemptions = @"redemptions",
};

const struct BUYGiftCardUserInfo BUYGiftCardUserInfo = {
	.documentation = @"A gift card redeemed as payment on the checkout.",
};

@implementation _BUYGiftCard

+ (NSString *)entityName {
	return @"GiftCard";
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

- (int64_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result longLongValue];
}

- (void)setIdentifierValue:(int64_t)value_ {
	[self setIdentifier:@(value_)];
}

- (NSMutableSet*)redemptionsSet {

	return (NSMutableSet*)[self mutableSetValueForKey:@"redemptions"];

}

@end

#pragma mark -

@implementation BUYModelManager (BUYGiftCardInserting)

- (BUYGiftCard *)insertGiftCardWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYGiftCard *)[self buy_objectWithEntityName:@"GiftCard" JSONDictionary:dictionary];
}

- (NSArray<BUYGiftCard *> *)insertGiftCardsWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYGiftCard *> *)[self buy_objectsWithEntityName:@"GiftCard" JSONArray:array];
}

- (NSArray<BUYGiftCard *> *)allGiftCardObjects
{
    return (NSArray<BUYGiftCard *> *)[self buy_objectsWithEntityName:@"GiftCard" identifiers:nil];
}

- (BUYGiftCard *)fetchGiftCardWithIdentifierValue:(int64_t)identifier
{
    return (BUYGiftCard *)[self buy_objectWithEntityName:@"GiftCard" identifier:@(identifier)];
}

@end

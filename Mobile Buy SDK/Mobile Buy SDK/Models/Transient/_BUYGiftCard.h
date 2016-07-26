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
// Make changes to BUYGiftCard.h instead.

#import <Buy/BUYObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYGiftCardAttributes {
	__unsafe_unretained NSString *amountUsed;
	__unsafe_unretained NSString *balance;
	__unsafe_unretained NSString *code;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *lastCharacters;
} BUYGiftCardAttributes;

extern const struct BUYGiftCardRelationships {
	__unsafe_unretained NSString *redemptions;
} BUYGiftCardRelationships;

extern const struct BUYGiftCardUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYGiftCardUserInfo;

@class BUYCheckout;

@class BUYGiftCard;
@interface BUYModelManager (BUYGiftCardInserting)
- (NSArray<BUYGiftCard *> *)allGiftCardObjects;
- (BUYGiftCard *)fetchGiftCardWithIdentifierValue:(int64_t)identifier;
- (BUYGiftCard *)insertGiftCardWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYGiftCard *> *)insertGiftCardsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * A gift card redeemed as payment on the checkout.
 */
@interface _BUYGiftCard : BUYObject

+ (NSString *)entityName;

/**
 * The amount of the gift card used by this checkout.
 */
@property (nonatomic, strong) NSDecimalNumber* amountUsed;

/**
 * The amount left on the gift card after being applied to this checkout.
 */
@property (nonatomic, strong) NSDecimalNumber* balance;

/**
 * The gift card code.
 *
 * This is only used when applying a gift card and is not visible on a BUYCheckout object synced with Shopify.
 */
@property (nonatomic, strong) NSString* code;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * The last characters of the applied gift card code.
 */
@property (nonatomic, strong) NSString* lastCharacters;

/**
 * Inverse of Checkout.giftCard.
 */
@property (nonatomic, strong) NSSet *redemptions;

- (NSMutableSet*)redemptionsSet;

@end

@interface _BUYGiftCard (RedemptionsCoreDataGeneratedAccessors)

@end


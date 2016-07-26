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
// Make changes to BUYMaskedCreditCard.h instead.

#import <Buy/BUYObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYMaskedCreditCardAttributes {
	__unsafe_unretained NSString *expiryMonth;
	__unsafe_unretained NSString *expiryYear;
	__unsafe_unretained NSString *firstDigits;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastDigits;
	__unsafe_unretained NSString *lastName;
} BUYMaskedCreditCardAttributes;

extern const struct BUYMaskedCreditCardRelationships {
	__unsafe_unretained NSString *checkout;
} BUYMaskedCreditCardRelationships;

extern const struct BUYMaskedCreditCardUserInfo {
	__unsafe_unretained NSString *Transient;
	__unsafe_unretained NSString *documentation;
} BUYMaskedCreditCardUserInfo;

@class BUYCheckout;

@class BUYMaskedCreditCard;
@interface BUYModelManager (BUYMaskedCreditCardInserting)
- (NSArray<BUYMaskedCreditCard *> *)allMaskedCreditCardObjects;
- (BUYMaskedCreditCard *)fetchMaskedCreditCardWithIdentifierValue:(int64_t)identifier;
- (BUYMaskedCreditCard *)insertMaskedCreditCardWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYMaskedCreditCard *> *)insertMaskedCreditCardsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * This represents a masked credit card that has been applied to a checkout.
 */
@interface _BUYMaskedCreditCard : BUYObject

+ (NSString *)entityName;

/**
 * The two digits representing the month the card expires.
 */
@property (nonatomic, strong) NSNumber* expiryMonth;

@property (atomic) int16_t expiryMonthValue;
- (int16_t)expiryMonthValue;
- (void)setExpiryMonthValue:(int16_t)value_;

/**
 * The year the card expires.
 */
@property (nonatomic, strong) NSNumber* expiryYear;

@property (atomic) int32_t expiryYearValue;
- (int32_t)expiryYearValue;
- (void)setExpiryYearValue:(int32_t)value_;

/**
 * The first digits of credit card number.
 */
@property (nonatomic, strong) NSString* firstDigits;

/**
 * The first name on the credit card.
 */
@property (nonatomic, strong) NSString* firstName;

/**
 * The last digits of credit card number.
 */
@property (nonatomic, strong) NSString* lastDigits;

/**
 * The last name on the credit card.
 */
@property (nonatomic, strong) NSString* lastName;

/**
 * Inverse of Checkout.creditCard.
 */
@property (nonatomic, strong) BUYCheckout *checkout;

@end


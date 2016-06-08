//
//  _BUYDiscount.h
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
// Make changes to BUYDiscount.h instead.

#import <Buy/BUYObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYDiscountAttributes {
	__unsafe_unretained NSString *amount;
	__unsafe_unretained NSString *applicable;
	__unsafe_unretained NSString *code;
} BUYDiscountAttributes;

extern const struct BUYDiscountRelationships {
	__unsafe_unretained NSString *checkout;
} BUYDiscountRelationships;

extern const struct BUYDiscountUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYDiscountUserInfo;

@class BUYCheckout;

@class BUYDiscount;
@interface BUYModelManager (BUYDiscountInserting)
- (NSArray<BUYDiscount *> *)allDiscountObjects;
- (BUYDiscount *)fetchDiscountWithIdentifierValue:(int64_t)identifier;
- (BUYDiscount *)insertDiscountWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYDiscount *> *)insertDiscountsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * BUYDiscount represents a discount that is applied to the BUYCheckout.
 */
@interface _BUYDiscount : BUYObject

+ (NSString *)entityName;

/**
 * The amount that is deducted from `paymentDue` on BUYCheckout.
 */
@property (nonatomic, strong) NSDecimalNumber* amount;

/**
 * Whether this discount code can be applied to the checkout.
 */
@property (nonatomic, strong) NSNumber* applicable;

@property (atomic) BOOL applicableValue;
- (BOOL)applicableValue;
- (void)setApplicableValue:(BOOL)value_;

/**
 * The unique identifier for the discount code.
 */
@property (nonatomic, strong) NSString* code;

@property (nonatomic, strong) BUYCheckout *checkout;

@end


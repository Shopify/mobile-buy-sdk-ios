//
//  _BUYTaxLine.h
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
// Make changes to BUYTaxLine.h instead.

#import <Buy/BUYObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYTaxLineAttributes {
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *rate;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *updatedAt;
} BUYTaxLineAttributes;

extern const struct BUYTaxLineRelationships {
	__unsafe_unretained NSString *checkout;
} BUYTaxLineRelationships;

extern const struct BUYTaxLineUserInfo {
	__unsafe_unretained NSString *Transient;
	__unsafe_unretained NSString *documentation;
} BUYTaxLineUserInfo;

@class BUYCheckout;

@class BUYTaxLine;
@interface BUYModelManager (BUYTaxLineInserting)
- (NSArray<BUYTaxLine *> *)allTaxLineObjects;
- (BUYTaxLine *)fetchTaxLineWithIdentifierValue:(int64_t)identifier;
- (BUYTaxLine *)insertTaxLineWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYTaxLine *> *)insertTaxLinesWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * BUYTaxLine represents a single tax line on a checkout. Use this to display an itemized list of taxes that a customer is being charged for.
 */
@interface _BUYTaxLine : BUYObject

+ (NSString *)entityName;

@property (nonatomic, strong) NSDate* createdAt;

/**
 * The amount of tax to be charged.
 */
@property (nonatomic, strong) NSDecimalNumber* price;

/**
 * The rate of tax to be applied.
 */
@property (nonatomic, strong) NSDecimalNumber* rate;

/**
 * The name of the tax.
 */
@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) NSDate* updatedAt;

/**
 * Inverse of Checkout.taxLines.
 */
@property (nonatomic, strong) BUYCheckout *checkout;

@end


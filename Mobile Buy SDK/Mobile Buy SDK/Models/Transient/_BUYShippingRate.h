//
//  _BUYShippingRate.h
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
// Make changes to BUYShippingRate.h instead.

#import <Buy/BUYObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYShippingRateAttributes {
	__unsafe_unretained NSString *deliveryRange;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *shippingRateIdentifier;
	__unsafe_unretained NSString *title;
} BUYShippingRateAttributes;

extern const struct BUYShippingRateRelationships {
	__unsafe_unretained NSString *checkout;
} BUYShippingRateRelationships;

extern const struct BUYShippingRateUserInfo {
	__unsafe_unretained NSString *Transient;
	__unsafe_unretained NSString *documentation;
} BUYShippingRateUserInfo;

@class BUYCheckout;

@class NSArray;

@class BUYShippingRate;
@interface BUYModelManager (BUYShippingRateInserting)
- (NSArray<BUYShippingRate *> *)allShippingRateObjects;
- (BUYShippingRate *)fetchShippingRateWithIdentifierValue:(int64_t)identifier;
- (BUYShippingRate *)insertShippingRateWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYShippingRate *> *)insertShippingRatesWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * BUYShippingRate represents the amount that the merchant is charging a customer for shipping to the specified address.
 */
@interface _BUYShippingRate : BUYObject

+ (NSString *)entityName;

/**
 * One or two NSDate objects of the potential delivery dates.
 */
@property (nonatomic, strong) NSArray* deliveryRange;

/**
 * The price of this shipping method.
 */
@property (nonatomic, strong) NSDecimalNumber* price;

/**
 * A reference to the shipping method.
 */
@property (nonatomic, strong) NSString* shippingRateIdentifier;

/**
 * The shipping method name.
 */
@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) BUYCheckout *checkout;

@end


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
// Make changes to BUYAddress.h instead.

#import "BUYObject.h"

#import <Buy/BUYModelManager.h>

extern const struct BUYAddressAttributes {
	__unsafe_unretained NSString *address1;
	__unsafe_unretained NSString *address2;
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *company;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *countryCode;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *province;
	__unsafe_unretained NSString *provinceCode;
	__unsafe_unretained NSString *zip;
} BUYAddressAttributes;

extern const struct BUYAddressUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYAddressUserInfo;

@class BUYAddress;
@interface BUYModelManager (BUYAddressInserting)
- (NSArray<BUYAddress *> *)allAddressObjects;
- (BUYAddress *)fetchAddressWithIdentifierValue:(int64_t)identifier;
- (BUYAddress *)insertAddressWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYAddress *> *)insertAddresssWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * A BUYAddress represents a shipping or billing address on an order. This will be associated with the customer upon completion.
 */
@interface _BUYAddress : BUYObject

+ (NSString *)entityName;

/**
 * The street address of the address.
 */
@property (nonatomic, strong) NSString* address1;

/**
 * An optional additional field for the street address of the address.
 */
@property (nonatomic, strong) NSString* address2;

/**
 * The city of the address.
 */
@property (nonatomic, strong) NSString* city;

/**
 * The company of the person associated with the address (optional).
 */
@property (nonatomic, strong) NSString* company;

/**
 * The name of the country of the address.
 */
@property (nonatomic, strong) NSString* country;

/**
 * The two-letter code (ISO 3166-1 alpha-2 two-letter country code) for the country of the address.
 */
@property (nonatomic, strong) NSString* countryCode;

/**
 * The first name of the person associated with the payment method.
 */
@property (nonatomic, strong) NSString* firstName;

/**
 * The last name of the person associated with the payment method.
 */
@property (nonatomic, strong) NSString* lastName;

/**
 * The phone number at the address.
 */
@property (nonatomic, strong) NSString* phone;

/**
 * The name of the state or province of the address
 */
@property (nonatomic, strong) NSString* province;

/**
 * The two-letter abbreviation of the state or province of the address.
 */
@property (nonatomic, strong) NSString* provinceCode;

/**
 * The zip or postal code of the address.
 */
@property (nonatomic, strong) NSString* zip;

@end


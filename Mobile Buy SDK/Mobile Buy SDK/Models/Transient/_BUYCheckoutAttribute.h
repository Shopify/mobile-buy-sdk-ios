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
// Make changes to BUYCheckoutAttribute.h instead.

#import <Buy/BUYObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYCheckoutAttributeAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *value;
} BUYCheckoutAttributeAttributes;

extern const struct BUYCheckoutAttributeRelationships {
	__unsafe_unretained NSString *checkout;
} BUYCheckoutAttributeRelationships;

extern const struct BUYCheckoutAttributeUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYCheckoutAttributeUserInfo;

@class BUYCheckout;

@class BUYCheckoutAttribute;
@interface BUYModelManager (BUYCheckoutAttributeInserting)
- (NSArray<BUYCheckoutAttribute *> *)allCheckoutAttributeObjects;
- (BUYCheckoutAttribute *)fetchCheckoutAttributeWithIdentifierValue:(int64_t)identifier;
- (BUYCheckoutAttribute *)insertCheckoutAttributeWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYCheckoutAttribute *> *)insertCheckoutAttributesWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * The attribute name.
 */
@interface _BUYCheckoutAttribute : BUYObject

+ (NSString *)entityName;

@property (nonatomic, strong) NSString* name;

/**
 * The attribute value.
 */
@property (nonatomic, strong) NSString* value;

@property (nonatomic, strong) BUYCheckout *checkout;

@end


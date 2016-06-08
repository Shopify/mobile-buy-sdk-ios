//
//  _BUYOption.h
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
// Make changes to BUYOption.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYOptionAttributes {
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *position;
} BUYOptionAttributes;

extern const struct BUYOptionRelationships {
	__unsafe_unretained NSString *product;
} BUYOptionRelationships;

extern const struct BUYOptionUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYOptionUserInfo;

@class BUYProduct;

@class BUYOption;
@interface BUYModelManager (BUYOptionInserting)
- (NSArray<BUYOption *> *)allOptionObjects;
- (BUYOption *)fetchOptionWithIdentifierValue:(int64_t)identifier;
- (BUYOption *)insertOptionWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYOption *> *)insertOptionsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * The associated product for this option.
 */
@interface _BUYOption : BUYCachedObject
+ (NSString *)entityName;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * Custom product property names like "Size", "Color", and "Material".
 *
 * 255 characters limit each.
 */
@property (nonatomic, strong) NSString* name;

/**
 * The order in which the option should optionally appear.
 */
@property (nonatomic, strong) NSNumber* position;

@property (atomic) int32_t positionValue;
- (int32_t)positionValue;
- (void)setPositionValue:(int32_t)value_;

/**
 * Inverse of Product.options.
 */

@property (nonatomic, strong) BUYProduct *product;

@end

@interface _BUYOption (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePosition;
- (void)setPrimitivePosition:(NSNumber*)value;

- (BUYProduct *)primitiveProduct;
- (void)setPrimitiveProduct:(BUYProduct *)value;

@end

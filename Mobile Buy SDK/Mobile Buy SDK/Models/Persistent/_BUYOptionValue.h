//
//  _BUYOptionValue.h
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
// Make changes to BUYOptionValue.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYOptionValueAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *optionId;
	__unsafe_unretained NSString *value;
} BUYOptionValueAttributes;

extern const struct BUYOptionValueRelationships {
	__unsafe_unretained NSString *variants;
} BUYOptionValueRelationships;

@class BUYProductVariant;

@class BUYOptionValue;
@interface BUYModelManager (BUYOptionValueInserting)
- (NSArray<BUYOptionValue *> *)allOptionValueObjects;
- (BUYOptionValue *)fetchOptionValueWithIdentifierValue:(int64_t)identifier;
- (BUYOptionValue *)insertOptionValueWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYOptionValue *> *)insertOptionValuesWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

@interface _BUYOptionValue : BUYCachedObject
+ (NSString *)entityName;

/**
 * Custom product property names like "Size", "Color", and "Material".
 *
 * The same as the name of the owning option. 255 characters max.
 */
@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSNumber* optionId;

@property (atomic) int64_t optionIdValue;
- (int64_t)optionIdValue;
- (void)setOptionIdValue:(int64_t)value_;

/**
 * The value of the option.
 *
 * For example, "Small", "Medium" or "Large".
 */
@property (nonatomic, strong) NSString* value;

/**
 * Inverse of ProductVariant.optionValue.
 */
@property (nonatomic, strong) NSSet *variants;
- (NSMutableSet *)variantsSet;

@end

@interface _BUYOptionValue (VariantsCoreDataGeneratedAccessors)

@end

@interface _BUYOptionValue (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveOptionId;
- (void)setPrimitiveOptionId:(NSNumber*)value;

- (NSString*)primitiveValue;
- (void)setPrimitiveValue:(NSString*)value;

- (NSMutableSet *)primitiveVariants;
- (void)setPrimitiveVariants:(NSMutableSet *)value;

@end

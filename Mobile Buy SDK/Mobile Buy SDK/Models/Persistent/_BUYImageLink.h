//
//  _BUYImageLink.h
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
// Make changes to BUYImageLink.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYImageLinkAttributes {
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *position;
	__unsafe_unretained NSString *sourceURL;
	__unsafe_unretained NSString *updatedAt;
	__unsafe_unretained NSString *variantIds;
} BUYImageLinkAttributes;

extern const struct BUYImageLinkRelationships {
	__unsafe_unretained NSString *collection;
	__unsafe_unretained NSString *product;
} BUYImageLinkRelationships;

extern const struct BUYImageLinkUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYImageLinkUserInfo;

@class BUYCollection;
@class BUYProduct;

@class NSURL;

@class NSArray;

@class BUYImageLink;
@interface BUYModelManager (BUYImageLinkInserting)
- (NSArray<BUYImageLink *> *)allImageLinkObjects;
- (BUYImageLink *)fetchImageLinkWithIdentifierValue:(int64_t)identifier;
- (BUYImageLink *)insertImageLinkWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYImageLink *> *)insertImageLinksWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * A link to an image representing a product or collection.
 */
@interface _BUYImageLink : BUYCachedObject
+ (NSString *)entityName;

@property (nonatomic, strong) NSDate* createdAt;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * The position of the image for the product.
 */
@property (nonatomic, strong) NSNumber* position;

@property (atomic) int32_t positionValue;
- (int32_t)positionValue;
- (void)setPositionValue:(int32_t)value_;

/**
 * Specifies the location of the product image.
 *
 * Maps to "src" in JSON.
 */
@property (nonatomic, strong) NSURL* sourceURL;

@property (nonatomic, strong) NSDate* updatedAt;

@property (nonatomic, strong) NSArray* variantIds;

@property (nonatomic, strong) BUYCollection *collection;

/**
 * Inverse of Product.images.
 *
 * Maps to "product_id" in JSON.
 */

@property (nonatomic, strong) BUYProduct *product;

@end

@interface _BUYImageLink (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSNumber*)primitivePosition;
- (void)setPrimitivePosition:(NSNumber*)value;

- (NSURL*)primitiveSourceURL;
- (void)setPrimitiveSourceURL:(NSURL*)value;

- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;

- (NSArray*)primitiveVariantIds;
- (void)setPrimitiveVariantIds:(NSArray*)value;

- (BUYCollection *)primitiveCollection;
- (void)setPrimitiveCollection:(BUYCollection *)value;

- (BUYProduct *)primitiveProduct;
- (void)setPrimitiveProduct:(BUYProduct *)value;

@end

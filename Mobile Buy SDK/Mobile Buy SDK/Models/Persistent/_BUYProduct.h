//
//  _BUYProduct.h
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
// Make changes to BUYProduct.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYProductAttributes {
	__unsafe_unretained NSString *available;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *handle;
	__unsafe_unretained NSString *htmlDescription;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *productType;
	__unsafe_unretained NSString *published;
	__unsafe_unretained NSString *publishedAt;
	__unsafe_unretained NSString *tags;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *updatedAt;
	__unsafe_unretained NSString *vendor;
} BUYProductAttributes;

extern const struct BUYProductRelationships {
	__unsafe_unretained NSString *collections;
	__unsafe_unretained NSString *images;
	__unsafe_unretained NSString *options;
	__unsafe_unretained NSString *variants;
} BUYProductRelationships;

extern const struct BUYProductUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYProductUserInfo;

@class BUYCollection;
@class BUYImageLink;
@class BUYOption;
@class BUYProductVariant;

@class NSSet;

@class BUYProduct;
@interface BUYModelManager (BUYProductInserting)
- (NSArray<BUYProduct *> *)allProductObjects;
- (BUYProduct *)fetchProductWithIdentifierValue:(int64_t)identifier;
- (BUYProduct *)insertProductWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYProduct *> *)insertProductsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * A BUYProduct is an individual item for sale in a Shopify shop.
 */
@interface _BUYProduct : BUYCachedObject
+ (NSString *)entityName;

/**
 * If the product is in stock. See each variant for their specific availability.
 */
@property (nonatomic, strong) NSNumber* available;

@property (atomic) BOOL availableValue;
- (BOOL)availableValue;
- (void)setAvailableValue:(BOOL)value_;

/**
 * The creation date for a product.
 */
@property (nonatomic, strong) NSDate* createdAt;

/**
 * The handle of the product. Can be used to construct links to the web page for the product.
 */
@property (nonatomic, strong) NSString* handle;

/**
 * The description of the product, complete with HTML formatting.
 *
 * Maps to "body_html" in JSON.
 */
@property (nonatomic, strong) NSString* htmlDescription;

/**
 * Maps to product_id in the JSON
 */
@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * A categorization that a product can be tagged with, commonly used for filtering and searching.
 */
@property (nonatomic, strong) NSString* productType;

/**
 * The product is published on the current sales channel.
 */
@property (nonatomic, strong) NSNumber* published;

@property (atomic) BOOL publishedValue;
- (BOOL)publishedValue;
- (void)setPublishedValue:(BOOL)value_;

/**
 * The publish date for a product.
 */
@property (nonatomic, strong) NSDate* publishedAt;

/**
 * A categorization that a product can be tagged with.
 *
 * Commonly used for filtering and searching. Each tag has a imit of 255 characters.
 */
@property (nonatomic, strong) NSSet* tags;

/**
 * The name of the product.
 *
 * In a shop's catalog, clicking on a product's title takes you to that product's page. On a product's page, the product's title typically appears in a large font.
 */
@property (nonatomic, strong) NSString* title;

/**
 * The updated date for a product.
 */
@property (nonatomic, strong) NSDate* updatedAt;

/**
 * The name of the vendor of the product.
 */
@property (nonatomic, strong) NSString* vendor;

/**
 * The collections in which this product appears.
 *
 * Maps to "collection_ids" in JSON.
 */
@property (nonatomic, strong) NSSet *collections;
- (NSMutableSet *)collectionsSet;

/**
 * A list of BUYImageLink objects, each one representing an image associated with the product.
 */
@property (nonatomic, strong) NSOrderedSet *images;
- (NSMutableOrderedSet *)imagesSet;

/**
 * Custom product property names like "Size", "Color", and "Material".
 *
 * Products are based on permutations of these options. A product may have a maximum of 3 options. 255 characters limit each.
 */
@property (nonatomic, strong) NSOrderedSet *options;
- (NSMutableOrderedSet *)optionsSet;

/**
 * A list of BUYProductVariant objects, each one representing a slightly different version of the product.
 */
@property (nonatomic, strong) NSOrderedSet *variants;
- (NSMutableOrderedSet *)variantsSet;

@end

@interface _BUYProduct (CollectionsCoreDataGeneratedAccessors)

@end

@interface _BUYProduct (ImagesCoreDataGeneratedAccessors)

- (void)insertObject:(BUYImageLink *)value inImagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx;
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(BUYImageLink *)value;
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)values;

@end

@interface _BUYProduct (OptionsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYOption *)value inOptionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromOptionsAtIndex:(NSUInteger)idx;
- (void)insertOptions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeOptionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInOptionsAtIndex:(NSUInteger)idx withObject:(BUYOption *)value;
- (void)replaceOptionsAtIndexes:(NSIndexSet *)indexes withOptions:(NSArray *)values;

@end

@interface _BUYProduct (VariantsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYProductVariant *)value inVariantsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromVariantsAtIndex:(NSUInteger)idx;
- (void)insertVariants:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeVariantsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInVariantsAtIndex:(NSUInteger)idx withObject:(BUYProductVariant *)value;
- (void)replaceVariantsAtIndexes:(NSIndexSet *)indexes withVariants:(NSArray *)values;

@end

@interface _BUYProduct (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAvailable;
- (void)setPrimitiveAvailable:(NSNumber*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSString*)primitiveHandle;
- (void)setPrimitiveHandle:(NSString*)value;

- (NSString*)primitiveHtmlDescription;
- (void)setPrimitiveHtmlDescription:(NSString*)value;

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSString*)primitiveProductType;
- (void)setPrimitiveProductType:(NSString*)value;

- (NSNumber*)primitivePublished;
- (void)setPrimitivePublished:(NSNumber*)value;

- (NSDate*)primitivePublishedAt;
- (void)setPrimitivePublishedAt:(NSDate*)value;

- (NSSet*)primitiveTags;
- (void)setPrimitiveTags:(NSSet*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;

- (NSString*)primitiveVendor;
- (void)setPrimitiveVendor:(NSString*)value;

- (NSMutableSet *)primitiveCollections;
- (void)setPrimitiveCollections:(NSMutableSet *)value;

- (NSMutableOrderedSet *)primitiveImages;
- (void)setPrimitiveImages:(NSMutableOrderedSet *)value;

- (NSMutableOrderedSet *)primitiveOptions;
- (void)setPrimitiveOptions:(NSMutableOrderedSet *)value;

- (NSMutableOrderedSet *)primitiveVariants;
- (void)setPrimitiveVariants:(NSMutableOrderedSet *)value;

@end

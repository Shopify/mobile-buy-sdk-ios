//
//  _BUYCollection.h
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
// Make changes to BUYCollection.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYCollectionAttributes {
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *handle;
	__unsafe_unretained NSString *htmlDescription;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *published;
	__unsafe_unretained NSString *publishedAt;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *updatedAt;
} BUYCollectionAttributes;

extern const struct BUYCollectionRelationships {
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *products;
} BUYCollectionRelationships;

extern const struct BUYCollectionUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYCollectionUserInfo;

@class BUYImageLink;
@class BUYProduct;

@class BUYCollection;
@interface BUYModelManager (BUYCollectionInserting)
- (NSArray<BUYCollection *> *)allCollectionObjects;
- (BUYCollection *)fetchCollectionWithIdentifierValue:(int64_t)identifier;
- (BUYCollection *)insertCollectionWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYCollection *> *)insertCollectionsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * Represents a collection of products on the shop.
 */
@interface _BUYCollection : BUYCachedObject
+ (NSString *)entityName;

@property (nonatomic, strong) NSDate* createdAt;

/**
 * The handle of the collection.
 */
@property (nonatomic, strong) NSString* handle;

/**
 * The html description.
 *
 * Maps to "body_html" in JSON.
 */
@property (nonatomic, strong) NSString* htmlDescription;

/**
 * Maps to collection_id in the JSON
 */
@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * The state of whether the collection is currently published or not.
 */
@property (nonatomic, strong) NSNumber* published;

@property (atomic) BOOL publishedValue;
- (BOOL)publishedValue;
- (void)setPublishedValue:(BOOL)value_;

/**
 * The publish date for the collection.
 */
@property (nonatomic, strong) NSDate* publishedAt;

/**
 * The title of the collection.
 */
@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) NSDate* updatedAt;

@property (nonatomic, strong) BUYImageLink *image;

/**
 * Inverse of Product.collections.
 */
@property (nonatomic, strong) NSOrderedSet *products;
- (NSMutableOrderedSet *)productsSet;

@end

@interface _BUYCollection (ProductsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYProduct *)value inProductsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProductsAtIndex:(NSUInteger)idx;
- (void)insertProducts:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProductsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProductsAtIndex:(NSUInteger)idx withObject:(BUYProduct *)value;
- (void)replaceProductsAtIndexes:(NSIndexSet *)indexes withProducts:(NSArray *)values;

@end

@interface _BUYCollection (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSString*)primitiveHandle;
- (void)setPrimitiveHandle:(NSString*)value;

- (NSString*)primitiveHtmlDescription;
- (void)setPrimitiveHtmlDescription:(NSString*)value;

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSNumber*)primitivePublished;
- (void)setPrimitivePublished:(NSNumber*)value;

- (NSDate*)primitivePublishedAt;
- (void)setPrimitivePublishedAt:(NSDate*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;

- (BUYImageLink *)primitiveImage;
- (void)setPrimitiveImage:(BUYImageLink *)value;

- (NSMutableOrderedSet *)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableOrderedSet *)value;

@end

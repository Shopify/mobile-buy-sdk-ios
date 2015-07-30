//
//  BUYProduct.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"

@class BUYProductVariant;
@class BUYImage;
@class BUYOption;

/**
 *  A BUYProduct is an individual item for sale in a Shopify shop.
 */
@interface BUYProduct : BUYObject

/**
 *  The product ID
 */
@property (nonatomic, readonly, copy) NSNumber *productId;

/**
 *  The name of the product. In a shop's catalog, clicking on a product's title takes you to that product's page.
 *  On a product's page, the product's title typically appears in a large font.
 */
@property (nonatomic, readonly, copy) NSString *title;

/**
 *  The handle of the product.  Can be used to construct links to the web page for the product
 */
@property (nonatomic, readonly, copy) NSString *handle;

/**
 *  The name of the vendor of the product.
 */
@property (nonatomic, readonly, copy) NSString *vendor;

/**
 *  A categorization that a product can be tagged with, commonly used for filtering and searching.
 */
@property (nonatomic, readonly, copy) NSString *productType;

/**
 *  A list of BUYProductVariant objects, each one representing a slightly different version of the product.
 */
@property (nonatomic, readonly, copy) NSArray *variants;

/**
 *  A list of BUYImage objects, each one representing an image associated with the product.
 */
@property (nonatomic, readonly, copy) NSArray *images;

/**
 *  Custom product property names like "Size", "Color", and "Material".
 *  Products are based on permutations of these options.
 *  A product may have a maximum of 3 options. 255 characters limit each.
 */
@property (nonatomic, readonly, copy) NSArray *options;

/**
 *  The description of the product, complete with HTML formatting.
 */
@property (nonatomic, readonly, copy) NSString *htmlDescription;

/**
 *  If the product is in stock (see each variant for their specific availability)
 */
@property (nonatomic, readonly, assign) BOOL available;

/**
 *  The product is published on the current sales channel
 */
@property (nonatomic, readonly, assign) BOOL published;

/**
 *  The creation date for a product
 */
@property (nonatomic, readonly, copy) NSDate *createdAtDate;

/**
 *  The updated date for a product
 */
@property (nonatomic, readonly, copy) NSDate *updatedAtDate;

/**
 *  The publish date for a product
 */
@property (nonatomic, readonly, copy) NSDate *publishedAtDate;

@end

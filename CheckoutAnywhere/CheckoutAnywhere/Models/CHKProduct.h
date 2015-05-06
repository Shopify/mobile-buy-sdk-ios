//
//  CHKProduct.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"

@class CHKProductVariant;
@class CHKImage;
@class CHKOption;

/**
 *  A CHKProduct is an individual item for sale in a Shopify shop.
 */
@interface CHKProduct : CHKObject

/**
 *  The name of the product. In a shop's catalog, clicking on a product's title takes you to that product's page. 
 *  On a product's page, the product's title typically appears in a large font.
 */
@property (nonatomic, readonly, copy) NSString *title;

/**
 *  The name of the vendor of the product.
 */
@property (nonatomic, readonly, copy) NSString *vendor;

/**
 *  A categorization that a product can be tagged with, commonly used for filtering and searching.
 */
@property (nonatomic, readonly, copy) NSString *productType;

/**
 *  A list of CHKProductVariant objects, each one representing a slightly different version of the product.
 */
@property (nonatomic, readonly, copy) NSArray *variants;

/**
 *  A list of CHKImage objects, each one representing an image associated with the product.
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

@end

//
//  BUYProduct.h
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

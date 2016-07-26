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

#import <Buy/_BUYProduct.h>
NS_ASSUME_NONNULL_BEGIN

@interface BUYProduct : _BUYProduct {}

@property (nonatomic, readonly, copy) NSDate *createdAtDate;
@property (nonatomic, readonly, copy) NSDate *updatedAtDate;
@property (nonatomic, readonly, copy) NSDate *publishedAtDate;

@property (nonatomic, readonly, copy) NSString *stringDescription;

/**
 * An array of BUYImageLink objects, each one representing an image associated with the product.
 */
- (NSArray<BUYImageLink *> *)imagesArray;

/**
 * Custom product property names like "Size", "Color", and "Material".
 *
 * An array of BUYOption objects. Products are based on permutations of these options. A product may have a maximum of 3 options. 255 characters limit each.
 */
- (NSArray<BUYOption *> *)optionsArray;

/**
 * An array of BUYProductVariant objects, each one representing a slightly different version of the product.
 */
- (NSArray<BUYProductVariant *> *)variantsArray;

@end

@interface BUYProduct (Options)

/**
 *  Get the option values available for the given option
 *
 *  @param option the option
 *
 *  @return array of BUYOptionValues
 */
- (NSArray *)valuesForOption:(BUYOption *)option variants:(NSArray *)variants;

/**
 *  Determine the variant given an array of options
 *
 *  @param options array of option values
 *
 *  @return the product variant matching the set of options
 */
- (nullable BUYProductVariant *)variantWithOptions:(NSArray *)options;

/**
 *  Determine if the variant is a default variant automatically created by Shopify
 *
 *  @return YES if its a default variant
 */
- (BOOL)isDefaultVariant;

@end

NS_ASSUME_NONNULL_END

//
//  BUYImage.h
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

/**
 *  Products are easier to sell if customers can see pictures of them, which is why there are product images.
 */
@interface BUYImage : BUYObject

/**
 *  Specifies the location of the product image.
 */
@property (nonatomic, readonly, copy) NSString *src;

/**
 *  An array of variant ids associated with the image.
 */
@property (nonatomic, readonly, copy) NSArray *variantIds;

/**
 *  Creation date of the image
 */
@property (nonatomic, readonly, copy) NSDate *createdAtDate;

/**
 *  The date the image was last updated
 */
@property (nonatomic, readonly, copy) NSDate *updatedAtDate;

/**
 *  The position of the image for the product
 */
@property (nonatomic, readonly, copy) NSNumber *position;

/**
 *  The associated product ID for the image
 */
@property (nonatomic, readonly, copy) NSNumber *productId;

@end

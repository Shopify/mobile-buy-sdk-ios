//
//  BUYCollection.h
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

#import <Buy/Buy.h>

/**
 *  Represents a collection of products on the shop
 */
@interface BUYCollection : BUYObject

/**
 *  The title of the collection
 */
@property (nonatomic, strong, readonly) NSString *title;

/**
 *  The unique collection ID
 */
@property (nonatomic, strong, readonly) NSNumber *collectionId;

/**
 *  The html description
 */
@property (nonatomic, strong, readonly) NSString *htmlDescription;

/**
 *  The collection's image URL
 */
@property (nonatomic, strong, readonly) NSURL *imageURL;

/**
 *  The handle of the collection
 */
@property (nonatomic, strong, readonly) NSString *handle;

/**
 *  The state of whether the collection is currently published or not
 */
@property (nonatomic, assign, readonly) BOOL published;

/**
 *  The creation date for the collection
 */
@property (nonatomic, readonly, copy) NSDate *createdAtDate;

/**
 *  The updated date for the collection
 */
@property (nonatomic, readonly, copy) NSDate *updatedAtDate;

/**
 *  The publish date for the collection
 */
@property (nonatomic, readonly, copy) NSDate *publishedAtDate;

@end

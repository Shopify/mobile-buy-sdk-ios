//
//  NSArray+BUYAdditions.h
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

#import <Foundation/Foundation.h>

typedef id (^BUYObjectMap) (id);

@interface NSArray (BUYAdditions)

/**
 * Return all but the first object.
 */
@property (nonatomic, readonly, getter=buy_tail) NSArray *tail;

/**
 * Return a copy of the array with objects in in reverse order.
 */
@property (nonatomic, readonly, getter=buy_reversedArray) NSArray *reversedArray;

- (NSArray *)buy_map:(BUYObjectMap)block;

@end

@interface NSMutableArray (BUYAdditions)

/**
 * Reverse the order of the objects in place.
 */
- (void)buy_reverse;
@end

@interface NSObject (BUYModelArrayCreating)

/**
 * Returns an array form of the object.
 * Collections are converted to an array. Other objects are wrapped in an array.
 */
- (NSArray *)buy_array;

/**
 * Returns an object initialized with the given array.
 * Collections convert the array to themselves. Other objects unwrap the array.
 */
+ (instancetype)buy_convertArray:(NSArray *)array;

@end

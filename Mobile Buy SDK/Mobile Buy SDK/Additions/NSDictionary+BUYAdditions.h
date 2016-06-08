//
//  NSDictionary+BUYAdditions.h
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
#import <Buy/BUYSerializable.h>
#import <Buy/NSArray+BUYAdditions.h>

typedef NSString * (^BUYStringMap) (NSString *);

@interface NSDictionary (BUYAdditions) <BUYSerializable>

/**
 * Return a new dictionary where the objects are used as keys, and vice versa.
 */
- (NSDictionary<NSString *, NSString *> *)buy_reverseDictionary;

/**
 * Return a new dictionary, replacing existing keys with new keys provided by the map block.
 */
- (NSDictionary *)buy_dictionaryByMappingKeysWithBlock:(BUYStringMap)map;

/**
 * Return a new dictionary, replacing existing values with new values provided by the map block.
 */
- (NSDictionary *)buy_dictionaryByMappingValuesWithBlock:(BUYObjectMap)map;

/**
 *  Alernative to objectForKey, where NSNull is replaced with nil
 *
 *  @param key The key for which to return the corresponding value.
 *
 *  @return The value associated with key
 */
- (id)buy_objectForKey:(NSString *)key;

@end

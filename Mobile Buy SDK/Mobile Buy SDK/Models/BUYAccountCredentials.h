//
//  BUYAccountCredentials.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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

/**
 *   Intended for storing a collection of credential items representing individual values
 */

@class BUYAccountCredentialItem;
@interface BUYAccountCredentials : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (BUYAccountCredentials *)credentialsWithItems:(NSArray<BUYAccountCredentialItem *> *)items;
+ (BUYAccountCredentials *)credentialsWithItemKeys:(NSArray<NSString *> *)keys;

@property (readonly) NSDictionary *JSONRepresentation;
@property (nonatomic, readonly, getter=isValid) BOOL valid;

- (BUYAccountCredentialItem *)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(BUYAccountCredentialItem *)obj forKeyedSubscript:(NSString *)key;

@end


/**
 *  Represents a key and KVC-validatable value
 */

@interface BUYAccountCredentialItem : NSObject

+ (instancetype)itemWithKey:(NSString *)key value:(NSString *)value;

@property (nonatomic, getter=isValid) BOOL valid;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

NS_ASSUME_NONNULL_END

@end

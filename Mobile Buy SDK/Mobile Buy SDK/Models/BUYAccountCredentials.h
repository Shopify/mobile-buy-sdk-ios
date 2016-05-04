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
NS_ASSUME_NONNULL_BEGIN

extern NSString * const BUYAccountFirstNameKey;
extern NSString * const BUYAccountLastNameKey;
extern NSString * const BUYAccountEmailKey;
extern NSString * const BUYAccountPasswordKey;
extern NSString * const BUYAccountPasswordConfirmationKey;

@class BUYAccountCredentialItem;

/**
 * Encapsulates user's credentials represented by BUYAccountCredentialItem
 * objects.
 */
@interface BUYAccountCredentials : NSObject

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign, readonly, getter=isValid) BOOL valid;
@property (nonatomic, strong, readonly) NSDictionary *JSONRepresentation;

+ (BUYAccountCredentials *)credentials;
+ (BUYAccountCredentials *)credentialsWithItems:(nullable NSArray<BUYAccountCredentialItem *> *)items;
- (instancetype)initWithItems:(nullable NSArray<BUYAccountCredentialItem *> *)items;

- (void)setCredentialItems:(NSArray<BUYAccountCredentialItem *> *)items;
- (void)setCredentialItem:(BUYAccountCredentialItem *)item;

@end


/**
 * Represents a single for user's credentials such as 
 * email or password.
 */
@interface BUYAccountCredentialItem : NSObject

@property (nonatomic, assign, readonly, getter=isValid) BOOL valid;
@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, strong, readonly) NSString *value;

+ (instancetype)itemEmailWithValue:(NSString *)value;
+ (instancetype)itemFirstNameWithValue:(NSString *)value;
+ (instancetype)itemLastNameWithValue:(NSString *)value;
+ (instancetype)itemPasswordWithValue:(NSString *)value;
+ (instancetype)itemPasswordConfirmationWithValue:(NSString *)value;

+ (instancetype)itemWithKey:(NSString *)key value:(NSString *)value;
- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
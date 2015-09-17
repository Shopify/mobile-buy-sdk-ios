//
//  BUYObject.h
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

/**
 *  This is the base class for all Shopify model objects.
 *  This class takes care of convertion .json responses into
 *  the associated subclass.
 *
 *  You will generally not need to interact with this class directly.
 */
@interface BUYObject : NSObject

/**
 *  The identifier of any Shopify model object.
 */
@property (nonatomic, strong, readonly) NSNumber *identifier;

@property (nonatomic, readonly, getter=isDirty) BOOL dirty;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)updateWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)convertJSONArray:(NSArray *)json block:(void (^)(id obj))createdBlock;
+ (NSArray *)convertJSONArray:(NSArray *)json;

+ (instancetype)convertObject:(id)object;

#pragma mark - Dirty Property Tracking

- (NSSet *)dirtyProperties;
- (void)markPropertyAsDirty:(NSString *)property;
- (void)markAsClean;
+ (void)trackDirtyProperties;

@end

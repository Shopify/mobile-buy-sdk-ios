//
//  BUYModelManager.h
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
#import <Buy/BUYObject.h>
#import <Buy/BUYModelManagerProtocol.h>
NS_ASSUME_NONNULL_BEGIN

/**
 * A basic implementation of the BUYModelManager interface that does no caching. New objects are created using alloc/init.
 * Provides empty implementations of all the caching methods.
 */
@interface BUYModelManager : NSObject<BUYModelManager>

/**
 * The managed object model describes all the model entities. See the Core Data documentation for more details.
 */
@property (nonatomic, strong, readonly) NSManagedObjectModel *model;

/**
 *
 *  @param model The Core Data managed object model for your given model. Should be the Buy model.
 *
 *  @return A new model manager object.
 */
- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel *)model NS_DESIGNATED_INITIALIZER;

/**
 * Convenience initializer. Instantiates a model using the -mergedModelFromBundles: method and the Buy.framework as the bundle.
 */
+ (instancetype)modelManager;

@end

NS_ASSUME_NONNULL_END

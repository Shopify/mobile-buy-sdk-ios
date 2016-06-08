//
//  BUYObjectProtocol.h
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
NS_ASSUME_NONNULL_BEGIN

@class NSEntityDescription;

@protocol BUYModelManager;

/**
 * The BUYObject protocol is adopted by the common superclasses of both persistent and transient model classes.
 *
 */
@protocol BUYObject <BUYSerializable>

@property (nonatomic, readonly, nullable, weak) id<BUYModelManager> modelManager;

/**
 * Transient model objects need an entity for introspection.
 */
@property (nonatomic, readonly, nullable, weak) NSEntityDescription *entity;

/**
 * A dictionary of @{ NSString : NSPropertyDescription } where the keys are property names.
 * By default, returns the same value defined on NSEntityDescription (from BUYAdditions).
 */
@property (nonatomic, readonly) NSDictionary *JSONEncodedProperties;

/**
 * Convenience static property overridden by auto-generated model files.
 */
+ (NSString *)entityName;

/**
 * A derived property used to generate or apply JSON data. Values are calculated, recursively, automatically.
 */
@property (nonatomic, strong) NSDictionary *JSONDictionary;

/**
 * A predicate composed of values from the JSON. For objects that do not have an "identifier"/"id" property.
 */
+ (nullable NSPredicate *)fetchPredicateWithJSON:(NSDictionary *)JSONDictionary;

/**
 * Persistent classes return YES; transient classes return NO.
 */
+ (BOOL)isPersistentClass;

/**
 * Conforming classes should override to specify whether to use dirty tracking to restrict generated JSON to only changed values.
 */
+ (BOOL)tracksDirtyProperties;

@optional

- (instancetype)initWithModelManager:(id<BUYModelManager>)modelManager JSONDictionary:(nullable NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

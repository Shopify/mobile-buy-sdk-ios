//
//  NSEntityDescription+BUYAdditions.h
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

#import <CoreData/CoreData.h>

@protocol BUYObject;

@interface NSEntityDescription (BUYAdditions)

/**
 * A dictionary of @{ NSString : NSPropertyDescription } where the keys are property names.
 * By default, returns all attributes (instances of NSAttributeDescription) and relationships (NSRelationshipDescription).
 */
@property (nonatomic, readonly, getter=buy_JSONEncodedProperties) NSDictionary *JSONEncodedProperties;

/**
 * Returns the custom subclass used for instances of this entity.
 */
@property (nonatomic, readonly, getter=buy_managedObjectClass) Class managedObjectClass;

/**
 * Signifies whether this entity is private to the app (not used by the endpoint).
 */
- (BOOL)buy_isPrivate;

/**
 * Generate JSON, recursively, from the provided model object.
 */
- (NSDictionary *)buy_JSONForObject:(id<BUYObject>)object;

/**
 * Generate JSON, recursively, for each model in the provided array.
 */
- (NSArray *)buy_JSONForArray:(NSArray<NSObject<BUYObject> *> *)array;

/**
 * Update the properties of the given model object, and child objects, using the given JSON dictionary.
 */
- (void)buy_updateObject:(id<BUYObject>)object withJSON:(NSDictionary *)JSON;

/**
 *  Convenience to access JSONPropertyKey for the "identifier" attribute
 */
@property (strong, nonatomic, readonly) NSString *JSONIdentifierKey;

@end

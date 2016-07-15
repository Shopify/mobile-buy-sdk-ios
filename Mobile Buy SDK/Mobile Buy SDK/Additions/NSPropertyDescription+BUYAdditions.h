//
//  NSPropertyDescription+BUYAdditions.h
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

@class BUYModelManager;
@protocol BUYObject;

// property user info keys
extern NSString * const BUYJSONValueTransformerUserInfoKey; // = @"JSONValueTransformer";
extern NSString * const BUYJSONPropertyKeyUserInfoKey;      // = @"JSONPropertyKey";

@interface NSPropertyDescription (BUYAdditions)

/**
 * The name of a value transformer used to convert to JSON values and back.
 * Uses the value specified in the property's user info dictionary under the "JSONValueTransformer" key.
 *
 * Currently, only attributes (instances of NSAttributeDescription) use value transformers.
 */
@property (nonatomic, readonly, getter=buy_JSONValueTransformerName) NSString *JSONValueTransformerName;

/**
 * The value transformer corresponding to the JSONValueTransformerName. If no name is specified,
 * the value is not changed.
 */
@property (nonatomic, readonly, getter=buy_JSONValueTransformer) NSValueTransformer *JSONValueTransformer;

/**
 * The name of the key to use for the property, instead of its name, when generating JSON. Requires
 * adding an entry in the Property userInfo, in the Core Data model file, with the key "JSONPropertyKey".
 */
@property (nonatomic, readonly, getter=buy_JSONPropertyKey) NSString *JSONPropertyKey;

/**
 * Convert the provided JSON into the appropriate data type, either simple values or model objects.
 * For relationships, uses the destinationEntity to recursively fetch or create related objects as needed.
 */
- (id)buy_valueForJSON:(id)JSON object:(id<BUYObject>)object;

/**
 * Convert the provided object, a value corresponding to the property on the parent object.
 *
 * For relationships, related object data is generated according to the following rules:
 * - if the "JSONPropertyKey" is set in the user info dictionary, and it ends in "_id" (or "_ids")
 *   then encode the related object(s) using only their identifier(s)
 * - if the inverse relationship delete rule is "Cascade", or its entity is marked private,
 *   or the relationship is many-to-many, do not encode the object for this relationship
 *   (it is inferred that the related object owns this object; this avoids a loop in the encoding)
 * - otherwise, encode the full JSON representation of the related object(s)
 */
- (id)buy_JSONForValue:(id)value;

@end

@interface NSRelationshipDescription (BUYAdditions)

/**
 * Used during JSON transformation. If the value is YES, parsed JSON is expected to be a number
 * representing an object identifier, which will be resolved by fetching from the persistent store.
 * Likewise, generated JSON will include identifiers in place of full objects.
 */
@property (nonatomic, readonly, getter=buy_encodesIdInJSON) BOOL encodesIdInJSON;

/**
 * YES if the delete rule is not Cascading and the entity is not private.
 */
@property (nonatomic, readonly, getter=buy_allowsInverseEncoding) BOOL allowsInverseEncoding;

/**
 * YES if this relationship and its inverse are both toMany
 */
@property (nonatomic, readonly, getter=buy_isManyToMany) BOOL manyToMany;

@end

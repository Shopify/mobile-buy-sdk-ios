//
//  BUYModelManagerProtocol.h
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
NS_ASSUME_NONNULL_BEGIN

@protocol BUYObject;

/**
 * A protocol for defining an object that can store and retrieve model objects from a data store or other cache.
 */
@protocol BUYModelManager <NSObject>

/**
 *  Returns an entity given its name.
 *
 *  @param entityName Name of the entity from the Core Data managed object model.
 *
 *  @return The entity description matching the name.
 */
- (NSEntityDescription *)buy_entityWithName:(NSString *)entityName;

/**
 * If the JSON contains a key representing the unique identifier, and there is an existing cached object that matches that identifier,
 * then that object will be updated with the remaining entries in the JSON. If no such object exists, a new object is created, and
 * sent -updateWithJSON:.
 *
 *  @param entityName Name of the entity from the Core Data managed object model.
 *  @param JSON       The JSON representing the object.
 *
 *  @return A new or existing model object.
 */
- (id<BUYObject>)buy_objectWithEntityName:(NSString *)entityName JSONDictionary:(nullable NSDictionary *)JSON;
- (NSArray<id<BUYObject>> *)buy_objectsWithEntityName:(NSString *)entityName JSONArray:(NSArray *)JSON;

/**
 * Cache-based model managers may resolve objects based on their identifier. The alternative is to return nil.
 * Only supported by models whose entity declares an "identifier" attribute.
 *
 *  @param entityName Name of the entity from the Core Data managed object model.
 *  @param identifier A shopify object identifier of an existing object in the local data cache.
 *
 *  @return An object from the cache matching the provided identifier, or nil if no matching object is found.
 */
- (nullable id<BUYObject>)buy_objectWithEntityName:(NSString *)entityName identifier:(NSNumber *)identifier;

/**
 *  Find all the objects in the cache matching the provided identifiers.
 *
 *  @param entityName  Name of the entity from the Core Data managed object model.
 *  @param identifiers An array of Shopify object identifiers.
 *
 *  @return An array of objects from the cache matching the provided identifiers, if any.
 */
- (NSArray<id<BUYObject>> *)buy_objectsWithEntityName:(NSString *)entityName identifiers:(nullable NSArray *)identifiers;

/**
 * If there is a local cache available, and the object is cached, it is flushed from the cache. Depending on the type of
 * caching in use (if any), the provided object may no longer be valid, and references should be reset. If the cache
 * supports stand-alone objects, and the object is modified or passed into the SDK, it could be re-inserted into the cache.
 *
 * If Core Data is used for local caching, purging is equivalent to deletion. (see -deleteObject[WithIdentifier]:error:)
 *
 * If the object is not in the cache (or there is no cache), does nothing.
 *
 *  @param object An existing model object.
 *  @param error  A pointer to an error. May be NULL.
 *
 *  @return YES if the object was successfully removed from the cache. NO if there was an error.
 */
- (BOOL)buy_purgeObject:(id<BUYObject>)object error:(NSError **)error;

/**
 * Update the cached version of the object given the current state of the object.
 *
 *  @param object An existing model object.
 */
- (void)buy_refreshCacheForObject:(id<BUYObject>)object;

/**
 *
 *  @param entityName Name of the entity from the Core Data managed object model.
 *  @param predicate  An NSPredicate that identifies objects that should be deleted from the cache.
 *
 *  @return YES if the purge was successful. NO if there was a problem.
 */
- (BOOL)buy_purgeObjectsWithEntityName:(NSString *)entityName matchingPredicate:(nullable NSPredicate *)predicate;

@end

NS_ASSUME_NONNULL_END

//
//  BUYCollection.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

/**
 *  Represents a collection of products on the shop
 */
@interface BUYCollection : BUYObject

/**
 *  The title of the collection
 */
@property (nonatomic, strong, readonly) NSString *title;

/**
 *  The unique collection ID
 */
@property (nonatomic, strong, readonly) NSNumber *collectionId;

/**
 *  The html description
 */
@property (nonatomic, strong, readonly) NSString *htmlDescription;

/**
 *  The collection's image URL
 */
@property (nonatomic, strong, readonly) NSURL *imageURL;

/**
 *  The handle of the collection
 */
@property (nonatomic, strong, readonly) NSString *handle;

/**
 *  The state of whether the collection is currently published or not
 */
@property (nonatomic, assign, readonly) BOOL published;

/**
 *  The creation date for the collection
 */
@property (nonatomic, readonly, copy) NSDate *createdAtDate;

/**
 *  The updated date for the collection
 */
@property (nonatomic, readonly, copy) NSDate *updatedAtDate;

/**
 *  The publish date for the collection
 */
@property (nonatomic, readonly, copy) NSDate *publishedAtDate;

@end

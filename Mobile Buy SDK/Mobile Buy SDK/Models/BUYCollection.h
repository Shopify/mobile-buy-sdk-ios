//
//  BUYCollection.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

typedef NS_ENUM(NSUInteger, BUYCollectionSort) {
	BUYCollectionSortCollectionDefault,
	BUYCollectionSortBestSelling,
	BUYCollectionSortTitleAscending,
	BUYCollectionSortTitleDescending,
	BUYCollectionSortPriceAscending,
	BUYCollectionSortPriceDescending,
	BUYCollectionSortCreatedAscending,
	BUYCollectionSortCreatedDescending,
};

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
 *  The handle of the collection
 */
@property (nonatomic, strong, readonly) NSString *handle;

/**
 *  The state of whether the collection is currently published or not
 */
@property (nonatomic, assign, readonly) BOOL published;

@end

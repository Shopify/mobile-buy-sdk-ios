//
//  BUYAllPagesOperation.h
//  Mobile Buy SDK
//
//  Created by Brent Gulanowski on 2016-09-02.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "BUYOperation.h"

@class BUYClient;

typedef void (^BUYFetchPageCompletion) (NSArray *results, NSUInteger page, BOOL reachedEnd, NSError *error);
typedef NSOperation *(^BUYFetchPageBlock) (NSUInteger page, BUYFetchPageCompletion completion);
typedef void (^BUYAllPagesCompletion) (id results, NSError *error);

@interface BUYAllPagesOperation : BUYOperation

@property (nonatomic, strong, readonly) NSMutableArray *cumulativeResults;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, readonly) NSUInteger currentPage;

- (instancetype)initWithClient:(BUYClient *)client block:(BUYFetchPageBlock)block completion:(BUYAllPagesCompletion)completion;

+ (instancetype)fetchAllCollectionsWithClient:(BUYClient *)client completion:(BUYAllPagesCompletion)completion;
+ (instancetype)fetchAllProductsWithClient:(BUYClient *)client completion:(BUYAllPagesCompletion)completion;
+ (instancetype)fetchAllProductsWithClient:(BUYClient *)client collectionId:(NSNumber *)collectionId completion:(BUYAllPagesCompletion)completion;
+ (instancetype)fetchAllTagsWithClient:(BUYClient *)client completion:(BUYAllPagesCompletion)completion;

@end

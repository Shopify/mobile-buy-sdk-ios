//
//  BUYAllPagesOperation.m
//  Mobile Buy SDK
//
//  Created by Brent Gulanowski on 2016-09-02.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYAllPagesOperation.h"
#import "BUYClient.h"
#import "BUYClient+Internal.h"
#import "BUYClient+Storefront.h"

@interface BUYAllPagesOperation () {
	BUYFetchPageBlock _fetchBlock;
	BUYAllPagesCompletion _completion;
}

@property (nonatomic, strong, readonly) BUYClient *client;
@property (nonatomic, strong) NSOperation *currentOperation;
@property (nonatomic, strong) NSMutableArray *cumulativeResults;
@property (nonatomic, strong) NSError *error;
@property (nonatomic) NSUInteger currentPage;

@end

@implementation BUYAllPagesOperation

- (instancetype)initWithClient:(BUYClient *)client block:(BUYFetchPageBlock)block completion:(BUYAllPagesCompletion)completion
{
	self = [super init];
	if (self) {
		_client = client;
		_fetchBlock = [block copy];
		_completion = [completion copy];
		_cumulativeResults = [NSMutableArray array];
	}
	return self;
}

- (void)startExecution
{
	self.currentPage = 1;
	self.currentOperation = [self operationForPage:1];
	[super startExecution];
}

- (NSOperation *)operationForPage:(NSUInteger)page
{
	if (self.cancelled) {
		return nil;
	}
	__weak typeof (self) welf = self;
	return _fetchBlock(page, ^(NSArray *results, NSUInteger page, BOOL reachedEnd, NSError *error) {
		if (error) {
			welf.error = error;
		}
		else {
			if (results.count > 0) {
				[welf.cumulativeResults addObjectsFromArray:results];
			}
			if (reachedEnd) {
				welf.currentOperation = nil;
				[welf finishExecution];
			}
			else {
				self.currentPage = page + 1;
				self.currentOperation = [welf operationForPage:page + 1];
			}
		}
	});
}

- (void)cancelExecution
{
	[self.currentOperation cancel];
	[super cancelExecution];
}

- (void)finishExecution
{
	if (!self.cancelled && _completion != nil) {
		_completion([self.cumulativeResults copy], self.error);
	}
	[super finishExecution];
}

#pragma mark -

+ (instancetype)fetchAllCollectionsWithClient:(BUYClient *)client completion:(BUYAllPagesCompletion)completion
{
	return [[BUYAllPagesOperation alloc] initWithClient:client block:^(NSUInteger page, BUYFetchPageCompletion pageCompletion) {
		return [client getCollectionsPage:page completion:(BUYDataCollectionsListBlock)completion];
	} completion:completion];
}

+ (instancetype)fetchAllProductsWithClient:(BUYClient *)client completion:(BUYAllPagesCompletion)completion
{
	return [[BUYAllPagesOperation alloc] initWithClient:client block:^(NSUInteger page, BUYFetchPageCompletion completion) {
		return [client getProductsPage:page completion:(BUYDataProductListBlock)completion];
	} completion:completion];
}

+ (instancetype)fetchAllTagsWithClient:(BUYClient *)client completion:(BUYAllPagesCompletion)completion
{
	return [[BUYAllPagesOperation alloc] initWithClient:client block:^(NSUInteger page, BUYFetchPageCompletion completion) {
		return [client getProductTagsPage:page completion:(BUYDataTagsListBlock)completion];
	} completion:completion];
}

@end

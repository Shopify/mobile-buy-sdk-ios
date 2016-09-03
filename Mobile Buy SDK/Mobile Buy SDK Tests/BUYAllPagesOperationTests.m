//
//  BUYAllPagesOperationTests.m
//  Mobile Buy SDK
//
//  Created by Brent Gulanowski on 2016-09-02.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

@import XCTest;

#import "BUYAllPagesOperation.h"
#import "BUYClientTestBase.h"
#import "BUYObserver.h"

@interface BUYAllPagesOperationTests : BUYClientTestBase

@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation BUYAllPagesOperationTests

- (void)setUp
{
	[super setUp];
	self.queue = [NSOperationQueue new];
}

- (void)tearDown
{
	self.queue = nil;
	[super tearDown];
}

- (void)testGetAllTags
{
	self.client.pageSize = 2;
	XCTestExpectation *expectation = [self expectationWithDescription:CmdString()];
	[self.queue addOperation:[BUYAllPagesOperation fetchAllTagsWithClient:self.client completion:^(NSArray *results, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(results);
		XCTAssertGreaterThan(results.count, 0);
		[expectation fulfill];
	}]];
	[self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testGetAllTagsAndCancel
{
	self.client.pageSize = 2;
	BUYAllPagesOperation *operation = [BUYAllPagesOperation fetchAllTagsWithClient:self.client completion:^(NSArray *results, NSError *error) {
		XCTFail();
	}];
	XCTestExpectation *expectation = [self expectationWithDescription:CmdString()];
	BUYObserver *observer = [BUYObserver observeProperties:@[@"currentPage", @"cancelled"] ofObject:operation];
	observer.changeBlock = ^(BUYObserver *observer, NSString *property) {
		if (operation.currentPage == 2) {
			[operation cancel];
			[observer cancel];
			[expectation fulfill];
		}
	};
	[self.queue addOperation:operation];
	[self waitForExpectationsWithTimeout:5.0 handler:nil];
	XCTAssertTrue(operation.cancelled);
	NSOperation *pageOp = (NSOperation *)[operation valueForKey:@"currentOperation"];
	XCTAssertNil(pageOp);
}

@end

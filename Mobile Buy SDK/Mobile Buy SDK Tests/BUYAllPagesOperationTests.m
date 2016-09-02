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

- (void)testOne
{
	XCTestExpectation *expectation = [self expectationWithDescription:@"hello"];
	[self.queue addOperation:[BUYAllPagesOperation fetchAllTagsWithClient:self.client completion:^(NSArray *results, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(results);
		XCTAssertGreaterThan(results.count, 0);
		[expectation fulfill];
	}]];
	[self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end

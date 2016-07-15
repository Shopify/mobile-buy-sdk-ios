//
//  BUYOperationTests.m
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

#import <XCTest/XCTest.h>
#import "BUYOperation.h"

@interface BUYOperationTests : XCTestCase

@end

@implementation BUYOperationTests

#pragma mark - Init -

- (void)testInit
{
	BUYOperation *operation = [[BUYOperation alloc] init];
	XCTAssertNotNil(operation);
}

#pragma mark - State -

- (void)testNormalExecutionFlow
{
	BUYOperation *operation = [[BUYOperation alloc] init];
	XCTAssertTrue(operation.isReady);
	
	[operation start];
	XCTAssertTrue(operation.executing);
	
	[operation finishExecution];
	XCTAssertTrue(operation.isFinished);
	XCTAssertFalse(operation.cancelled);
}

- (void)testCancelledExecutionFlow
{
	BUYOperation *operation = [[BUYOperation alloc] init];
	XCTAssertTrue(operation.isReady);
	
	[operation start];
	XCTAssertTrue(operation.executing);
	
	[operation cancel];
	XCTAssertTrue(operation.cancelled);
	XCTAssertFalse(operation.isFinished);
	
	[operation cancelExecution];
	XCTAssertFalse(operation.isFinished); // State isn't changed if operation is cancelled
}

@end

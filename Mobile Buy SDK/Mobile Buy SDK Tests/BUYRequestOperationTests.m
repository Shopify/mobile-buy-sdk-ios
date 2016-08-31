//
//  BUYRequestOperationTests.m
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

@import XCTest;
@import Buy;

#import "BUYRequestOperation.h"

#import <OHHTTPStubs/OHHTTPStubs.h>

@interface BUYRequestOperationTests : XCTestCase

@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSMutableURLRequest *request;

@end

@implementation BUYRequestOperationTests

#pragma mark - Setup -

- (void)setUp
{
    [super setUp];
	
	self.request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.shopify.com"]];
	self.queue   = [NSOperationQueue new];
	self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:self.queue];
}

- (void)tearDown
{
	[super tearDown];
	
	self.request = nil;
	self.queue = nil;
	self.session = nil;
}

#pragma mark - Tests -

- (void)testInit
{
	BUYRequestOperation *operation = [BUYRequestOperation operationWithSession:self.session request:self.request payload:nil completion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		// We don't start the session
	}];
									  
	XCTAssertNotNil(operation);
	XCTAssertEqualObjects(operation.session, self.session);
	XCTAssertEqualObjects(operation.originalRequest, self.request);
}

#pragma mark - No Queue Tests -

- (void)testOperationWithoutQueue
{
	[self stubRequests];
	
	XCTestExpectation *expectation = [self expectationWithDescription:@"Expect successful operation"];
	BUYRequestOperation *operation = [self operationFulfillingExpectation:expectation completion:nil];
	
	[operation start];
	
	[self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error) {}];
}

#pragma mark - Data Tests -

- (void)testSuccessfulRequest
{
	NSDictionary *payload = @{
							  @"name"           : @"Water",
							  @"type"           : @"liquid",
							  @"melting_point"  : @0.0,
							  };
	
	NSData *payloadData           = [NSJSONSerialization dataWithJSONObject:payload options:0 error:nil];
	OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:payloadData statusCode:BUYStatusComplete headers:nil];
	
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
		return YES;
	} withStubResponse:^OHHTTPStubsResponse * (NSURLRequest *request) {
		return response;
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:@"Expect successful operation"];
	BUYRequestOperation *operation = [self operationFulfillingExpectation:expectation responseCompletion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		XCTAssertNotNil(json);
		XCTAssertNotNil(response);
		XCTAssertNil(error);
		
		XCTAssertEqualObjects(json, payload);
		XCTAssertEqual(response.statusCode, BUYStatusComplete);
	}];
	
	[self.queue addOperation:operation];
	[self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error) {}];
}

- (void)testFailedRequest
{
	NSDictionary *errorPayload = @{
								   @"error" : @{
										   @"reason" : @"Invalid length of name",
										   @"field"  : @"username",
										   },
								   };
	
	NSData *payloadData           = [NSJSONSerialization dataWithJSONObject:errorPayload options:0 error:nil];
	OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:payloadData statusCode:BUYStatusFailed headers:nil];
	
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
		return YES;
	} withStubResponse:^OHHTTPStubsResponse * (NSURLRequest *request) {
		return response;
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:@"Expect failed operation"];
	BUYRequestOperation *operation = [self operationFulfillingExpectation:expectation responseCompletion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		XCTAssertNil(json);
		XCTAssertNotNil(response);
		XCTAssertNotNil(error);
		
		XCTAssertEqualObjects(error.userInfo, errorPayload);
		XCTAssertEqual(response.statusCode, BUYStatusFailed);
	}];
	
	[self.queue addOperation:operation];
	[self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error) {}];
}

#pragma mark - Dependency Tests -

- (void)testSerialSuccessfulDependencies
{
	[self stubRequests];
	
	__block NSMutableString *container = [@"" mutableCopy];
	
	XCTestExpectation *expectation1 = [self expectationWithDescription:@"Expect operation 1"];
	BUYRequestOperation *operation1 = [self operationFulfillingExpectation:expectation1 completion:^{
		[container appendString:@"1"];
	}];
	
	XCTestExpectation *expectation2 = [self expectationWithDescription:@"Expect operation 2"];
	BUYRequestOperation *operation2 = [self operationFulfillingExpectation:expectation2 completion:^{
		[container appendString:@"2"];
	}];
	
	[operation2 addDependency:operation1];
	[self.queue addOperation:operation2];
	[self.queue addOperation:operation1];
	
	[self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {}];
	XCTAssertEqualObjects(container, @"12");
}

- (void)testParallelSuccessfulDependencies
{
	[self stubRequests];
	
	__block NSMutableString *container = [@"" mutableCopy];
	
	XCTestExpectation *expectation1 = [self expectationWithDescription:@"Expect operation 1"];
	BUYRequestOperation *operation1 = [self operationFulfillingExpectation:expectation1 completion:^{
		[container appendString:@"1"];
	}];
	
	XCTestExpectation *expectation2 = [self expectationWithDescription:@"Expect operation 2"];
	BUYRequestOperation *operation2 = [self operationFulfillingExpectation:expectation2 completion:^{
		[container appendString:@"1"];
	}];
	
	XCTestExpectation *expectation3 = [self expectationWithDescription:@"Expect operation 3"];
	BUYRequestOperation *operation3 = [self operationFulfillingExpectation:expectation3 completion:^{
		[container appendString:@"3"];
	}];
	
	XCTestExpectation *expectation4 = [self expectationWithDescription:@"Expect operation 4"];
	BUYRequestOperation *operation4 = [self operationFulfillingExpectation:expectation4 completion:^{
		[container appendString:@"4"];
	}];
	
	[operation4 addDependency:operation3];
	[operation3 addDependency:operation1];
	[operation3 addDependency:operation2];
	
	[self.queue addOperation:operation4];
	[self.queue addOperation:operation3];
	[self.queue addOperation:operation2];
	[self.queue addOperation:operation1];
	
	[self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {}];
	XCTAssertEqualObjects(container, @"1134");
}

- (void)testPollingActivatedWithHandler
{
	[self stubRequestsWithDelay:0.1 status:BUYStatusProcessing];
	
	XCTestExpectation *completion  = [self expectationWithDescription:@"Should complete after polling"];
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		[completion fulfill];
	}];
	
	__block int pollCount = 0;
	
	XCTestExpectation *expectation = [self expectationWithDescription:@"Should stop polling at 2 iterations"];
	operation.pollingHandler = ^BOOL (NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		[self stubRequestsWithDelay:0.1 status:BUYStatusProcessing];
		
		XCTAssertNotNil(json);
		XCTAssertNotNil(response);
		XCTAssertNil(error);
		
		if (response.statusCode == BUYStatusComplete) {
			[expectation fulfill];
		}
		
		if (response.statusCode == BUYStatusProcessing) {
			pollCount += 1;
			if (pollCount == 2) {
				[self stubRequestsWithDelay:0.1 status:BUYStatusComplete];
			}
			return YES;
		}
		return NO;
	};
	
	[self.queue addOperation:operation];
	[self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {}];
}

- (void)testCancellationBeforeExecution
{
	[self stubRequests];
	
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		XCTAssert(NO, @"Operation should not call completion if cancelled.");
	}];
	
	[self createExpectationDelay];
	
	[self.queue addOperation:operation];
	[operation cancel];
	
	[self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error) {}];
}

- (void)testCancellationDuringExecution
{
	[self stubRequestsWithDelay:0.01];
	
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		XCTAssert(NO, @"Operation should not call completion if cancelled.");
	}];
	
	[self.queue addOperation:operation];
	XCTestExpectation *expectation = [self expectationWithDescription:@"Should stop polling at 2 iterations"];
	[self after:0.001 block:^{
		XCTAssertFalse(operation.finished);
		XCTAssertFalse(operation.cancelled);
		[operation cancel];
		[expectation fulfill];
		XCTAssertTrue(operation.cancelled);
	}];
	
	[self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {}];
}

- (void)testCancellationWithoutQueue
{
	[self stubRequestsWithDelay:0.5];
	
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		XCTAssert(NO, @"Operation should not call completion if cancelled.");
	}];
	
	[operation start];
	[operation cancel];
	
	[self createExpectationDelay];
	[self waitForExpectationsWithTimeout:4.0 handler:^(NSError *error) {}];
}

- (void)testCancellationDuringPolling
{
	[self stubRequestsWithDelay:0.1 status:BUYStatusProcessing];
	
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		XCTAssert(NO, @"Operation should not call completion if cancelled.");
	}];
	
	__block int pollCount = 0;
	
	__weak BUYRequestOperation *weakOp = operation;
	
	operation.pollingHandler = ^BOOL (NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		pollCount += 1;
		if (pollCount == 3) {
			[weakOp cancel];
		}
		return YES;
	};
	
	[self.queue addOperation:operation];
	
	[self createExpectationDelay:1.0 block:YES];
	
	XCTAssertTrue(pollCount < 5);
	XCTAssertTrue(operation.cancelled);
}

#pragma mark - Convenience -

- (void)asyncMain:(dispatch_block_t)block
{
	dispatch_async(dispatch_get_main_queue(), block);
}

- (void)after:(NSTimeInterval)delay block:(dispatch_block_t)block
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

- (void)createExpectationDelay
{
	[self createExpectationDelay:1.0];
}
	 
 - (void)createExpectationDelay:(NSTimeInterval)delay
 {
	[self createExpectationDelay:delay block:NO];
 }

 - (void)createExpectationDelay:(NSTimeInterval)delay block:(BOOL)block
{
	XCTestExpectation *expectation = [self expectationWithDescription:@"Delay"];
	[self after:delay block:^{
		[expectation fulfill];
	}];
	
	if (block) {
		[self waitForExpectationsWithTimeout:delay + 0.1 handler:^(NSError *error) {}];
	}
}

- (BUYRequestOperation *)operationFulfillingExpectation:(XCTestExpectation *)expectation completion:(dispatch_block_t)completion
{
	return [self operationFulfillingExpectation:expectation responseCompletion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (completion) {
			completion();
		}
	}];
}

- (BUYRequestOperation *)operationFulfillingExpectation:(XCTestExpectation *)expectation responseCompletion:(void(^)(NSDictionary *json, NSHTTPURLResponse *response, NSError *error))completion
{
	BUYRequestOperation *operation = [BUYRequestOperation operationWithSession:self.session request:self.request payload:nil completion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		[self asyncMain:^{
			if (completion) {
				completion(json, (id)response, error);
			}
			[expectation fulfill];
		}];
	}];
	
	return operation;
}

#pragma mark - Stubs -

- (void)stubRequests
{
	[self stubRequestsWithDelay:0.0];
}

- (void)stubRequestsWithDelay:(NSTimeInterval)delay
{
	[self stubRequestsWithDelay:delay status:BUYStatusProcessing];
}

- (void)stubRequestsWithDelay:(NSTimeInterval)delay status:(int)status
{
	NSDictionary *payload = @{
							  @"first_name" : @"John",
							  @"last_name"  : @"Smith",
							  };
	
	NSData *payloadData           = [NSJSONSerialization dataWithJSONObject:payload options:0 error:nil];
	OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:payloadData statusCode:status headers:nil];
	response.requestTime          = delay;
	
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
		return YES;
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest *request) {
		return response;
	}];
}

@end

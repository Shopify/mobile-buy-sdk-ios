//
//  BUYRequestOperationTests.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-16.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "BUYRequestOperation.h"
#import "BUYClient.h"

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
	
	self.request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]];
	self.queue   = [NSOperationQueue new];
	self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:self.queue];
}

#pragma mark - Tests -

- (void)testInit
{
	BUYRequestOperation *operation = [BUYRequestOperation operationWithSession:self.session request:self.request payload:nil completion:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
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
	
	[self waitForExpectationsWithTimeout:3.0 handler:nil];
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
	[self waitForExpectationsWithTimeout:3.0 handler:nil];
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
	[self waitForExpectationsWithTimeout:3.0 handler:nil];
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
	
	[self waitForExpectationsWithTimeout:10.0 handler:nil];
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
	
	[self waitForExpectationsWithTimeout:10.0 handler:nil];
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
	
	XCTestExpectation *expectation = [self expectationWithDescription:@"Should stop polling at 10 iterations"];
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
			if (pollCount == 10) {
				[self stubRequestsWithDelay:0.1 status:BUYStatusComplete];
			}
			return YES;
		}
		return NO;
	};
	
	[self.queue addOperation:operation];
	[self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testCancellationBeforeExecution
{
	[self stubRequests];
	
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		XCTAssert(NO, @"Operation should not call completion if cancelled.");
	}];
	
	[self createExpectationDelay];
	
	[operation cancel];
	[self.queue addOperation:operation];
	
	[self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)testCancellationDuringExecution
{
	[self stubRequestsWithDelay:2.0];
	
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		XCTAssert(NO, @"Operation should not call completion if cancelled.");
	}];
	
	[self createExpectationDelay:3.0];
	[self.queue addOperation:operation];
	[self after:1.0 block:^{
		[operation cancel];
	}];
	
	[self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testCancellationDuringPolling
{
	[self stubRequestsWithDelay:0.1 status:BUYStatusProcessing];
	
	BUYRequestOperation *operation = [self operationFulfillingExpectation:nil completion:^{
		XCTAssert(NO, @"Operation should not call completion if cancelled.");
	}];
	
	__block int pollCount = 0;
	
	operation.pollingHandler = ^BOOL (NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		pollCount += 1;
		return YES;
	};
	
	[self.queue addOperation:operation];
	
	[self after:0.5 block:^{
		[operation cancel];
	}];
	
	[self createExpectationDelay:1.0 block:YES];
	
	XCTAssertTrue(pollCount < 5);
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
		[self waitForExpectationsWithTimeout:delay + 0.1 handler:nil];
	}
}

- (BUYRequestOperation *)operationFulfillingExpectation:(XCTestExpectation *)expectation completion:(dispatch_block_t)completion
{
	return [self operationFulfillingExpectation:expectation responseCompletion:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (completion) {
			completion();
		}
	}];
}

- (BUYRequestOperation *)operationFulfillingExpectation:(XCTestExpectation *)expectation responseCompletion:(void(^)(NSDictionary *json, NSHTTPURLResponse *response, NSError *error))completion
{
	BUYRequestOperation *operation = [BUYRequestOperation operationWithSession:self.session request:self.request payload:nil completion:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
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

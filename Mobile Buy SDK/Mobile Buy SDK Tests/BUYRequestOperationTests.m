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
	OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:payloadData statusCode:200 headers:nil];
	
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
		XCTAssertEqual(response.statusCode, 200);
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
	XCTestExpectation *expectation = [self expectationWithDescription:@"Delay"];
	[self after:delay block:^{
		[expectation fulfill];
	}];
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
	NSDictionary *payload = @{
							  @"first_name" : @"John",
							  @"last_name"  : @"Smith",
							  };
	
	NSData *payloadData           = [NSJSONSerialization dataWithJSONObject:payload options:0 error:nil];
	OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithData:payloadData statusCode:200 headers:nil];
	response.requestTime          = delay;
	
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
		return YES;
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest *request) {
		return response;
	}];
}

@end

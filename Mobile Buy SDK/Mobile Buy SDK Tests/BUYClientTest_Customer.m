//
//  BUYClientTest_Customer.h
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
#import "BUYClientTestBase.h"
#import "BUYClient+Customers.h"
#import "BUYAccountCredentials.h"
#import "BUYError+BUYAdditions.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "OHHTTPStubsResponse+Helpers.h"

// Remove this macro entirely when test shop has customer api enabled
//#define CUSTOMER_API_AVAILABLE

@interface BUYClientTest_Customer : BUYClientTestBase
@end

@implementation BUYClientTest_Customer

#pragma mark - Tear Down -

- (void)tearDown
{
	[super tearDown];
	[OHHTTPStubs removeAllStubs];
}

#pragma mark - Creation -

- (void)testCustomerDuplicateEmail
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerDuplicateEmail"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCustomerWithCredentials:[self credentialsForCreation] callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
		XCTAssertNil(customer);
		XCTAssertNotNil(error);
		
		NSArray *errors = [BUYError errorsFromSignUpJSON:error.userInfo];
		XCTAssertEqual(errors.count, 1);
		
		BUYError *customerError = errors[0];
		
		XCTAssertEqualObjects(customerError.code, @"taken");
		XCTAssertEqualObjects(customerError.options[@"rescue_from_duplicate"], @YES);
		XCTAssertEqualObjects(customerError.options[@"value"], self.customerEmail);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
		XCTAssertNil(error);
	}];
}

- (void)testCustomerInvalidEmailPassword
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerInvalidEmailPassword"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCustomerWithCredentials:[self credentialsForFailure] callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
		XCTAssertNil(customer);
		XCTAssertNotNil(error);
		
		NSArray<BUYError *> *errors = [BUYError errorsFromSignUpJSON:error.userInfo];
		XCTAssertEqual(errors.count, 3);

		BUYError *emailError = errors[0];
		XCTAssertEqualObjects(emailError.code, @"invalid");
		
		BUYError *passwordConfError = errors[1];
		XCTAssertEqualObjects(passwordConfError.code, @"confirmation");
		XCTAssertEqualObjects(passwordConfError.options[@"attribute"], @"Password");
		
		BUYError *passwordError = errors[2];
		XCTAssertEqualObjects(passwordError.code, @"too_short");
		XCTAssertEqualObjects(passwordError.options[@"count"], @5);

		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
		XCTAssertNil(error);
	}];
}

#pragma mark - Auth -

- (void)testCustomerLogin
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerLogin"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client loginCustomerWithCredentials:[self credentialsForLogin] callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(customer);
		XCTAssertEqualObjects(customer.email, self.customerEmail);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
		XCTAssertNil(error);
	}];
}

- (void)testCustomerLogout
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerLogin"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client loginCustomerWithCredentials:[self credentialsForLogin] callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
		[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
			return [self shouldUseMocks];
		} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
			return [OHHTTPStubsResponse responseWithKey:@"testCustomerLogout"];
		}];
		
		[self.client logoutCustomerID:customer.identifier.stringValue callback:^(BUYStatus status, NSError * _Nullable error) {
			
			XCTAssertNil(error);
			XCTAssertEqual(status, BUYStatusComplete);
			
			[expectation fulfill];
		}];
	}];
	
	[self waitForExpectationsWithTimeout:10000 handler:nil];
}

#pragma mark - Update -

- (void)testCustomerUpdate
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerLogin"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	BUYAccountCredentialItem *email    = [BUYAccountCredentialItem itemWithEmail:self.customerEmail];
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:@[email]];
	
	[self.client loginCustomerWithCredentials:[self credentialsForLogin] callback:^(BUYCustomer * _Nullable customer, NSString * _Nullable token, NSError * _Nullable error) {
		
		[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
			return [self shouldUseMocks];
		} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
			return [OHHTTPStubsResponse responseWithKey:@"testCustomerLogin"];
		}];
		
		[self.client updateCustomerWithCredentials:credentials customerID:customer.identifier.stringValue callback:^(BUYCustomer *customer, NSError *error) {
			
			XCTAssertNil(error);
			XCTAssertNotNil(customer);
			XCTAssertEqualObjects(customer.email, self.customerEmail);
			
			[expectation fulfill];
		}];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

#pragma mark - Credentials -

- (BUYAccountCredentials *)credentialsForLogin
{
	BUYAccountCredentialItem *email    = [BUYAccountCredentialItem itemWithEmail:self.customerEmail];
	BUYAccountCredentialItem *password = [BUYAccountCredentialItem itemWithPassword:self.customerPassword];
	return [BUYAccountCredentials credentialsWithItems:@[email, password]];
}

- (BUYAccountCredentials *)credentialsForCreation
{
	BUYAccountCredentialItem *email     = [BUYAccountCredentialItem itemWithEmail:self.customerEmail];
	BUYAccountCredentialItem *password  = [BUYAccountCredentialItem itemWithPassword:self.customerPassword];
	BUYAccountCredentialItem *password2 = [BUYAccountCredentialItem itemWithPassword:self.customerPassword];
	return [BUYAccountCredentials credentialsWithItems:@[email, password, password2]];
}

- (BUYAccountCredentials *)credentialsForFailure
{
	BUYAccountCredentialItem *email     = [BUYAccountCredentialItem itemWithEmail:@"a"];
	BUYAccountCredentialItem *password  = [BUYAccountCredentialItem itemWithPassword:@"b"];
	BUYAccountCredentialItem *password2 = [BUYAccountCredentialItem itemWithPasswordConfirmation:@"c"];
	return [BUYAccountCredentials credentialsWithItems:@[email, password, password2]];
}

@end

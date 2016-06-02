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

@interface BUYClientTest_Customer : BUYClientTestBase

@property (strong, nonatomic) BUYCustomer *customer;
@property (strong, nonatomic) BUYAddress *createdAddress;

@end

@implementation BUYClientTest_Customer

#pragma mark - Lifecycle -

- (void)setUp
{
	[super setUp];
	[self loginDefaultCustomer];
}

- (void)tearDown
{
	[super tearDown];
	[OHHTTPStubs removeAllStubs];
}

- (void)loginDefaultCustomer
{
	if (self.customer) {
		return;
	}
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerLogin" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client loginCustomerWithCredentials:[self credentialsForLogin] callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(customer);
		XCTAssertEqualObjects(customer.email, self.customerEmail);
		
		self.customer = customer;
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
		XCTAssertNil(error);
	}];
}

#pragma mark - Creation -

- (void)testCustomerDuplicateEmail
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerDuplicateEmail" useMocks:[self shouldUseMocks]];
	
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
	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerInvalidEmailPassword" useMocks:[self shouldUseMocks]];
	
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
	[self loginDefaultCustomer];
}

- (void)testCustomerLogout
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerLogout" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client logoutCustomerID:self.customer.identifier.stringValue callback:^(BUYStatus status, NSError * _Nullable error) {
		
		XCTAssertNil(error);
		XCTAssertEqual(status, 204);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

#pragma mark - Orders -

- (void)testCustomerOrders
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerGetOrders" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getOrdersForCustomerWithID:self.customer.identifier.stringValue callback:^(NSArray<BUYOrder *> * _Nullable orders, NSError * _Nullable error) {
		
		XCTAssertNotNil(orders);
		XCTAssertNil(error);
		
		XCTAssertTrue(orders.count > 0);
		XCTAssertTrue([orders.firstObject isKindOfClass:[BUYOrder class]]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testCustomerOrderWithID
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerGetOrder" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getOrderWithID:self.customerOrderIDs.firstObject customerID:self.customer.identifier.stringValue callback:^(BUYOrder * _Nullable order, NSError * _Nullable error) {
		
		XCTAssertNil(error);
		XCTAssertTrue([order isKindOfClass:[BUYOrder class]]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10.0 handler:nil];
}

#pragma mark - Update -

- (void)testCustomerUpdate
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerLogin" useMocks:[self shouldUseMocks]];

	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	BUYAccountCredentialItem *email    = [BUYAccountCredentialItem itemWithEmail:self.customerEmail];
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:@[email]];
	
	[self.client updateCustomerWithCredentials:credentials customerID:self.customer.identifier.stringValue callback:^(BUYCustomer *customer, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(customer);
		XCTAssertEqualObjects(customer.email, self.customerEmail);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

#pragma mark - Address -

- (void)testGetAddresses
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddresses"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client  getAddressesForCustomerID:self.customer.identifier.stringValue callback:^(NSArray<BUYAddress *> * _Nullable addresses, NSError * _Nullable error) {
		
		XCTAssertNotNil(addresses);
		XCTAssertTrue(addresses.count > 0);
		XCTAssertTrue([addresses.firstObject isKindOfClass:[BUYAddress class]]);
		XCTAssertNil(error);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testAddressCRUD
{
	[self createAddress];
	[self getAddress];
	[self updateAddress];
	[self deleteAddress];
}

- (void)createAddress
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddress1"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	BUYAddress *address = [self address];
	
	[self.client createAddress:address customerID:self.customer.identifier.stringValue callback:^(BUYAddress * _Nullable returnedAddress, NSError * _Nullable error) {
		
		[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerLogin" useMocks:[self shouldUseMocks]];
		
		XCTAssertNotNil(returnedAddress);
		XCTAssertNil(error);
		
		XCTAssertNotNil(returnedAddress.identifier);
		
		XCTAssertEqualObjects(address.address1,     returnedAddress.address1);
		XCTAssertEqualObjects(address.city,         returnedAddress.city);
		XCTAssertEqualObjects(address.province,     returnedAddress.province);
		XCTAssertEqualObjects(address.provinceCode, returnedAddress.provinceCode);
		XCTAssertEqualObjects(address.country,      returnedAddress.country);
		XCTAssertEqualObjects(address.countryCode,  returnedAddress.countryCode);
		XCTAssertEqualObjects(address.zip,          returnedAddress.zip);
		
		self.createdAddress = returnedAddress;
		
		[expectation fulfill];
	}];

	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)getAddress
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddress1"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getAddressWithID:self.createdAddress.identifier customerID:self.customer.identifier.stringValue callback:^(BUYAddress * _Nullable address, NSError * _Nullable error) {
		
		XCTAssertNotNil(address);
		XCTAssertNil(error);
		XCTAssertEqualObjects(address.identifier, self.createdAddress.identifier);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)updateAddress
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddress2"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	BUYAddress *modifiedAddress = [self addressByModyfyingAddress:self.createdAddress];
	
	[self.client updateAddress:modifiedAddress customerID:self.customer.identifier.stringValue callback:^(BUYAddress * _Nullable returnedAddress, NSError * _Nullable error) {
		
		XCTAssertNotNil(returnedAddress);
		XCTAssertNil(error);
		
		XCTAssertEqualObjects(modifiedAddress.address1,     returnedAddress.address1);
		XCTAssertEqualObjects(modifiedAddress.city,         returnedAddress.city);
		XCTAssertEqualObjects(modifiedAddress.province,     returnedAddress.province);
		XCTAssertEqualObjects(modifiedAddress.provinceCode, returnedAddress.provinceCode);
		XCTAssertEqualObjects(modifiedAddress.country,      returnedAddress.country);
		XCTAssertEqualObjects(modifiedAddress.countryCode,  returnedAddress.countryCode);
		XCTAssertEqualObjects(modifiedAddress.zip,          returnedAddress.zip);
		
		self.createdAddress = returnedAddress;
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)deleteAddress
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddressDelete"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client  deleteAddressWithID:self.createdAddress.identifier customerID:self.customer.identifier.stringValue callback:^(BUYStatus status, NSError * _Nullable error) {
		
		XCTAssertEqual(status, 204);
		XCTAssertNil(error);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:nil];
}

#pragma mark - Address -

- (BUYAddress *)address
{
	BUYAddress *address  = [[BUYAddress alloc] initWithModelManager:self.client.modelManager JSONDictionary:nil];
	address.address1     = @"3892 Streewell Rd.";
	address.city         = @"Toronto";
	address.province     = @"Ontario";
	address.provinceCode = @"ON";
	address.country      = @"Canada";
	address.countryCode  = @"CA";
	address.zip          = @"L8S 2W2";
	
	return address;
}

- (BUYAddress *)addressByModyfyingAddress:(BUYAddress *)oldAddress;
{
	BUYAddress *address  = [[BUYAddress alloc] initWithModelManager:self.client.modelManager JSONDictionary:nil];
	address.identifier   = oldAddress.identifier;
	address.address1     = @"8493 Southwest St.";
	address.city         = @"Vancouver";
	address.province     = @"British Columbia";
	address.provinceCode = @"BC";
	address.country      = @"Canada";
	address.countryCode  = @"CA";
	address.zip          = @"T3G 4D9";
	
	return address;
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
	BUYAccountCredentialItem *password2 = [BUYAccountCredentialItem itemWithPasswordConfirmation:self.customerPassword];
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

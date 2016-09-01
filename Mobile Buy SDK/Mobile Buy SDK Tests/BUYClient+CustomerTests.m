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
@import Buy;

#import "BUYClientTestBase.h"

#import <OHHTTPStubs/OHHTTPStubs.h>
#import "OHHTTPStubsResponse+Helpers.h"

@interface BUYClientTest_Customer : BUYClientTestBase

@property (strong, nonatomic) BUYCustomer *customer;
@property (strong, nonatomic) BUYAddress *createdAddress;

@end

@implementation BUYClientTest_Customer

#pragma mark - Lifecycle -

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
	
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		if ([request.URL.lastPathComponent isEqualToString:@"customer_token.json"]) {
			return [OHHTTPStubsResponse responseWithKey:@"testCustomerToken"];
		} else {
			return [OHHTTPStubsResponse responseWithKey:@"testCustomerLogin"];
		}
	}];
	
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client loginCustomerWithCredentials:[self credentialsForLogin] callback:^(BUYCustomer *customer, BUYCustomerToken *token, NSError *error) {
		
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
	[self.client createCustomerWithCredentials:[self credentialsForLogin] callback:^(BUYCustomer *customer, BUYCustomerToken *token, NSError *error) {
		
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
	[self.client createCustomerWithCredentials:[self credentialsForFailure] callback:^(BUYCustomer *customer, BUYCustomerToken *token, NSError *error) {
		
		XCTAssertNil(customer);
		XCTAssertNotNil(error);
		
		NSArray<BUYError *> *errors = [BUYError errorsFromSignUpJSON:error.userInfo];
		XCTAssertEqual(errors.count, 2);
		
		BUYError *emailError = errors[0];
		XCTAssertEqualObjects(emailError.code, @"invalid");
		
		BUYError *passwordError = errors[1];
		XCTAssertEqualObjects(passwordError.code, @"too_short");
		XCTAssertEqualObjects(passwordError.options[@"count"], @5);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
		XCTAssertNil(error);
	}];
}

- (void)testCustomerCreation
{
	BUYAccountCredentials *credentials = [self credentialsForCreation];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCustomerWithCredentials:credentials callback:^(BUYCustomer *customer, BUYCustomerToken *token, NSError *error) {
		
		// Since this tests relies on randomly generated data, we can't use mocked responses
		
		if ([self shouldUseMocks] == false) {
			XCTAssertNotNil(customer);
			XCTAssertNil(error);
			
			XCTAssertEqualObjects(customer.firstName, [credentials credentialItemForKey:BUYAccountFirstNameKey].value);
			XCTAssertEqualObjects(customer.lastName, [credentials credentialItemForKey:BUYAccountLastNameKey].value);
			XCTAssertEqualObjects(customer.email, [credentials credentialItemForKey:BUYAccountEmailKey].value);
		}
		
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
	[self loginDefaultCustomer];

	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerLogout" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client logoutCustomerCallback:^(BUYStatus status, NSError * _Nullable error) {
		
		XCTAssertNil(error);
		XCTAssertEqual(status, 204);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
}

#pragma mark - Orders -

- (void)testCustomerOrders
{
	[self loginDefaultCustomer];

	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerGetOrders" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getOrdersForCustomerCallback:^(NSArray<BUYOrder *> * _Nullable orders, NSError * _Nullable error) {
		
		XCTAssertNotNil(orders);
		XCTAssertNil(error);
		
		XCTAssertTrue(orders.count > 0);
		XCTAssertTrue([orders.firstObject isKindOfClass:[BUYOrder class]]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {}];
}

- (void)testCustomerOrderWithID
{
	[self loginDefaultCustomer];

	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerGetOrder" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getOrderWithID:self.customerOrderIDs.firstObject callback:^(BUYOrder * _Nullable order, NSError * _Nullable error) {
		
		XCTAssertNil(error);
		XCTAssertTrue([order isKindOfClass:[BUYOrder class]]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {}];
}

- (void)testCustomerUpdate
{
	[self loginDefaultCustomer];

	[OHHTTPStubs stubUsingResponseWithKey:@"testCustomerLogin" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client updateCustomer:_customer callback:^(BUYCustomer * _Nullable customer, NSError * _Nullable error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(customer);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
}

#pragma mark - Address -

- (void)testGetAddresses
{
	[self loginDefaultCustomer];

	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddresses"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getAddressesCallback:^(NSArray<BUYAddress *> * _Nullable addresses, NSError * _Nullable error) {
		
		XCTAssertNotNil(addresses);
		XCTAssertTrue(addresses.count > 0);
		XCTAssertTrue([addresses.firstObject isKindOfClass:[BUYAddress class]]);
		XCTAssertNil(error);
		
		NSArray *defaultAddresses = [addresses filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isDefault == 1"]];
		XCTAssertEqual(1, defaultAddresses.count);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
}

- (void)testAddressCRUD
{
	[self loginDefaultCustomer];

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
	
	[self.client createAddress:address callback:^(BUYAddress * _Nullable returnedAddress, NSError * _Nullable error) {
		
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
	
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
}

- (void)getAddress
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddress1"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getAddressWithID:self.createdAddress.identifier callback:^(BUYAddress * _Nullable address, NSError * _Nullable error) {
		
		XCTAssertNotNil(address);
		XCTAssertNil(error);
		XCTAssertEqualObjects(address.identifier, self.createdAddress.identifier);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
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
	
	[self.client updateAddress:modifiedAddress callback:^(BUYAddress * _Nullable returnedAddress, NSError * _Nullable error) {
		
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
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
}

- (void)deleteAddress
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		return [OHHTTPStubsResponse responseWithKey:@"testCustomerAddressDelete"];
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client  deleteAddressWithID:self.createdAddress.identifier callback:^(BUYStatus status, NSError * _Nullable error) {
		
		XCTAssertEqual(status, 204);
		XCTAssertNil(error);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
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
	BUYAccountCredentialItem *first		= [BUYAccountCredentialItem itemWithFirstName:@"Bob"];
	BUYAccountCredentialItem *last		= [BUYAccountCredentialItem itemWithLastName:@"Sacamano"];
	BUYAccountCredentialItem *email     = [BUYAccountCredentialItem itemWithEmail:[[self randomStringWithLength:8] stringByAppendingString:@"@email.com"]];
	BUYAccountCredentialItem *password  = [BUYAccountCredentialItem itemWithPassword:@"12345"];
	return [BUYAccountCredentials credentialsWithItems:@[first, last, email, password]];
}

- (BUYAccountCredentials *)credentialsForFailure
{
	BUYAccountCredentialItem *email     = [BUYAccountCredentialItem itemWithEmail:@"apple"];
	BUYAccountCredentialItem *password  = [BUYAccountCredentialItem itemWithPassword:@"banana"];
	return [BUYAccountCredentials credentialsWithItems:@[email, password]];
}

#pragma mark - Conveniences -

- (NSString *)randomStringWithLength:(NSInteger)length
{
	NSString *UUID = [[NSUUID UUID] UUIDString];
	return [UUID substringToIndex:length - 1];
}

@end

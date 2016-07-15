//
//  BUYAccountCredentialsTests.m
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
#import <Buy/Buy.h>

@interface BUYAccountCredentialsTests : XCTestCase

@end

@implementation BUYAccountCredentialsTests

#pragma mark - Init -
- (void)testInitWithoutItems {
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:@[]];
	XCTAssertNotNil(credentials);
	XCTAssertEqual(credentials.count, 0);
}

- (void)testInitWithItems {
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:[self sampleWithValidItems]];
	XCTAssertNotNil(credentials);
	XCTAssertEqual(credentials.count, 2);
}

#pragma mark - Validation -
- (void)testValidationWithValidItems {
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:[self sampleWithValidItems]];
	XCTAssertEqual(credentials.count, 2);
	XCTAssertTrue(credentials.isValid);
}

- (void)testValidationWithInvalidItems {
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:[self sampleWithInvalidItems]];
	XCTAssertEqual(credentials.count, 2);
	XCTAssertFalse(credentials.isValid);
}

#pragma mark - Mutation -
- (void)testExtendingCredentials {
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:[self sampleWithValidItems]];
	XCTAssertEqual(credentials.count, 2);
	
	credentials = [credentials credentialsByAddingItems:@[
														  [BUYAccountCredentialItem itemWithFirstName:@"John"],
														  [BUYAccountCredentialItem itemWithLastName:@"Doe"],
														  ]];
	XCTAssertEqual(credentials.count, 4);
}

#pragma mark - Serialization -
- (void)testJSONSerialization {
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:@[
																					   [BUYAccountCredentialItem itemWithEmail:@"john@doe.com"],
																					   [BUYAccountCredentialItem itemWithFirstName:@"John"],
																					   [BUYAccountCredentialItem itemWithLastName:@"Doe"],
																					   [BUYAccountCredentialItem itemWithPassword:@"pass"],
																					   ]];
	
	NSDictionary *json     = [credentials JSONRepresentation];
	NSDictionary *customer = json[@"customer"];
	
	XCTAssertNotNil(json);
	XCTAssertEqual(json.count, 1);
	XCTAssertNotNil(customer);
	XCTAssertEqual(customer[BUYAccountEmailKey], @"john@doe.com");
	XCTAssertEqual(customer[BUYAccountFirstNameKey], @"John");
	XCTAssertEqual(customer[BUYAccountLastNameKey], @"Doe");
	XCTAssertEqual(customer[BUYAccountPasswordKey], @"pass");
}

#pragma mark - Utilities -
- (BUYAccountCredentialItem *)emailItem
{
	return [BUYAccountCredentialItem itemWithEmail:@"john@smith.com"];
}

- (BUYAccountCredentialItem *)passwordItem
{
	return [BUYAccountCredentialItem itemWithPassword:@"password"];
}

- (NSArray *)sampleWithValidItems {
	NSMutableArray *items = [NSMutableArray new];
	[items addObject:[self emailItem]];
	[items addObject:[self passwordItem]];
	return items;
}

- (NSArray *)sampleWithInvalidItems {
	NSMutableArray *items = [NSMutableArray new];
	[items addObject:[self emailItem]];
	[items addObject:[BUYAccountCredentialItem itemWithPassword:@""]];
	return items;
}

@end

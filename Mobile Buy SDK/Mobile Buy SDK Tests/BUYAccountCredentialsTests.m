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
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:nil];
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
	XCTAssertEqual(credentials.count, 3);
	XCTAssertFalse(credentials.isValid);
}

#pragma mark - Mutation -
- (void)testAddingUniqueItems {
	
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentials];
	XCTAssertEqual(credentials.count, 0);
	
	[credentials setCredentialItem:[self emailItem]];
	XCTAssertEqual(credentials.count, 1);
	
	[credentials setCredentialItems:@[
									  [self passwordItem],
									  [self passwordConfirmationItem],
									  ]];
	XCTAssertEqual(credentials.count, 3);
}

- (void)testAddingDuplicateItems {
	
	/* ----------------------------------
	 * A duplicate item is considered the
	 * same based on the item key, not
	 * the value.
	 */
	
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentials];
	XCTAssertEqual(credentials.count, 0);
	
	[credentials setCredentialItem:[BUYAccountCredentialItem itemEmailWithValue:@"john@appleseed.com"]];
	XCTAssertEqual(credentials.count, 1);
	
	[credentials setCredentialItem:[BUYAccountCredentialItem itemEmailWithValue:@"john@doe.com"]];
	XCTAssertEqual(credentials.count, 1);
}

#pragma mark - Serialization -
- (void)testJSONSerialization {
	BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:[self sampleWithValidItems]];
	[credentials setCredentialItems:@[
									  [BUYAccountCredentialItem itemEmailWithValue:@"john@doe.com"],
									  [BUYAccountCredentialItem itemFirstNameWithValue:@"John"],
									  [BUYAccountCredentialItem itemLastNameWithValue:@"Doe"],
									  [BUYAccountCredentialItem itemPasswordWithValue:@"pass"],
									  [BUYAccountCredentialItem itemPasswordConfirmationWithValue:@"pass"],
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
	XCTAssertEqual(customer[BUYAccountPasswordConfirmationKey], @"pass");
}

#pragma mark - Utilities -
- (BUYAccountCredentialItem *)emailItem
{
	return [BUYAccountCredentialItem itemEmailWithValue:@"john@smith.com"];
}

- (BUYAccountCredentialItem *)passwordItem
{
	return [BUYAccountCredentialItem itemPasswordWithValue:@"password"];
}

- (BUYAccountCredentialItem *)passwordConfirmationItem
{
	return [BUYAccountCredentialItem itemPasswordConfirmationWithValue:@"password"];
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
	[items addObject:[BUYAccountCredentialItem itemPasswordWithValue:@""]];
	[items addObject:[BUYAccountCredentialItem itemPasswordConfirmationWithValue:@""]];
	return items;
}

@end

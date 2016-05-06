//
//  BUYOptionValueTests.m
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
#import "BUYOptionValue.h"

@interface BUYOptionValueTests : XCTestCase

@end

@implementation BUYOptionValueTests

- (void)testInitWithValidData {
	NSDictionary *json    = [self jsonWithID:@84935 optionID:@749];
	BUYOptionValue *value = [[BUYOptionValue alloc] initWithDictionary:json];
	
	XCTAssertNotNil(value);
	XCTAssertEqualObjects(value.identifier, json[@"id"]);
	XCTAssertEqualObjects(value.name,       json[@"name"]);
	XCTAssertEqualObjects(value.value,      json[@"value"]);
	XCTAssertEqualObjects(value.optionId,   json[@"option_id"]);
}

- (void)testEqualOptions {
	BUYOptionValue *value1 = [self optionValueWithID:@123 optionID:@321];
	BUYOptionValue *value2 = [self optionValueWithID:@123 optionID:@321];
	
	XCTAssertNotEqual(value1, value2); // Pointer comparison, different objects
	XCTAssertEqualObjects(value1, value2);
	XCTAssertEqual(value1.hash, value2.hash);
}

- (void)testIdenticalOptions {
	BUYOptionValue *value1 = [self optionValueWithID:@123 optionID:@321];
	BUYOptionValue *value2 = value1;
	
	XCTAssertEqual(value1, value2);
	XCTAssertTrue([value1 isEqual:value2]);
}

#pragma mark - Convenience -
- (BUYOptionValue *)optionValueWithID:(NSNumber *)identifier optionID:(NSNumber *)optionID {
	return [[BUYOptionValue alloc] initWithDictionary:[self jsonWithID:identifier optionID:optionID]];
}

- (NSDictionary *)jsonWithID:(NSNumber *)identifier optionID:(NSNumber *)optionID {
	return @{
			 @"id"        : @19483,
			 @"name"      : @"option1",
			 @"value"     : @"value1",
			 @"option_id" : @543,
			 };
}

@end

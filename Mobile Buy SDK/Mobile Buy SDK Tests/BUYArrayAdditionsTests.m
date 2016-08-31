//
//  BUYModelArrayAdditionsTests.m
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

#import "NSArray+BUYAdditions.h"

@interface BUYArrayAdditionsTests : XCTestCase

@end

@implementation BUYArrayAdditionsTests

- (void)testNilMap {
	NSArray *empty = @[];
	XCTAssertEqualObjects([empty buy_map:nil], empty, @"buy_map failed");
	NSArray *array = @[@1, @2];
	XCTAssertEqualObjects([array buy_map:nil], empty, @"buy_map failed");
}

- (void)testMap {
	
	NSArray *expected = @[@2, @4, @6];
	NSArray *actual = [@[@1, @2, @3] buy_map:^id(NSNumber *number) {
		return @([number unsignedIntegerValue] * 2);
	}];
	
	XCTAssertEqualObjects(actual, expected, @"map count was incorrect");
}

- (void)testReverse {
	
	NSArray *expected = @[@3, @2, @1];
	NSArray *actual = [@[@1, @2, @3] buy_reversedArray];
	XCTAssertEqualObjects(actual, expected, @"reversed array was incorrect");
}

- (void)testMutableReverse {
	NSArray *array = @[@1, @2, @3];
	NSArray *expected = @[@3, @2, @1];
	NSMutableArray *actual = [array mutableCopy];
	[actual buy_reverse];
	XCTAssertEqualObjects(actual, expected, @"reversed array was incorrect");
}

- (void)testTail {
	NSArray *array = @[];
	NSArray *expected = @[];
	XCTAssertEqualObjects(array.buy_tail, expected, @"tail array incorrect");
	
	array = @[@1, @2, @3];
	expected = @[@2, @3];
	XCTAssertEqualObjects(array.buy_tail, expected, @"tail array incorrect");
}

- (void)testNSObjectToArray {
	id value = @"hello";
	id expected = @[@"hello"];
	id actual = [value buy_array];
	XCTAssertEqualObjects(actual, expected, @"array form incorrect");
	
	expected = value;
	actual = [NSObject buy_convertArray:@[value]];
	XCTAssertEqualObjects(actual, expected, @"unwrapped array was incorrect");
}

- (void)testNSArrayToArray {
	id value = @[@1, @2];
	id expected = @[@1, @2];
	id actual = [value buy_array];
	XCTAssertEqualObjects(actual, expected, @"array form incorrect");
	
	expected = value;
	actual = [NSArray buy_convertArray:@[@1, @2]];
	XCTAssertEqualObjects(actual, expected, @"unwrapped array was incorrect");
}

- (void)testNSSetToArray {
	id value = [NSSet setWithArray:@[@1, @2]];
	id expected = @[@1, @2];
	id actual = [value buy_array];
	XCTAssertEqualObjects(actual, expected, @"array form incorrect");
	
	expected = value;
	actual = [NSSet buy_convertArray:@[@1, @2]];
	XCTAssertEqualObjects(actual, expected, @"unwrapped array was incorrect");
}

- (void)testNSOrderedSetToArray {
	id value = [NSOrderedSet orderedSetWithArray:@[@1, @2]];
	id expected = @[@1, @2];
	id actual = [value buy_array];
	XCTAssertEqualObjects(actual, expected, @"array form incorrect");
	
	expected = value;
	actual = [NSOrderedSet buy_convertArray:@[@1, @2]];
	XCTAssertEqualObjects(actual, expected, @"unwrapped array was incorrect");
}

@end

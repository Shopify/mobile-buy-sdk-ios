//
//  BUYModelDictionaryAdditionsTests.m
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

@interface BUYDictionaryAdditionsTests : XCTestCase

@end

@implementation BUYDictionaryAdditionsTests

- (NSDictionary *)englishToFrench
{
	return @{
			 @"one": @"un",
			 @"two": @"deux",
			 @"three": @"trois",
			 @"four": @"quatre",
			 };
}

- (NSDictionary *)stringsToNumbers
{
	return @{
			 @"one": @1,
			 @"two": @2,
			 @"three": @3,
			 @"four": @4,
			 @"five": @5,
			 };
}

- (void)testReverseDictionary {
	
	NSDictionary *expected = @{
							   @"un": @"one",
							   @"deux": @"two",
							   @"trois": @"three",
							   @"quatre": @"four",
							   };
	XCTAssertEqualObjects([self englishToFrench].buy_reverseDictionary, expected, @"reverse dictionary was incorrect");
}

- (void)testKeyMapping
{
	NSDictionary *JSON = [self stringsToNumbers];
	NSDictionary *expected = @{
							   @"un": @1,
							   @"deux": @2,
							   @"trois": @3,
							   @"quatre": @4,
							   @"five":@5
							   };
	NSDictionary *mapping = [self englishToFrench];
	NSDictionary *actual = [JSON buy_dictionaryByMappingKeysWithBlock:^(NSString *key) {
		return mapping[key];
	}];
	XCTAssertEqualObjects(actual, expected, @"converted dictionary was incorrect");
}

- (void)testValueMapping
{
	NSDictionary *JSON = [[self englishToFrench] buy_reverseDictionary];
	NSDictionary *mapping = [self stringsToNumbers];
	NSDictionary *expected = @{
							   @"un": @1,
							   @"deux": @2,
							   @"trois": @3,
							   @"quatre": @4,
							   };
	NSDictionary *actual = [JSON buy_dictionaryByMappingValuesWithBlock:^(id value) {
		return mapping[value];
	}];
	XCTAssertEqualObjects(actual, expected, @"converted dictionary was incorrect");
}

@end

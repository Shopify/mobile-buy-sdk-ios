//
//  BUYModelRegularExpressionAdditionTests.m
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

@interface BUYRegularExpressionAdditionsTests : XCTestCase

@end

@implementation BUYRegularExpressionAdditionsTests

- (void)testMatchesInEmptyString {
	NSArray *expected = @[];
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"hello" options:0 error:NULL];
	NSArray *actual = [regex buy_matchesInString:@""];
	XCTAssertEqualObjects(actual, expected, @"matches array was incorrect");
}

- (void)testSingleMatch {
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"hello" options:0 error:NULL];
	NSArray *matches = [regex buy_matchesInString:@"_hello_"];
	XCTAssertEqual(matches.count, (NSUInteger)1, @"number of matches incorrect");
	NSRange expected = NSMakeRange(1, 5);
	NSRange actual = [matches.firstObject range];
	XCTAssertEqual(actual.location, expected.location, @"location of match was incorrect");
	XCTAssertEqual(actual.length, expected.length, @"length of match was incorrect");
}

- (void)testMultipleMatches {
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"hello" options:0 error:NULL];
	NSArray *matches = [regex buy_matchesInString:@"_hello_hello___hellhello234234"];
	XCTAssertEqual(matches.count, (NSUInteger)3, @"number of matches incorrect");
	NSRange expected[3] = {NSMakeRange(1, 5), NSMakeRange(7, 5), NSMakeRange(19, 5)};
	for (NSUInteger i = 0; i < 3; ++i) {
		NSRange actual = [matches[i] range];
		XCTAssertTrue(NSEqualRanges(actual, expected[i]), @"ranges did not match");
	}
}

- (void)testFirstMatch {
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"hello" options:0 error:NULL];
	NSTextCheckingResult *match = [regex buy_firstMatchInString:@"hello_hello"];
	NSRange expected = NSMakeRange(0, 5);
	NSRange actual = [match range];
	XCTAssertTrue(NSEqualRanges(actual, expected), @"ranges did not match");
}

@end

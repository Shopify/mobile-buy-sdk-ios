//
//  BUYModelStringAdditionsTests.m
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

@interface BUYStringAdditionsTests : XCTestCase

@end

static NSString * const lettersAndNumbers = @"abcdefghijklmnopqrstuvwxyz1234567890";
static NSString * const testMatchingString = @"stringstrongstingstringring";
static NSString * const matchPattern = @"str?\\w?ng";

static NSString * const camelCaseString = @"camelCaseString";
static NSString * const camelCaseSTRING = @"camelCaseSTRING";
static NSString * const camelCASEString = @"camelCASEString";
static NSString * const CAMELCaseString = @"CAMELCaseString";

@implementation BUYStringAdditionsTests {
	NSArray *_oldAcronyms;
}

- (void)setUp
{
	[super setUp];
	_oldAcronyms = [NSString buy_acronymStrings];
}

- (void)tearDown
{
	[super tearDown];
	[NSString buy_setAcronymStrings:_oldAcronyms];
	_oldAcronyms = nil;
}

- (void)testReversedString {
	NSString *expected = @"0987654321zyxwvutsrqponmlkjihgfedcba";
	NSString *actual = [lettersAndNumbers buy_reversedString];
	XCTAssertEqualObjects(actual, expected, @"reversed string was incorrect");
}

- (void)testMatchesForRegularExpression {
	NSArray *expected = @[@"string", @"strong", @"sting", @"string"];
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchPattern options:0 error:NULL];
	NSArray *actual = [testMatchingString buy_matchesForRegularExpression:regex];
	XCTAssertEqualObjects(actual, expected, @"patterns did not match");
}

- (void)testFirstMatchForRegularExpression {
	NSString *expected = @"string";
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchPattern options:0 error:NULL];
	NSString *actual = [testMatchingString buy_firstMatchForRegularExpression:regex];
	XCTAssertEqualObjects(actual, expected, @"patterns did not match");
}

- (void)testMatchesForPattern {
	NSArray *expected = @[@"string", @"strong", @"sting", @"string"];
	NSArray *actual = [testMatchingString buy_matchesForPattern:matchPattern];
	XCTAssertEqualObjects(actual, expected, @"patterns did not match");
}

- (void)testFirstMatchForPattern {
	NSString *expected = @"string";
	NSString *actual = [testMatchingString buy_firstMatchForPattern:matchPattern];
	XCTAssertEqualObjects(actual, expected, @"patterns did not match");
}

- (void)testCamelCaseTokens {
	NSArray *expected = @[@"camel", @"Case", @"String"];
	NSArray *actual = [camelCaseString buy_camelCaseTokens];
	XCTAssertEqualObjects(actual, expected, @"tokens were incorrect");
}

- (void)testCamelCaseALLCAPSTokens {
	NSArray *expected = @[@"camel", @"Case", @"STRING"];
	NSArray *actual = [camelCaseSTRING buy_camelCaseTokens];
	XCTAssertEqualObjects(actual, expected, @"tokens were incorrect");

	expected = @[@"camel", @"CASE", @"String"];
	actual = [camelCASEString buy_camelCaseTokens];
	XCTAssertEqualObjects(actual, expected, @"tokens were incorrect");

	expected = @[@"CAMEL", @"Case", @"String"];
	actual = [CAMELCaseString buy_camelCaseTokens];
	XCTAssertEqualObjects(actual, expected, @"tokens were incorrect");
}

- (void)testSnakeCaseString {
	NSString *expected = @"camel_case_string";
	NSString *actual = [camelCaseString buy_snakeCaseString];
	XCTAssertEqualObjects(actual, expected, @"snake case string was incorrect");

	actual = [camelCaseSTRING buy_snakeCaseString];
	XCTAssertEqualObjects(actual, expected, @"snake case string was incorrect");
	
	actual = [camelCASEString buy_snakeCaseString];
	XCTAssertEqualObjects(actual, expected, @"snake case string was incorrect");
	
	actual = [CAMELCaseString buy_snakeCaseString];
	XCTAssertEqualObjects(actual, expected, @"snake case string was incorrect");
}

- (void)testCamelCaseString {
	NSString *expected = @"snakeCaseString";
	NSString *actual = [@"snake_case_string" buy_camelCaseString];
	XCTAssertEqualObjects(actual, expected, @"camel case string was incorrect");
}

- (void)testAcronyms {
	NSArray *expected = @[ @"url"];
	NSArray *actual = [NSString buy_acronymStrings];
	XCTAssertEqualObjects(actual, expected, @"Default acronyms not correct");
	
	NSArray *acronyms = @[ @"hello" ];
	[NSString buy_setAcronymStrings:acronyms];
	expected = acronyms;
	actual = [NSString buy_acronymStrings];
	XCTAssertEqualObjects(actual, expected, @"Custom acronyms not correct");
}

- (void)testCamelCaseStringWithAcronyms {

	NSString *expected = @"URLString";
	NSString *actual = [@"url_string" buy_camelCaseString];
	XCTAssertEqualObjects(actual, expected, @"camel case string was incorrect");
	
	expected = @"stringWithURL";
	actual = [@"string_with_url" buy_camelCaseString];
	XCTAssertEqualObjects(actual, expected, @"camel case string was incorrect");

	[NSString buy_setAcronymStrings:@[@"awol", @"GDP", @"sdk"]];
	expected = @"goneAWOL";
	actual = [@"gone_awol" buy_camelCaseString];
	XCTAssertEqualObjects(actual, expected, @"camel case string was incorrect");
	
	expected = @"SDKTypes";
	actual = [@"sdk_types" buy_camelCaseString];
	XCTAssertEqualObjects(actual, expected, @"camel case string was incorrect");
	
	expected = @"GDPCanada";
	actual = [@"gdp_canada" buy_camelCaseString];
	XCTAssertEqualObjects(actual, expected, @"camel case string was incorrect");
}

- (void)testReplacingFileName
{
	NSString *path = @"/path/to/file.txt";
	NSString *expected = @"/path/to/other_file.txt";
	NSString *actual = [path buy_stringByReplacingBaseFileName:@"other_file"];
	XCTAssertEqualObjects(actual, expected);
}

- (void)testReplacingDirectory
{
	NSString *path = @"/path/to/file.txt";
	NSString *expected = @"/directory_2/file.txt";
	NSString *actual = [path buy_stringByReplacingDirectory:@"/directory_2"];
	XCTAssertEqualObjects(actual, expected);
}

- (void)testStrippingHTML
{
	NSString *rawHTML = @"<!DOCTYPE html>\
	<html>\
	<body>\
	\
	<h1>My First Heading</h1>\
	\
	<p>My first paragraph.</p>\
	\
	</body>\
	</html>";

	NSString *expected = @"My First Heading\nMy first paragraph.\n";
	NSString *actual = [rawHTML buy_stringByStrippingHTML];
	XCTAssertEqualObjects(actual, expected);
}

- (void)testAttributeStringWithLineSpacing
{
	NSString *string = @"Hello, world";
	NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
	style.lineSpacing = 2.0;
	style.alignment = NSTextAlignmentCenter;
	NSAttributedString *expected = [[NSAttributedString alloc] initWithString:string attributes:@{ NSParagraphStyleAttributeName : style }];
	NSAttributedString *actual = [string buy_attributedStringWithLineSpacing:2.0 textAlignment:NSTextAlignmentCenter];
	XCTAssertEqualObjects(actual, expected);
}

- (void)testTrim
{
	NSString *string = @" \t\n Hello \t\n";
	NSString *expected = @"Hello";
	NSString *actual = [string buy_trim];
	XCTAssertEqualObjects(actual, expected);
}

@end

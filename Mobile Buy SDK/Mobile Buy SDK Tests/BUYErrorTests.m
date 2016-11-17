//
//  BUYErrorTests.m
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

@interface BUYErrorTests : XCTestCase

@end

@implementation BUYErrorTests

- (void)testInitWithValidData
{
	NSDictionary *options = @{
							  @"option1" : @432,
							  @"option2" : @"string",
							  };
	
	NSDictionary *json = @{
						   @"code"    : @123,
						   @"message" : @"someError",
						   @"options" : options,
						   };
	
	BUYError *error = [[BUYError alloc] initWithKey:@"testKey" json:json];
	XCTAssertNotNil(error);
	XCTAssertEqualObjects(error.key,     @"testKey");
	XCTAssertEqualObjects(error.code,    json[@"code"]);
	XCTAssertEqualObjects(error.message, json[@"message"]);
	XCTAssertEqualObjects(error.options, json[@"options"]);
}

- (void)testDescription
{
	BUYError *error = [[BUYError alloc] initWithKey:@"testKey" json:@{ @"message" : @"some-message" }];
	XCTAssertEqualObjects(error.description, @"testKey some-message");
}

@end

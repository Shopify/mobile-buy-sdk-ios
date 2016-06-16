//
//  BUYTransformerTests.m
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

#import "BUYDateTransformer.h"
#import "BUYDecimalNumberTransformer.h"
#import "BUYFlatCollectionTransformer.h"
#import "BUYIdentityTransformer.h"
#import "BUYURLTransformer.h"

@interface BUYTransformerTests : XCTestCase

@end

@implementation BUYTransformerTests

- (void)testIdentityTransformer {

	id value = @"value";
	NSValueTransformer *transformer = [self identityTransformer];

	id expected = value;
	id actual = [transformer transformedValue:value];
	XCTAssertEqualObjects(actual, expected, @"transformed value was incorrect");

	actual = [transformer reverseTransformedValue:value];
	XCTAssertEqualObjects(actual, expected, @"reverse transformed value was incorrect");
}

- (void)testDecimalTransformer {
	
	id value = [NSDecimalNumber decimalNumberWithMantissa:256 exponent:-2 isNegative:NO];
	id string = @"2.56";
	NSValueTransformer *transformer = [[BUYDecimalNumberTransformer alloc] init];
	
	id expected = string;
	id actual = [transformer transformedValue:value];
	XCTAssertEqualObjects(actual, expected, @"transformed value was incorrect");
	
	expected = value;
	actual = [transformer reverseTransformedValue:string];
	XCTAssertEqualObjects(actual, expected, @"reverse transformed value was incorrect");
}

- (void)testPublicationDateTransformer {
	
	NSValueTransformer *transformer = [BUYDateTransformer dateTransformerWithFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
	
	NSDate *value = [self dateForTransformerTestingWithMilliseconds:0];
	NSString *string = @"1970-06-21T08:11:59-0400";
	
	id expected = string;
	id actual = [transformer transformedValue:value];
	XCTAssertEqualObjects(actual, expected, @"Transformed date with incorrect");
	
	expected = value;
	actual = [transformer reverseTransformedValue:string];
	XCTAssertEqualObjects(actual, expected, @"Reverse transformed date with incorrect");
}

- (void)testShippingDateTransformer {
	
	NSValueTransformer *transformer = [BUYDateTransformer dateTransformerWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
	
	NSDate *value = [self dateForTransformerTestingWithMilliseconds:543];
	NSString *string = @"1970-06-21T08:11:59.543-0400";
	
	id expected = string;
	id actual = [transformer transformedValue:value];
	XCTAssertEqualObjects(actual, expected, @"Transformed date with incorrect");
	
	expected = value;
	actual = [transformer reverseTransformedValue:string];
	XCTAssertEqualObjects(actual, expected, @"Reverse transformed date with incorrect");
}

- (NSDate *)dateForTransformerTestingWithMilliseconds:(NSInteger)milliseconds {
	
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	dc.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
	dc.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
	dc.year = 1970;
	dc.month = 6;
	dc.day = 21;
	dc.hour = 8;
	dc.minute = 11;
	dc.second = 59;
	dc.nanosecond = NSEC_PER_MSEC * milliseconds;
	return dc.date;
}

- (void)testFlatArrayTransformer {
	
	NSValueTransformer *elementTransformer = [[BUYURLTransformer alloc] init];
	NSValueTransformer *arrayTransformer = [BUYFlatCollectionTransformer arrayTransformerWithElementTransformer:elementTransformer separator:@"||"];
	
	NSString *URLString1 = @"http://www.shopify.com";
	NSString *URLString2 = @"https://test-store.myshopify.com/meta.json";
	NSURL *testURL = [self urlForTesting];
	NSString *URLString3 = [testURL absoluteString];
	NSArray *array = @[
					   [NSURL URLWithString:URLString1],
					   [NSURL URLWithString:URLString2],
					   testURL,
					   ];
	NSString *string = [NSString stringWithFormat:@"%@||%@||%@", URLString1, URLString2, URLString3];
	
	id expected = string;
	id actual = [arrayTransformer transformedValue:array];
	XCTAssertEqualObjects(actual, expected, @"String encoding of flat array of URLs was incorrect");
	
	expected = array;
	actual = [arrayTransformer reverseTransformedValue:string];
	XCTAssertEqualObjects(actual, expected, @"Array of URLs decoded from string was incorrect");
}

- (NSURL *)urlForTesting {
	NSURLComponents *components = [[NSURLComponents alloc] init];
	
	components.scheme = @"ftp";
	components.host = @"private.example.com";
	components.path = @"/authenticated/internal/account";
	components.port = @3322;

	components.query = @"settings=recent";

	components.user = @"user123";
	components.password = @"secret!@#$";
	
	return [components URL];
}

- (void)testFlatSetTransformer {

	NSValueTransformer *setTransformer = [BUYFlatCollectionTransformer setTransformerWithElementTransformer:[self identityTransformer] separator:@", "];
	
	// We can't verify the intermediate string version without decoding it into a set directly,
	// because we can't control the order of the values
	id expected = [NSSet setWithObjects:@"A", @"B", @"C", nil];
	id actual = [setTransformer reverseTransformedValue:[setTransformer transformedValue:expected]];
	XCTAssertEqualObjects(actual, expected, @"Set of strings was not the same after round trip transformation");
}

- (void)testFlatOrderedSetTransformer {
	
	NSValueTransformer *orderedSetTransformer = [BUYFlatCollectionTransformer orderedSetTransformerWithElementTransformer:[self identityTransformer] separator:@", "];
	
	NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithObjects:@"1", @"2", @"3", nil];
	NSString *string = @"1, 2, 3";
	
	id expected = string;
	id actual = [orderedSetTransformer transformedValue:orderedSet];
	XCTAssertEqualObjects(actual, expected, @"String encoding of flat ordered set was incorrect");
	
	expected = orderedSet;
	actual = [orderedSetTransformer reverseTransformedValue:string];
	XCTAssertEqualObjects(actual, expected, @"Ordered set decoded from string was incorrect");
}

- (NSValueTransformer *)identityTransformer {
	return [[BUYIdentityTransformer alloc] init];
}

@end

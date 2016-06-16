//
//  BUYObserverTests.m
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
#import "BUYObserver.h"

@interface Target : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *number;
@property (nonatomic) NSDate *date;

@end

@implementation Target
@end

@interface BUYObserverTests : XCTestCase
@end

@implementation BUYObserverTests

- (void)test {
	
	NSArray *properties = @[@"name", @"number", @"date"];
	Target *target = [[Target alloc] init];
	
	BUYObserver *observer = [BUYObserver observeProperties:properties ofObject:target];
	XCTAssertEqualObjects(observer.observedProperties, properties);
	XCTAssertEqualObjects(observer.changedProperties, [NSSet set]);
	
	target.name = @"Name";
	XCTAssertEqualObjects(observer.changedProperties, [NSSet setWithObject:@"name"]);
	
	target.number = @10;
	target.date = [NSDate date];
	NSSet *expected = [NSSet setWithObjects:@"name", @"number", @"date", nil];
	XCTAssertEqualObjects(observer.changedProperties, expected);
	
	[observer reset];
	XCTAssertEqualObjects(observer.changedProperties, [NSSet set]);

	__weak Target *weakTarget = target;

	[observer cancel];
	XCTAssertEqualObjects(observer.changedProperties, nil);
	XCTAssertEqualObjects(observer.object, nil);
	target = nil;
	
	XCTAssertEqual(weakTarget, nil);
}

@end

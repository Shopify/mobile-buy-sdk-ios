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

@import XCTest;
@import Buy;

@interface BUYOptionValueTests : XCTestCase

@end

@implementation BUYOptionValueTests {
	BUYModelManager *_modelManager;
}

- (instancetype)initWithInvocation:(NSInvocation *)invocation
{
	self = [super initWithInvocation:invocation];
	if (self) {
		_modelManager = [BUYModelManager modelManager];
	}
	return self;
}

- (void)testInitWithValidData
{
	NSDictionary *json    = [self jsonWithOptionID:@749];
	BUYOptionValue *value = [self optionValueWithOptionID:@749];
	
	XCTAssertNotNil(value);
	XCTAssertEqualObjects(value.name,       json[@"name"]);
	XCTAssertEqualObjects(value.value,      json[@"value"]);
	XCTAssertEqualObjects(value.optionId,   json[@"option_id"]);
}

- (void)testEqualOptions
{
	BUYOptionValue *value1 = [self optionValueWithOptionID:@321];
	BUYOptionValue *value2 = [self optionValueWithOptionID:@321];
	
	XCTAssertNotEqual(value1, value2); // Pointer comparison, different objects
	XCTAssertEqualObjects(value1, value2);
	XCTAssertEqual(value1.hash, value2.hash);
}

- (void)testIdenticalOptions
{
	BUYOptionValue *value1 = [self optionValueWithOptionID:@321];
	BUYOptionValue *value2 = value1;
	
	XCTAssertEqual(value1, value2);
	XCTAssertTrue([value1 isEqual:value2]);
}

- (void)testIfOptionValueIsDefault
{
	XCTAssertTrue([self isDefaultOptionValueWithName:@"Title" value:@"Default" optionID:@1]);
	XCTAssertTrue([self isDefaultOptionValueWithName:@"Title" value:@"Default Title" optionID:@1]);
	
	XCTAssertFalse([self isDefaultOptionValueWithName:@"name" value:@"value" optionID:@1]);
}

#pragma mark - Convenience -

- (BUYOptionValue *)optionValueWithOptionID:(NSNumber *)optionID
{
	return [_modelManager buy_objectWithEntityName:[BUYOptionValue entityName] JSONDictionary:[self jsonWithOptionID:optionID]];
}

- (NSDictionary *)jsonWithOptionID:(NSNumber *)optionID
{
	return @{
			 @"name"      : @"option1",
			 @"value"     : @"value1",
			 @"option_id" : @543,
			 };
}

- (BOOL)isDefaultOptionValueWithName:(NSString *)name value:(NSString *)value optionID:(NSNumber *)option_id
{
	BUYOptionValue *option = [_modelManager buy_objectWithEntityName:[BUYOptionValue entityName] JSONDictionary:@{
																										  @"name"      : name,
																										  @"value"     : value,
																										  @"option_id" : option_id,
																										  }];
	return option.isDefault;
}

@end

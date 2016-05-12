//
//  BUYApplePayTokenTests.m
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
#import <PassKit/PassKit.h>
#import "BUYApplePayToken.h"

static NSString * const BUYTestingToken = @"7fc9b0e9-ed1c-4d77-9bac-78c904aa03c1";

@interface BUYApplePayToken (Private)
- (NSString *)paymentTokenString;
@end

@interface BUYApplePayTestToken : PKPaymentToken

@property (strong, nonatomic) NSData *testData;

@end

@implementation BUYApplePayTestToken

+ (instancetype)validToken {
	BUYApplePayTestToken *token = [BUYApplePayTestToken new];
	token.testData              = [BUYTestingToken dataUsingEncoding:NSUTF8StringEncoding];
	return token;
}

+ (instancetype)invalidToken {
	return [BUYApplePayTestToken new];
}

- (NSData *)paymentData {
	return  _testData;
}

@end

@interface BUYApplePayTokenTests : XCTestCase

@end

@implementation BUYApplePayTokenTests

- (void)testInitWithValidSessionID {
	BUYApplePayToken *token = [[BUYApplePayToken alloc] initWithPaymentToken:[BUYApplePayTestToken validToken]];
	XCTAssertNotNil(token);
	XCTAssertEqualObjects(BUYTestingToken, [token paymentTokenString]);
}

- (void)testInitWithInvalidSessionID {
	XCTAssertThrows([[BUYApplePayToken alloc] initWithPaymentToken:nil]);
	XCTAssertThrows([[BUYApplePayToken alloc] initWithPaymentToken:[BUYApplePayTestToken invalidToken]]);
}

- (void)testJSONConversion {
	BUYApplePayToken *token = [[BUYApplePayToken alloc] initWithPaymentToken:[BUYApplePayTestToken validToken]];
	NSDictionary *json        = @{
								  @"payment_token" : @{
										  @"type"         : @"apple_pay",
										  @"payment_data" : BUYTestingToken,
										  },
								  };
	XCTAssertEqualObjects(token.JSONDictionary, json);
}

@end

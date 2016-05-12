//
//  BUYApplePayTokenTests.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-12.
//  Copyright © 2016 Shopify Inc. All rights reserved.
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
	token->_testData            = [BUYTestingToken dataUsingEncoding:NSUTF8StringEncoding];
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

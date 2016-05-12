//
//  BUYCreditCardTokenTests.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-12.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BUYCreditCardToken.h"

@interface BUYCreditCardTokenTests : XCTestCase

@end

@implementation BUYCreditCardTokenTests

- (void)testInitWithValidSessionID {
	BUYCreditCardToken *token = [[BUYCreditCardToken alloc] initWithPaymentSessionID:@"token"];
	XCTAssertNotNil(token);
}

- (void)testInitWithInvalidSessionID {
	XCTAssertThrows([[BUYCreditCardToken alloc] initWithPaymentSessionID:nil]);
	XCTAssertThrows([[BUYCreditCardToken alloc] initWithPaymentSessionID:@""]);
}

- (void)testJSONConversion {
	BUYCreditCardToken *token = [[BUYCreditCardToken alloc] initWithPaymentSessionID:@"token"];
	NSDictionary *json        = @{
								  @"payment_session_id" : @"token",
								  };
	XCTAssertEqualObjects(token.JSONDictionary, json);
}

@end

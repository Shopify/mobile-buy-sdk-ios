//
//  CHKPaymentToken.m
//  Checkout
//
//  Created by Allan Godding on 2014-11-05.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKPaymentToken.h"

@implementation CHKPaymentToken {
	NSData *_paymentData;
}

- (id)initWithPaymentToken:(NSString *)paymentTokenString
{
	_paymentData = [paymentTokenString dataUsingEncoding:NSUTF8StringEncoding];
	return self;
}

- (NSData *)paymentData {
	return _paymentData;
}

@end

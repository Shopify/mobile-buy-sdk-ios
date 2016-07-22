//
//  BUYCustomerToken.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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

#import "BUYCustomerToken.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSDictionary+BUYAdditions.h"

static NSString * const customerAccessTokenKey = @"customer_access_token";
static NSString * const accessTokenKey = @"access_token";
static NSString * const expiresAtKey = @"expires_at";
static NSString * const customerIDKey = @"customer_id";

@implementation BUYCustomerToken

- (instancetype)initWithCustomerID:(NSNumber *)customerID accessToken:(NSString *)accessToken expiry:(NSDate *)expiry
{
	NSParameterAssert(customerID);
	NSParameterAssert(accessToken);
	NSParameterAssert(expiry);
	
	self = [super init];
	if (self) {
		_customerID  = customerID;
		_accessToken = accessToken;
		_expiry      = expiry;
	}
	return self;
}

+ (BUYCustomerToken *)customerTokenWithJSONDictionary:(NSDictionary *)json
{
	return [[self alloc] initWithJSON:json];
}

- (instancetype)initWithJSON:(NSDictionary *)json
{
	NSDateFormatter *formatter = [NSDateFormatter dateFormatterForPublications];
	NSDictionary *access       = json[customerAccessTokenKey] ?: json;
	
	NSNumber *customerID  = access[customerIDKey];
	NSString *accessToken = access[accessTokenKey];
	NSDate *expiry = [formatter dateFromString:access[expiresAtKey]];
	return [self initWithCustomerID:customerID accessToken:accessToken expiry:expiry];
}

- (NSDictionary *)JSONDictionary
{
	NSDateFormatter *formatter = [NSDateFormatter dateFormatterForPublications];
	return @{
			 accessTokenKey : _accessToken,
			 expiresAtKey : [formatter stringFromDate:_expiry],
			 customerIDKey : _customerID
			 };
}

@end

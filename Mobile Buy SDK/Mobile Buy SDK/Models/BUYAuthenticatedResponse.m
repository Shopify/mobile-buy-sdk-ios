//
//  BUYAuthenticatedResponse.m
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

#import "BUYAuthenticatedResponse.h"
#import "NSDateFormatter+BUYAdditions.h"

@implementation BUYAuthenticatedResponse

+ (BUYAuthenticatedResponse *)responseWithJSON:(NSDictionary *)json
{
	return [[[self class] alloc] initWithJSON:json];
}

- (instancetype)initWithJSON:(NSDictionary *)json
{
	self = [super init];
	if (self) {
		NSDateFormatter *formatter = [NSDateFormatter dateFormatterForPublications];
		NSDictionary *access       = json[@"customer_access_token"];
		
		_accessToken = access[@"access_token"];
		_expiry      = [formatter dateFromString:access[@"expires_at"]];
		_customerID  = [NSString stringWithFormat:@"%@", access[@"customer_id"]];
	}
	return self;
}

@end

//
//  OHHTTPStubsResponse+Helpers.m
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

#import "OHHTTPStubsResponse+Helpers.h"

@implementation OHHTTPStubsResponse (Buy)

+ (NSDictionary *)mockResponses
{
	static NSDictionary *dictionary = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSBundle *bundle   = [NSBundle bundleForClass:[self class]];
		NSString *jsonPath = [bundle pathForResource:@"mocked_responses" ofType:@"json"];
		NSData *jsonData   = [NSData dataWithContentsOfFile:jsonPath];
		dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
	});
	return dictionary;
}

+ (instancetype)responseWithKey:(NSString *)key
{
	NSDictionary *mocks = [self mockResponses];
	NSDictionary *json  = mocks[key];
	NSData *data        = [json[@"body"] dataUsingEncoding:NSUTF8StringEncoding];
	int code            = [json[@"code"] intValue];
	
	return [OHHTTPStubsResponse responseWithData:data statusCode:code headers:nil];
}

@end

@implementation OHHTTPStubs (Buy)

+ (void)stubUsingResponseWithKey:(NSString *)key useMocks:(BOOL)useMocks
{
	if (useMocks) {
		[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
			return YES;
		} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
			return [OHHTTPStubsResponse responseWithKey:key];
		}];
	}
}

@end

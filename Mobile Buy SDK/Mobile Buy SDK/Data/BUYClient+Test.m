//
//  BUYClient+Test.m
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

#import "BUYClient+Test.h"

@implementation BUYClient (Test)

- (BOOL)testIntegration
{
	return [self testIntegrationWithMerchantId:self.merchantId];
}

- (BOOL)testIntegrationWithMerchantId:(NSString *)merchantId;
{
	NSLog(@"Remove this call once integration succeeds.  This should never be called in production code!!");
	
	NSString *urlString = [NSString stringWithFormat:@"https://%@/mobile_app/verify?api_key=%@&channel_id=%@", self.shopDomain, self.apiKey, self.channelId];
	
	if (merchantId.length > 0) {
		urlString = [urlString stringByAppendingFormat:@"&merchant_id=%@", merchantId];
	}
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	
	[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	BOOL success = (error == nil && response.statusCode == 200);
	
	return success;
}

@end

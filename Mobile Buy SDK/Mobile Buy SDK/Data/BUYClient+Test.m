//
//  BUYClient+Test.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-21.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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

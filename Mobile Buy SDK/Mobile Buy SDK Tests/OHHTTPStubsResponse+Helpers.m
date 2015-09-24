//
//  OHHTTPStubsResponse+Helpers.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-09-22.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#import "OHHTTPStubsResponse+Helpers.h"

static NSDictionary *JSONMock;

@implementation OHHTTPStubsResponse (Helpers)

+ (instancetype)responseWithKey:(NSString *)key
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		NSBundle *bundle = [NSBundle bundleForClass:[self class]];
		NSString *jsonPath = [bundle pathForResource:@"mocked_responses" ofType:@"json"];
		NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
		JSONMock = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
	});
	
	
	NSDictionary *json = JSONMock[key];
	NSData *data = [json[@"body"] dataUsingEncoding:NSUTF8StringEncoding];
	int code = [json[@"code"] intValue];
	
	return [OHHTTPStubsResponse responseWithData:data statusCode:code headers:nil];
}


@end

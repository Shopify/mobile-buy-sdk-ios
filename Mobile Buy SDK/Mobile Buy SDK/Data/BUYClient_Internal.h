//
//  BUYClient_Internal.h
//  Mobile Buy SDK
//
//  Created by Gabriel O'Flaherty-Chan on 2016-04-04.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYClient.h"
#import "BUYSerializable.h"

extern NSString *const kShopifyError;

@interface BUYClient (Internal)

- (NSURLSessionDataTask *)postRequestForURL:(NSURL *)url object:(id<BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler;
- (NSURLSessionDataTask *)putRequestForURL:(NSURL *)url body:(NSData *)body completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler;
- (NSURLSessionDataTask *)getRequestForURL:(NSURL *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler;

- (NSURLSessionDataTask *)requestForURL:(NSURL *)url method:(NSString *)method body:(NSData *)body additionalHeaders:(NSDictionary *)headers completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler;
- (NSURLComponents *)URLComponentsForAPIPath:(NSString *)apiPath appendingPath:(NSString *)appendingPath queryItems:(NSDictionary*)queryItems;
- (NSError *)extractErrorFromResponse:(NSURLResponse *)response json:(NSDictionary *)json;

@end

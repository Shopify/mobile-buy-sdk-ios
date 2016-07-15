//
//  BUYRequestOperation.m
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

#import "BUYRequestOperation.h"
#import "BUYSerializable.h"
#import "BUYClient+Internal.h"

typedef void (^BUYRequestJSONCompletion)(NSDictionary *json, NSHTTPURLResponse *response, NSError *error);

#pragma mark - NSURLResponse -

@interface NSHTTPURLResponse (Convenience)

@property (assign, nonatomic, readonly) BOOL successful;

@end

@implementation NSHTTPURLResponse (Convenience)

- (BOOL)successful
{
	return ((NSUInteger)(self.statusCode / 100)) == 2;
}

@end

#pragma mark - BUYRequestOperation -

@interface BUYRequestOperation ()

@property (strong, atomic) NSURLSessionDataTask *runningTask;
@property (strong, nonatomic, readonly) BUYRequestOperationCompletion completion;

@end

@implementation BUYRequestOperation

#pragma mark - Init -

+ (instancetype)operationWithSession:(NSURLSession *)session request:(NSURLRequest *)request payload:(id<BUYSerializable>)payload completion:(BUYRequestOperationCompletion)completion
{
	return [[[self class] alloc] initWithSession:session request:request payload:payload completion:completion];
}

- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request payload:(id<BUYSerializable>)payload completion:(BUYRequestOperationCompletion)completion
{
	self = [super init];
	if (self) {
		self.pollingInterval = 0.3;
		
		_session         = session;
		_originalRequest = request;
		_completion      = completion;
	}
	return self;
}

#pragma mark - Completion -

- (void)finishWithJSON:(id)JSON response:(NSHTTPURLResponse *)response
{
	self.completion(JSON, response, nil);
	[self finishExecution];
}

- (void)finishWithError:(NSError *)error response:(NSHTTPURLResponse *)response
{
	self.completion(nil, response, error);
	[self finishExecution];
}

#pragma mark - Start -

- (void)startExecution
{
	if (self.cancelled) {
		return;
	}
	
	[super startExecution];
	
	NSURLRequest *request      = self.originalRequest;
	NSURLSessionDataTask *task = [self requestUsingPollingIfNeeded:request completion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (response.successful) {
			[self finishWithJSON:json response:response];
		} else {
			[self finishWithError:error response:response];
		}
	}];
	
	self.runningTask = task;
	[task resume];
}

- (void)cancelExecution
{
	[super cancelExecution];
	[self.runningTask cancel];
}

#pragma mark - Requests -

- (NSURLSessionDataTask *)requestUsingPollingIfNeeded:(NSURLRequest *)request completion:(BUYRequestJSONCompletion)completion
{
	if (self.cancelled) {
		return nil;
	}
	
	return [self request:request completion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		if (self.cancelled) {
			return;
		}
		
		/* ---------------------------------
		 * If a polling handler is provided
		 * and it returns YES for continue
		 * polling, we recursively continue
		 * the polling process.
		 */
		if (self.pollingHandler && self.pollingHandler(json, response, error)) {

			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.pollingInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				if (self.cancelled) {
					return;
				}
				
				NSURLSessionDataTask *task = [self requestUsingPollingIfNeeded:request completion:completion];
				self.runningTask = task;
				[task resume];
			});
			
		} else {
			completion(json, response, error);
		}
	}];
}

- (NSURLSessionDataTask *)request:(NSURLRequest *)request completion:(BUYRequestJSONCompletion)completion
{
	NSURLSessionDataTask *task = [self.session dataTaskWithRequest:self.originalRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		NSDictionary *json = nil;
		if (data.length > 2) { // 2 is the minimum amount of data {} for a JSON Object. Just ignore anything less.
			json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		}
		
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
		if (!error && !httpResponse.successful) {
			error = [[NSError alloc] initWithDomain:BUYShopifyErrorDomain code:httpResponse.statusCode userInfo:json];
		}
		
		completion(json, httpResponse, error);
	}];
	return task;
}

@end

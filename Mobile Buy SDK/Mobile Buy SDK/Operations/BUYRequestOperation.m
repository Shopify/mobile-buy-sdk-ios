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

NSString * const kShopifyError = @"shopify";

typedef void (^BUYRequestJSONCompletion)(NSDictionary *json, NSHTTPURLResponse *response, NSError *error);

#pragma mark - NSURLResponse -
@interface NSHTTPURLResponse (Conveniece)

@property (assign, nonatomic, readonly) BOOL successful;

@end

@implementation NSHTTPURLResponse (Conveniece)

- (BOOL)successful {
	return ((NSUInteger)(self.statusCode / 100)) == 2;
}

@end

#pragma mark - BUYOperation Private -

@interface BUYOperation (Private)
- (void)setExecuting:(BOOL)executing;
- (void)setFinished:(BOOL)finished;
@end

#pragma mark - BUYRequestOperation -

@interface BUYRequestOperation ()

@property (strong, nonatomic) BUYRequestOperationCompletion completion;
@property (strong, nonatomic) NSURLSessionDataTask *runningTask;

@end

@implementation BUYRequestOperation

#pragma mark - Init -
+ (instancetype)operationWithSession:(NSURLSession *)session request:(NSURLRequest *)request payload:(id<BUYSerializable>)payload completion:(BUYRequestOperationCompletion)completion {
	return [[[self class] alloc] initWithSession:session request:request payload:payload completion:completion];
}

- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request payload:(id<BUYSerializable>)payload completion:(BUYRequestOperationCompletion)completion
{
	self = [super init];
	if (self) {
		_session         = session;
		_originalRequest = request;
		_completion      = completion;
	}
	return self;
}

#pragma mark - Completion -

- (void)finishWithJSON:(id)JSON response:(NSHTTPURLResponse *)response
{
	[self finishExecution];
	self.completion(JSON, response, nil);
}

- (void)finishWithError:(NSError *)error response:(NSHTTPURLResponse *)response
{
	[self finishExecution];
	self.completion(nil, response, error);
}

#pragma mark - Start -

- (void)startExecution
{
	if (self.isCancelled) {
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
	[self locked:^{
		self.runningTask = task;
	}];
	[task resume];
}

- (void)cancelExecution
{
	[super cancelExecution];
	
	__block NSURLSessionDataTask *task = nil;
	[self locked:^{
		task = self.runningTask;
	}];
	[task cancel];
}

#pragma mark - Requests -

- (NSURLSessionDataTask *)requestUsingPollingIfNeeded:(NSURLRequest *)request completion:(BUYRequestJSONCompletion)completion
{
	if (self.isCancelled) {
		return nil;
	}
	
	return [self request:request completion:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		
		if (self.isCancelled) {
			return;
		}
		
		/* ---------------------------------
		 * If a polling handler is provided
		 * and it returns YES for continue
		 * polling, we recursively continue
		 * the polling process.
		 */
		if (self.pollingHandler && self.pollingHandler(json, response, error)) {
			NSURLSessionDataTask *task = [self requestUsingPollingIfNeeded:request completion:completion];
			[self locked:^{
				self.runningTask = task;
			}];
			[task resume];
			
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
		
		NSHTTPURLResponse *httpResponse = (id)response;
		if (!httpResponse.successful && !error) {
			error = [[NSError alloc] initWithDomain:kShopifyError code:httpResponse.statusCode userInfo:json];
		}
		
		completion(json, httpResponse, error);
	}];
	return task;
}

@end

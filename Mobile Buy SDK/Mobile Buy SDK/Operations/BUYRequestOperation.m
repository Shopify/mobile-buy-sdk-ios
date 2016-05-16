//
//  BUYRequestOperation.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-13.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYRequestOperation.h"
#import "BUYSerializable.h"

NSString * const kShopifyError = @"shopify";

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

- (void)finishByCancellation
{
	[self finishExecution];
}

#pragma mark - Start -

- (void)startExecution
{
	if (self.isCancelled) {
		[self finishByCancellation];
		return;
	}
	
	[super startExecution];
	
	NSURLSessionDataTask *task = [self.session dataTaskWithRequest:self.originalRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		if (self.isCancelled) {
			[self finishByCancellation];
			return;
		}
		
		NSDictionary *json = nil;
		if (data.length > 2) { // 2 is the minimum amount of data {} for a JSON Object. Just ignore anything less.
			json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		}
		
		NSHTTPURLResponse *httpResponse = (id)response;
		if (httpResponse.successful) {
			[self finishWithJSON:json response:httpResponse];
		} else {
			if (!error) {
				error = [[NSError alloc] initWithDomain:kShopifyError code:httpResponse.statusCode userInfo:json];
			}
			[self finishWithError:error response:httpResponse];
		}
	}];
	
	[task resume];
}

@end

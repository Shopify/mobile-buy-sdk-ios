//
//  BUYGroupOperation.m
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

#import "BUYGroupOperation.h"
#import "NSArray+BUYAdditions.h"

@interface BUYGroupOperation ()

@property (weak, nonatomic) NSOperationQueue *queue;

@end

@implementation BUYGroupOperation

#pragma mark - Init -

+ (instancetype)groupOperationWithRequestQueue:(NSOperationQueue *)queue operations:(NSArray<NSOperation *> *)operations
{
	return [[[self class] alloc] initWithRequestQueue:queue operations:operations];
}

- (instancetype)initWithRequestQueue:(NSOperationQueue *)queue operations:(NSArray<NSOperation *> *)operations
{
	self = [super init];
	if (self) {
		_queue          = queue;
		self.operations = operations;
	}
	return self;
}

#pragma mark - Finishing -

- (void)finishWithObject:(id)object
{
	if (self.cancelled) {
		return;
	}
	
	[self finishExecution];
}

- (void)finishWithError:(NSError *)error
{
	if (self.cancelled) {
		return;
	}
	
	[self cancelAllOperations];
	[self finishExecution];
}

#pragma mark - Execution -

- (void)startExecution
{
	if (self.cancelled) {
		return;
	}
	
	[super startExecution];
	
	[self linkDependencies];
	[self startAllOperations];
}

- (void)cancelExecution
{
	[super cancelExecution];
	[self cancelAllOperations];
}

#pragma mark - Dependencies -

- (void)linkDependencies
{
	NSArray *tail = [self.operations buy_tail];
	if (tail.count > 0) {
		NSOperation *former = self.operations.firstObject;
		for (NSOperation *latter in tail) {
			[latter addDependency:former];
			former = latter;
		}
	}
}

#pragma mark - Start / Stop -

- (void)startAllOperations
{
	for (NSOperation *operation in self.operations) {
		[self.queue addOperation:operation];
	}
}

- (void)cancelAllOperations
{
	for (NSOperation *operation in self.operations) {
		[operation cancel];
	}
}

@end

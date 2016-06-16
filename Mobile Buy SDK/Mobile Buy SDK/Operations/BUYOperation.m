//
//  BUYOperation.m
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

#import "BUYOperation.h"

typedef NS_ENUM(NSUInteger, BUYOperationState) {
	BUYOperationStateExecuting = 1,
	BUYOperationStateFinished  = 2,
};

@interface BUYOperation ()

@property (atomic, assign) BUYOperationState state;

@end

@implementation BUYOperation

#pragma mark - KVO -

+ (NSSet *)keyPathsForValuesAffectingIsExecuting
{
	return [NSSet setWithObject:@"state"];
}

+ (NSSet *)keyPathsForValuesAffectingIsFinished
{
	return [NSSet setWithObject:@"state"];
}

#pragma mark - Concurrent -
- (BOOL)isAsynchronous
{
	return YES;
}

#pragma mark - Accessors -
- (BOOL)isExecuting
{
	return self.state == BUYOperationStateExecuting;
}

- (BOOL)isFinished
{
	return self.state == BUYOperationStateFinished;
}

#pragma mark - Start -
- (void)start
{
	[self startExecution];
}

- (void)cancel
{
	[super cancel];
	[self cancelExecution];
}

#pragma mark - Execution -
- (void)startExecution
{
	self.state = BUYOperationStateExecuting;
}

- (void)finishExecution
{
	self.state = BUYOperationStateFinished;
}

- (void)cancelExecution
{
	
}

@end

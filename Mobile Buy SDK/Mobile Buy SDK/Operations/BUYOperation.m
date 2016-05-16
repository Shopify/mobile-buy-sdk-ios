//
//  BUYOperation.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-12.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYOperation.h"

typedef NS_ENUM(NSUInteger, BUYOperationState) {
	BUYOperationStateExecuting = 1,
	BUYOperationStateFinished  = 2,
};

@interface BUYOperation ()

@property (nonatomic, assign) BUYOperationState state;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation BUYOperation

#pragma mark - Init -

- (instancetype)init
{
	self = [super init];
	if (self) {
		_lock = [NSLock new];
	}
	return self;
}

#pragma mark - Concurrent -
- (BOOL)isAsynchronous
{
	return YES;
}

- (BOOL)isConcurrent
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

#pragma mark - Setters -

- (void)setState:(BUYOperationState)state
{
	[self.lock lock];
	
	NSString *oldPath = BUYOperationStateKeyPath(self.state);
	NSString *newPath = BUYOperationStateKeyPath(state);
	
	/* ----------------------------------
	 * We avoid changing state if the new
	 * state is the same or the operation
	 * has been cancelled.
	 */
	if ([oldPath isEqualToString:newPath] || self.isCancelled) {
		[self.lock unlock];
		return;
	}
	
	[self willChangeValueForKey:newPath];
	[self willChangeValueForKey:oldPath];
	_state = state;
	NSLog(@"Setting state");
	[self didChangeValueForKey:oldPath];
	[self didChangeValueForKey:newPath];
	
	[self.lock unlock];
}

#pragma mark - Start -
- (void)start
{
	[self startExecution];
}

#pragma mark - Execution -
- (void)startExecution
{
	self.state = BUYOperationStateExecuting;
	NSLog(@"Started operation");
}

- (void)finishExecution
{
	self.state = BUYOperationStateFinished;
	NSLog(@"Finished operation");
}

#pragma mark - State -

static inline NSString * BUYOperationStateKeyPath(BUYOperationState state)
{
	switch (state) {
		case BUYOperationStateFinished:  return @"isFinished";
		case BUYOperationStateExecuting: return @"isExecuting";
	}
	return @"";
}

@end

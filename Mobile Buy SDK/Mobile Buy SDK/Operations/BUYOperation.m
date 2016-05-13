//
//  BUYOperation.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-12.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYOperation.h"

@interface BUYOperation ()

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

@end

@implementation BUYOperation

#pragma mark - Init -

- (instancetype)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}

#pragma mark - Setters -

- (void)setExecuting:(BOOL)executing
{
	[self willChangeValueForKey:@"isExecuting"];
	self.isExecuting = executing;
	[self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished
{
	[self willChangeValueForKey:@"isFinished"];
	self.isFinished = finished;
	[self didChangeValueForKey:@"isFinished"];
}

@end

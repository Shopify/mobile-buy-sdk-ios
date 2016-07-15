//
//  NSArray+BUYAdditions.m
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

#import "NSArray+BUYAdditions.h"

@implementation NSArray (BUYAdditions)

- (NSArray *)buy_reversedArray
{
	NSMutableArray *array = [self mutableCopy];
	[array buy_reverse];
	return array;
}

- (NSArray *)buy_map:(BUYObjectMap)block
{
	if (block == nil) {
		return @[];
	}
	
	NSMutableArray *array = [NSMutableArray array];
	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[array addObject:block(obj)];
	}];
	return array;
}

- (NSArray *)buy_tail
{
	if (self.count > 0) {
		return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
	}
	else {
		return @[];
	}
}

@end

#pragma mark -

@implementation NSMutableArray (BUYAdditions)

- (void)buy_reverse
{
	const NSUInteger count = self.count;
	const NSUInteger mid = count/2;
	for (NSUInteger i=0; i<mid; ++i) {
		const NSUInteger opposite = count-i-1;
		id temp = self[i];
		[self replaceObjectAtIndex:i withObject:self[opposite]];
		[self replaceObjectAtIndex:opposite withObject:temp];
	}
}

@end

@implementation NSObject (BUYModelArrayCreating)

- (NSArray *)buy_array
{
	return @[[self copy]];
}

+ (instancetype)buy_convertArray:(NSArray *)array
{
	return array.firstObject;
}

@end

@implementation NSArray (BUYModelArrayCreating)

- (NSArray *)buy_array
{
	return self;
}

+ (instancetype)buy_convertArray:(NSArray *)array
{
	return [array copy];
}

@end

@implementation NSSet (BUYModelArrayCreating)

- (NSArray *)buy_array
{
	return [self allObjects];
}

+ (instancetype)buy_convertArray:(NSArray *)array
{
	return [NSSet setWithArray:array];
}

@end

@implementation NSOrderedSet (BUYModelArrayCreating)

- (NSArray *)buy_array
{
	return [self array];
}

+ (instancetype)buy_convertArray:(NSArray *)array
{
	return [NSOrderedSet orderedSetWithArray:array];
}

@end

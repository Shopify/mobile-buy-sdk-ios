//
//  BUYObserver.m
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

#import "BUYObserver.h"

static void * kBUYObserverContext = &kBUYObserverContext;

@interface BUYObserver ()
@property (nonatomic) NSObject *object;
@property (nonatomic) NSArray *observedProperties;
@end

@implementation BUYObserver {
	NSMutableSet *_changedProperties;
}

- (instancetype)initWithObject:(id)object properties:(NSArray<NSString *> *)properties
{
	self = [super init];
	if (self) {
		self.object = object;
		self.observedProperties = properties;
		_changedProperties = [NSMutableSet set];
		[self startObserving];
	}
	return self;
}

- (void)dealloc
{
	[self stopObserving];
}

#pragma mark - Accessors

- (NSSet *)changedProperties
{
	return [_changedProperties copy];
}

- (void)addChangedPropertiesObject:(NSString *)object
{
	[_changedProperties addObject:object];
}

- (void)removeChangedProperties:(NSSet *)objects
{
	[_changedProperties minusSet:objects];
}

#pragma mark - Key Value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
	if (context == kBUYObserverContext) {
		[self markPropertyChanged:keyPath];
	}
	else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

- (void)startObserving
{
	for (NSString *property in _observedProperties) {
		[_object addObserver:self forKeyPath:property options:0 context:kBUYObserverContext];
	}
}

- (void)stopObserving
{
	for (NSString *property in _observedProperties) {
		[_object removeObserver:self forKeyPath:property];
	}
}

#pragma mark - BUYObserver

- (void)markPropertyChanged:(NSString *)property
{
	[self addChangedPropertiesObject:property];
}

- (BOOL)hasChanges
{
	return _changedProperties.count > 0;
}

- (void)reset {
	[self removeChangedProperties:[_changedProperties copy]];
}

- (void)cancel {
	[self reset];
	[self stopObserving];
	_changedProperties = nil;
	_observedProperties = nil;
	_object = nil;
}

+ (instancetype)observeProperties:(NSArray<NSString *> *)properties ofObject:(id)object
{
	return [[self alloc] initWithObject:object properties:properties];
}

@end

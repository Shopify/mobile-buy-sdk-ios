//
//  BUYObjectTests.m
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

@import UIKit;
@import XCTest;

#import <Buy/Buy.h>

@interface BUYDirtyTracked : BUYObject

@property (nonatomic, copy) NSString *dirtyObjectValue;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, assign) BOOL dirtyBooleanValue;
@property (nonatomic, assign) char dirtyCharacterValue;
@property (nonatomic, assign) unsigned char dirtyUnsignedCharValue;
@property (nonatomic, assign) int dirtyIntegerValue;
@property (nonatomic, assign) unsigned int dirtyUnsignedIntegerValue;
@property (nonatomic, assign) short dirtyShortValue;
@property (nonatomic, assign) unsigned short dirtyUnsignedShortValue;
@property (nonatomic, assign) long dirtyLongValue;
@property (nonatomic, assign) unsigned long dirtyUnsignedLongValue;
@property (nonatomic, assign) long long dirtyLongLongValue;
@property (nonatomic, assign) unsigned long long dirtyUnsignedLongLongValue;
@property (nonatomic, assign) float dirtyFloatValue;
@property (nonatomic, assign) double dirtyDoubleValue;

@property (nonatomic, readonly) NSArray *array;
@property (nonatomic, readonly) NSMutableArray *mutableArray;

- (NSArray *)propertyNames;

@end

@interface BUYObjectSubclass : BUYObject
@property (nonatomic, strong) NSNumber *identifier;
@end

@interface BUYObjectTests : XCTestCase
@property (nonatomic, strong) BUYModelManager *modelManager;
@end

@interface BUYModelManager (BUYDirtyTracked)
+ (BUYModelManager *)testModelManager;
@end

@implementation BUYObjectTests

- (void)setUp
{
	[super setUp];
	self.modelManager = [BUYModelManager testModelManager];
}

- (void)testDirtyTracking
{
	BUYDirtyTracked *object = [self dirtyTrackedObject];
	object.s = @"short property name test";
	object.dirtyObjectValue = @"Banana";
	object.dirtyBooleanValue = true;
	object.dirtyCharacterValue = 'c';
	object.dirtyUnsignedCharValue = 'c';
	object.dirtyIntegerValue = 1234;
	object.dirtyUnsignedIntegerValue = 123;
	object.dirtyShortValue = 1;
	object.dirtyUnsignedShortValue = 2;
	object.dirtyLongValue = -4;
	object.dirtyUnsignedLongValue = 4;
	object.dirtyLongLongValue = 1234123412341234;
	object.dirtyUnsignedLongLongValue = 1234123412341234;
	object.dirtyFloatValue = 0.5f;
	object.dirtyDoubleValue = 0.5;
	NSSet *expected = [NSSet setWithArray:[object propertyNames]];
	NSSet *actual = [object dirtyProperties];
	XCTAssertEqualObjects(actual, expected);
}

- (void)testIsDirtyReturnsFalseWhenClean
{
	BUYDirtyTracked *object = [self dirtyTrackedObject];
	XCTAssert([object isDirty] == NO);
	object.dirtyObjectValue = @"Banana";
	[object markAsClean];
	XCTAssert([object isDirty] == NO);
}

- (void)testIsDirtyReturnsTrueWhenDirty
{
	BUYDirtyTracked *object = [self dirtyTrackedObject];
	object.dirtyObjectValue = @"Banana";
	XCTAssert([object isDirty]);
}

- (void)testMarkAsClean
{
	BUYDirtyTracked *object = [self dirtyTrackedObject];
	object.dirtyObjectValue = @"Banana";
	XCTAssert([object dirtyProperties]);
}

- (BUYDirtyTracked *)dirtyTrackedObject
{
	return [[BUYDirtyTracked alloc] initWithModelManager:nil JSONDictionary:nil];
}

@end

#pragma mark - Helper Impls

@implementation BUYDirtyTracked

+ (BOOL)tracksDirtyProperties
{
	return YES;
}

+ (NSString *)entityName
{
	return nil;
}

// Overriding private BUYObject class method to avoid need for entity
- (NSArray *)propertyNames
{
	return @[@"s", @"dirtyObjectValue", @"dirtyBooleanValue", @"dirtyCharacterValue",
			 @"dirtyUnsignedCharValue", @"dirtyIntegerValue", @"dirtyUnsignedIntegerValue",
			 @"dirtyShortValue", @"dirtyUnsignedShortValue", @"dirtyLongValue",
			 @"dirtyUnsignedLongValue", @"dirtyLongLongValue", @"dirtyUnsignedLongLongValue",
			 @"dirtyFloatValue", @"dirtyDoubleValue"];
}

@end

@implementation BUYObjectSubclass

+ (NSString *)entityName
{
	return @"ObjectSubclass";
}

@end

@implementation BUYModelManager (BUYDirtyTracked)

+ (BUYModelManager *)testModelManager
{
	static dispatch_once_t onceToken;
	static BUYModelManager *modelManager;
	dispatch_once(&onceToken, ^{
		NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle bundleForClass:self]]];
		modelManager = [[BUYModelManager alloc] initWithModel:model];
	});
	
	return modelManager;
}

@end

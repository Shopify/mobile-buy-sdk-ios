//
//  BUYObject.m
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

#import "BUYObject.h"
#import "BUYModelManagerProtocol.h"
#import "BUYObserver.h"
#import "BUYRuntime.h"
#import "NSDictionary+BUYAdditions.h"
#import "NSException+BUYAdditions.h"
#import "NSEntityDescription+BUYAdditions.h"

@interface BUYObject ()
@property (nonatomic, readwrite, weak) id<BUYModelManager> modelManager;
@property (nonatomic) BUYObserver *dirtyObserver;
@end

@implementation BUYObject

#pragma mark - Dirty Property Tracking

- (BOOL)isDirty
{
	return [self.dirtyObserver hasChanges];
}

- (NSSet *)dirtyProperties
{
	return self.dirtyObserver.changedProperties;
}

- (void)markPropertyAsDirty:(NSString *)property
{
	[self.dirtyObserver markPropertyChanged:property];
}

- (void)markAsClean
{
	[self.dirtyObserver reset];
}

- (void)trackDirtyProperties:(NSArray *)properties
{
	self.dirtyObserver = [BUYObserver observeProperties:properties ofObject:self];
}

#pragma mark - Dynamic JSON Serialization

- (NSArray *)propertyNames
{
	return [self.entity.JSONEncodedProperties allKeys];
}

- (NSEntityDescription *)entity
{
	return [self.modelManager buy_entityWithName:[[self class] entityName]];
}

+ (NSString *)entityName
{
	@throw BUYAbstractMethod();
}

- (NSDictionary *)JSONEncodedProperties
{
	return self.entity.JSONEncodedProperties;
}

- (instancetype)initWithModelManager:(id<BUYModelManager>)modelManager JSONDictionary:(NSDictionary *)dictionary
{
	self = [self init];
	if (self) {
		self.modelManager = modelManager;
		self.JSONDictionary = dictionary;
		if ([[self class] tracksDirtyProperties]) {
			[self trackDirtyProperties:[self propertyNames]];
		}
	}
	return self;
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	return self.JSONDictionary;
}

+ (NSPredicate *)fetchPredicateWithJSON:(NSDictionary *)JSONDictionary
{
	return nil;
}

+ (BOOL)isPersistentClass
{
	return NO;
}

+ (BOOL)tracksDirtyProperties
{
	return NO;
}

- (NSDictionary *)JSONDictionary
{
	// JSON generation starts in `-buy_JSONForObject`.
	// Both persistent and transient objects go through this interface.
	return [self.entity buy_JSONForObject:self];
}

- (void)setJSONDictionary:(NSDictionary *)JSONDictionary
{
	// JSON parsing starts in `-buy_updateObject:withJSON:`.
	// Both persistent and transient objects go through this interface.
	if ([JSONDictionary count]) {
		[self.entity buy_updateObject:self withJSON:JSONDictionary];
	}
}

@end

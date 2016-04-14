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

#pragma mark - Deprecated

- (instancetype)init
{
	return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	return [self initWithModelManager:nil JSONDictionary:dictionary];
}

+ (NSArray *)convertJSONArray:(NSArray*)json block:(void (^)(id obj))createdBlock
{
	NSMutableArray *objects = [[NSMutableArray alloc] init];
	for (NSDictionary *jsonObject in json) {
		BUYObject *obj = [[self alloc] initWithDictionary:jsonObject];
		[objects addObject:obj];
		if (createdBlock) {
			createdBlock(obj);
		}
	}
	return objects;
}

+ (NSArray *)convertJSONArray:(NSArray*)json
{
	return [self convertJSONArray:json block:nil];
}

+ (instancetype)convertObject:(id)object
{
	BUYObject *convertedObject = nil;
	if (!(object == nil || [object isKindOfClass:[NSNull class]])) {
		convertedObject = [[self alloc] initWithDictionary:object];
	}
	return convertedObject;
}

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

- (BOOL)isEqual:(id)object
{
	if (self == object) return YES;
	
	if (![object isKindOfClass:self.class]) return NO;
	
	BOOL same = ([self.identifier isEqual:((BUYObject*)object).identifier]);
	
	return same;
}

- (NSUInteger)hash
{
	NSUInteger hash = [self.identifier hash];
	return hash;
}

- (void)trackDirtyProperties:(NSArray *)properties
{
	self.dirtyObserver = [BUYObserver observeProperties:properties ofObject:self];
}

#pragma mark - Dynamic JSON Serialization

+ (NSArray *)propertyNames
{
	static NSMutableDictionary *namesCache;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		namesCache = [NSMutableDictionary dictionary];
	});
	
	NSString *className = NSStringFromClass(self);
	NSArray *names = namesCache[className];
	if (names == nil) {
		NSMutableSet *allNames = [class_getBUYProperties(self) mutableCopy];
		[allNames removeObject:NSStringFromSelector(@selector(dirtyObserver))];
		names = [allNames allObjects];
		namesCache[className] = names;
	}
	
	return names;
}

+ (NSEntityDescription *)entity
{
	@throw BUYAbstractMethod();
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
	self = [super init];
	if (self) {
		self.modelManager = modelManager;
		[self updateWithDictionary:dictionary];
		if ([[self class] tracksDirtyProperties]) {
			[self trackDirtyProperties:[[self class] propertyNames]];
		}
	}
	return self;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	_identifier = dictionary[@"id"];
	[self markAsClean];
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

- (NSEntityDescription *)entity
{
	return [self.modelManager buy_entityWithName:[[self class] entityName]];
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

//
//  BUYModelManager.m
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

#import "BUYModelManager.h"

#import "BUYDateTransformer.h"
#import "BUYDeliveryRangeTransformer.h"
#import "BUYFlatCollectionTransformer.h"

#import "NSArray+BUYAdditions.h"
#import "NSEntityDescription+BUYAdditions.h"
#import "NSPropertyDescription+BUYAdditions.h"

// Structured value transformer names
NSString * const BUYDeliveryRangeTransformerName = @"BUYDeliveryRange";
NSString * const BUYFlatArrayTransformerName = @"BUYFlatArray";
NSString * const BUYProductTagsTransformerName = @"BUYProductTags";

@interface NSBundle (BUYAdditions)
+ (instancetype)frameworkBundle;
+ (instancetype)resourcesBundle;
@end

@interface BUYModelManager ()
@property (nonatomic, strong) NSManagedObjectModel *model;
@end

@implementation BUYModelManager

+ (void)initialize
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[NSValueTransformer setValueTransformer:[[BUYDeliveryRangeTransformer alloc] init] forName:BUYDeliveryRangeTransformerName];
		[NSValueTransformer setValueTransformer:[BUYFlatCollectionTransformer arrayTransformer] forName:BUYFlatArrayTransformerName];
		[NSValueTransformer setValueTransformer:[BUYFlatCollectionTransformer setTransformerWithSeparator:@", "] forName:BUYProductTagsTransformerName];
	});
}

- (instancetype)init
{
    return [self initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:@[[NSBundle resourcesBundle]]]];
}

- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel *)model
{
	self = [super init];
	if (self) {
		self.model = model;
	}
	return self;
}

+ (instancetype)modelManager
{
	return [[self alloc] init];
}

- (NSEntityDescription *)buy_entityWithName:(NSString *)entityName
{
	return [self.model entitiesByName][entityName];
}

- (id<BUYObject>)buy_objectWithEntityName:(NSString *)entityName JSONDictionary:(NSDictionary *)JSON
{
	NSEntityDescription *entity = [self buy_entityWithName:entityName];
	Class cls = entity.managedObjectClass;
	return [[cls alloc] initWithModelManager:self JSONDictionary:JSON];
}

- (NSArray<id<BUYObject>> *)buy_objectsWithEntityName:(NSString *)entityName JSONArray:(NSArray *)JSON
{
	NSEntityDescription *entity = [self.model entitiesByName][entityName];
	Class cls = entity.managedObjectClass;
	return [JSON buy_map:^id(NSDictionary *JSONDictionary) {
		return [[cls alloc] initWithModelManager:self JSONDictionary:JSONDictionary];
	}];
}

- (id<BUYObject>)buy_objectWithEntityName:(NSString *)entityName identifier:(NSNumber *)identifier
{
	return nil;
}

- (NSArray<id<BUYObject>> *)buy_objectsWithEntityName:(NSString *)entityName identifiers:(NSArray *)identifiers
{
	return @[];
}

- (BOOL)buy_purgeObject:(id<BUYObject>)object error:(NSError *__autoreleasing *)error
{
	return YES;
}

- (void)buy_refreshCacheForObject:(id<BUYObject>)object
{
}

- (BOOL)buy_purgeObjectsWithEntityName:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate
{
	return YES;
}

@end

@implementation NSBundle (BUYAdditions)

+ (instancetype)frameworkBundle
{
	return [NSBundle bundleForClass:[BUYModelManager class]];
}

+ (NSURL *)resourcesBundleURL
{
	return [[self frameworkBundle] URLForResource:@"Buy" withExtension:@"bundle"];
}

+ (instancetype)resourcesBundle
{
#if COCOAPODS
	return [NSBundle bundleWithURL:[self resourcesBundleURL]];
#else
	return [self frameworkBundle];
#endif
}

@end

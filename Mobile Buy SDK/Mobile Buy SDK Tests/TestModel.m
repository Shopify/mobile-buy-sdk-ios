//
//  TestModel.m
//  Mobile Buy SDK
//
//  Created by Brent Gulanowski on 2016-04-27.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "TestModel.h"
#import "NSEntityDescription+BUYAdditions.h"
#import <CoreData/CoreData.h>

@implementation TestModelManager

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.model = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle bundleForClass:[self class]]]];
	}
	return self;
}

- (NSEntityDescription *)buy_entityWithName:(NSString *)entityName
{
	return self.model.entitiesByName[entityName];
}

- (Class)managedModelClassForEntityName:(NSString *)entityName
{
	return [[self buy_entityWithName:entityName] buy_managedObjectClass];
}

- (id<BUYObject>)buy_objectWithEntityName:(NSString *)entityName JSONDictionary:(NSDictionary *)JSON
{
	return [(id)[[self managedModelClassForEntityName:entityName] alloc] initWithModelManager:self JSONDictionary:JSON];
}

- (NSArray<id<BUYObject>> *)buy_objectsWithEntityName:(NSString *)entityName JSONArray:(NSArray *)JSON {
	NSMutableArray *array = [NSMutableArray array];
	for (NSDictionary *dict in JSON) {
		[array addObject:[self buy_objectWithEntityName:entityName JSONDictionary:dict]];
	}
	return array;
}

// We don't need these methods for testing
- (id<BUYObject>)buy_objectWithEntityName:(NSString *)entityName identifier:(NSNumber *)identifier {
	return [entityName isEqualToString:[Bird entityName]] ? [Bird birdWithIdentifier:identifier] : nil;
}

- (NSArray<id<BUYObject>> *)buy_objectsWithEntityName:(NSString *)entityName identifiers:(NSArray *)identifiers { return nil; }

- (void)buy_refreshCacheForObject:(id<BUYObject>)object {}

- (BOOL)buy_purgeObject:(id<BUYObject>)object error:(NSError *__autoreleasing *)error { return YES; }

- (BOOL)buy_purgeObjectsWithEntityName:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate { return YES; }

@end

#pragma mark -

@implementation TestModel

@synthesize modelManager=_modelManager;

- (instancetype)initWithModelManager:(id<BUYModelManager>)modelManager JSONDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		self.modelManager = modelManager;
		self.JSONDictionary = dictionary;
	}
	return self;
}

- (NSDictionary *)JSONDictionary
{
	return [self.entity buy_JSONForObject:self];
}

- (void)setJSONDictionary:(NSDictionary *)JSONDictionary
{
	[self.entity buy_updateObject:self withJSON:JSONDictionary];
}

- (NSDictionary *)JSONEncodedProperties
{
	NSMutableDictionary *properties = [[self.entity buy_JSONEncodedProperties] mutableCopy];
	for (NSString *relationshipName in self.entity.relationshipsByName) {
		NSRelationshipDescription *relationship = properties[relationshipName];
		if (relationship.inverseRelationship.deleteRule == NSCascadeDeleteRule) {
			[properties removeObjectForKey:relationshipName];
		}
	}
	return properties;
}

+ (NSPredicate *)fetchPredicateWithJSON:(NSDictionary *)JSONDictionary
{
	return nil;
}

+ (NSString *)entityName
{
	return NSStringFromClass([self class]);
}

- (NSEntityDescription *)entity
{
	return [self.modelManager buy_entityWithName:[[self class] entityName]];
}

+ (BOOL)tracksDirtyProperties
{
	return NO;
}

+ (BOOL)isPersistentClass
{
	return NO;
}

- (BOOL)isEqual:(id)object
{
	return [super isEqual:object] || [object isMemberOfClass:[self class]];
}

@end

#pragma mark - Models

@implementation Bird

+ (instancetype)birdWithIdentifier:(NSNumber *)identifier
{
	Bird *bird = [[self alloc] init];
	bird.identifier = identifier;
	return bird;
}

- (BOOL)isEqual:(Bird *)otherModel
{
	return ([super isEqual:otherModel] &&
			[self.identifier isEqual:otherModel.identifier] &&
			[self.colour isEqualToString:otherModel.colour]);
}

- (NSUInteger)hash
{
	NSUInteger hash = self.identifier.hash;
	hash = (hash << 5) ^ self.colour.hash;
	return hash;
}

@end

@implementation Branch

- (BOOL)isEqual:(Branch *)otherModel
{
	return ([super isEqual:otherModel] &&
			[self.ornaments isEqual:otherModel.ornaments] &&
			[self.leaves isEqual:otherModel.leaves]);
}

- (NSUInteger)hash
{
	NSUInteger hash = self.ornaments.hash;
	hash = (hash << 5) ^ self.leaves.hash;
	return hash;
}

@end

@implementation Forest

- (BOOL)isEqual:(Forest *)object
{
    return ([super isEqual:object] &&
            [self.trees isEqual:object.trees]);
}

- (NSUInteger)hash
{
    return self.trees.hash;
}

@end

@implementation Leaf

- (BOOL)isEqual:(Leaf *)object
{
	return ([super isEqual:object] &&
			[self.date isEqual:object.date] &&
			[self.tags isEqual:object.tags]);
}

- (NSUInteger)hash
{
	NSUInteger hash = self.date.hash;
	hash = (hash << 5) ^ self.tags.hash;
	return hash;
}

@end

@implementation Nest

- (BOOL)isEqual:(Nest *)object
{
	return ([super isEqual:object] &&
			[self.eggCount isEqual:object.eggCount] &&
			((self.bird == nil && object.bird == nil) || [self.bird isEqual:object.bird]));
}

- (NSUInteger)hash
{
	NSUInteger hash = self.eggCount.hash;
	if (self.bird) {
		hash = (hash << 5) ^ self.bird.hash;
	}
	return hash;
}

@end

@implementation Root

- (BOOL)isEqual:(Root *)object
{
	return ([super isEqual:object] &&
			[self.identifier isEqual:object.identifier] &&
			[self.age isEqual:object.age] &&
			[self.name isEqual:object.name] &&
			[self.url isEqual:object.url] &&
			[self.branches isEqual:object.branches]);
}

- (NSUInteger)hash
{
	NSUInteger hash = self.identifier.hash;
	hash = (hash << 5) ^ self.age.hash;
	hash = (hash << 5) ^ self.name.hash;
	hash = (hash << 5) ^ self.url.hash;
	hash = (hash << 5) ^ self.branches.hash;
	return hash;
}

@end

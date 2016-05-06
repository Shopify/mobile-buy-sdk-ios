//
//  BUYManagedObject.m
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

#import "BUYManagedObject.h"

#import "NSDictionary+BUYAdditions.h"
#import "NSException+BUYAdditions.h"

#import "NSEntityDescription+BUYAdditions.h"
#import "NSPropertyDescription+BUYAdditions.h"

#import <CoreData/CoreData.h>

#if defined CORE_DATA_PERSISTENCE

@interface NSManagedObjectContext (BUYPersistence)
@property (nonatomic, strong) BUYModelManager *modelManager;
@end

@implementation BUYManagedObject

- (NSDictionary *)JSONEncodedProperties
{
return self.entity.JSONEncodedProperties;
}

+ (BOOL)isPersistentClass
{
	return YES;
}

+ (BOOL)tracksDirtyProperties
{
	return NO;
}

+ (NSPredicate *)fetchPredicateWithJSON:(NSDictionary *)JSONDictionary
{
	return JSONDictionary[@"id"] ? [NSPredicate predicateWithFormat:@"identifier = %@", JSONDictionary[@"id"]] : nil;
}

+ (NSString *)entityName
{
	@throw BUYAbstractMethod();
}

- (BUYModelManager *)modelManager
{
	return self.managedObjectContext.modelManager;
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
	[self.entity buy_updateObject:self withJSON:JSONDictionary];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	return self.JSONDictionary;
}

@end

#else

@implementation BUYObject (BUYManagedObjectConformance)

- (void)willAccessValueForKey:(NSString *)key {}

- (void)didAccessValueForKey:(NSString *)key {}

- (id)primitiveValueForKey:(NSString *)key
{
	return [self valueForKey:key];
}

- (void)setPrimitiveValue:(id)value forKey:(NSString *)key
{
	[self setValue:value forKey:key];
}

@end
#endif

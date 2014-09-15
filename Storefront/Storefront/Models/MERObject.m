//
//  MERObject.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERObject.h"

@implementation MERObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		_identifier = dictionary[@"id"];
	}
	return self;
}

+ (NSArray*)convertJSONArray:(NSArray*)json toArrayOfClass:(Class)clazz block:(void (^)(id obj))createdBlock
{
	NSMutableArray *objects = [[NSMutableArray alloc] init];
	for (NSDictionary *jsonObject in json) {
		id obj = [[clazz alloc] initWithDictionary:jsonObject];
		[objects addObject:obj];
		if (createdBlock) {
			createdBlock(obj);
		}
	}
	return objects;
}

+ (NSArray*)convertJSONArray:(NSArray*)json toArrayOfClass:(Class)clazz
{
	return [MERObject convertJSONArray:json toArrayOfClass:clazz block:nil];
}

+ (id)convertObject:(id)object toMerObjectOfClass:(Class)clazz
{
	id convertedObject = nil;
	if (!(object == nil || [object isKindOfClass:[NSNull class]])) {
		convertedObject = [[clazz alloc] initWithDictionary:object];
	}
	return convertedObject;
}

@end

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
		[self updateWithDictionary:dictionary];
	}
	return self;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	_identifier = dictionary[@"id"];
}

+ (NSArray *)convertJSONArray:(NSArray*)json block:(void (^)(id obj))createdBlock
{
	NSMutableArray *objects = [[NSMutableArray alloc] init];
	for (NSDictionary *jsonObject in json) {
		MERObject *obj = [[self alloc] initWithDictionary:jsonObject];
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
	MERObject *convertedObject = nil;
	if (!(object == nil || [object isKindOfClass:[NSNull class]])) {
		convertedObject = [[self alloc] initWithDictionary:object];
	}
	return convertedObject;
}

@end

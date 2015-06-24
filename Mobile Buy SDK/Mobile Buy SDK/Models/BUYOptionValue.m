//
//  BUYOptionValue.m
//  CheckoutAnywhere
//
//  Created by David Muzi on 2015-05-19.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYOptionValue.h"

@implementation BUYOptionValue

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_name = [dictionary[@"name"] copy];
	_value = [dictionary[@"value"] copy];
	_optionId = [dictionary[@"option_id"] copy];
}

- (BOOL)isEqual:(id)object
{
	if (self == object) return YES;
	
	if (![object isKindOfClass:self.class]) return NO;
	
	BOOL same = ([self.optionId isEqualToNumber:[object optionId]] &&
				 [self.value isEqualToString:[object value]]);
	
	return same;
}

- (NSUInteger)hash
{
	NSUInteger hash = [self.value hash];
	hash ^= [self.optionId hash];
	return hash;
}

@end

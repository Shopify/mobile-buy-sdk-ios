//
//  BUYCartLineItem.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-22.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYCartLineItem.h"

@interface BUYCartLineItem ()

@property (nonatomic, strong) BUYProductVariant *variant;

@end

@implementation BUYCartLineItem

- (instancetype)initWithVariant:(BUYProductVariant *)variant
{
	self = [super initWithVariant:variant];
	if (self) {
		self.variant = variant;
	}
	return self;
}

- (BOOL)isEqual:(id)object
{
	if (self == object) return YES;
	
	if (![object isKindOfClass:self.class]) return NO;
	
	BOOL same = ([self.identifier isEqual:((BUYObject*)object).identifier]) || [self.variantId isEqual:((BUYCartLineItem*)object).variant.identifier];

	return same;
}

- (NSUInteger)hash
{
	NSUInteger hash = [self.identifier hash];
	return hash;
}

@end

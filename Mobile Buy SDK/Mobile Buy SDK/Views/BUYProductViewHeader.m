//
//  BUYProductViewHeader.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewHeader.h"

@implementation BUYProductViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor redColor];
	}
	return self;
}

- (void)setContentOffset:(CGPoint)offset
{
	
}

@end

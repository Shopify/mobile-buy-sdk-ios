//
//  BUYVariantOptionBreadCrumbsView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-09-03.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYVariantOptionBreadCrumbsView.h"

@interface BUYVariantOptionBreadCrumbsView ()

@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UILabel *optionOneLabel;
@property (nonatomic, strong) UILabel *optionTwoLabel;

@end

@implementation BUYVariantOptionBreadCrumbsView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor redColor];
	}
	return self;
}

@end

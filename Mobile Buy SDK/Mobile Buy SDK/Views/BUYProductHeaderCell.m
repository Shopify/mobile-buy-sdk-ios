//
//  BUYProductHeaderCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductHeaderCell.h"

@implementation BUYProductHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.textColor = [UIColor blackColor];
		_titleLabel.numberOfLines = 2;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_titleLabel];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.textColor = self.tintColor;
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_priceLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_priceLabel, _titleLabel);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-(>=10)-[_priceLabel]-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:views]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_priceLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
		
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_priceLabel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
}

- (void)tintColorDidChange
{
	[super tintColorDidChange];
	
	self.priceLabel.textColor = self.tintColor;
}

@end

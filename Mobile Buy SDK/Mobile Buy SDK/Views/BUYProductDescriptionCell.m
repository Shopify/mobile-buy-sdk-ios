//
//  BUYProductDescriptionCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductDescriptionCell.h"

@interface BUYProductDescriptionCell ()
@end

@implementation BUYProductDescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		_descriptionLabel = [[UILabel alloc] init];
		_descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_descriptionLabel.backgroundColor = [UIColor whiteColor];
		_descriptionLabel.numberOfLines = 0;
		_descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
		_descriptionLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
		[self.contentView addSubview:self.descriptionLabel];

		NSDictionary *views = NSDictionaryOfVariableBindings(_descriptionLabel);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_descriptionLabel]|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_descriptionLabel]|" options:0 metrics:nil views:views]];

		
	}
	
	return self;
}



@end

//
//  BUYProductVariantCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductVariantCell.h"
#import "BUYVariantOptionView.h"
#import "BUYProductVariant.h"
#import "BUYOptionValue.h"
#import "BUYImageKit.h"

@interface BUYProductVariantCell ()
@property (nonatomic, strong) BUYVariantOptionView *optionView1;
@property (nonatomic, strong) BUYVariantOptionView *optionView2;
@property (nonatomic, strong) BUYVariantOptionView *optionView3;
@property (nonatomic, strong) NSArray *disclosureConstraints;
@property (nonatomic, strong) NSArray *noDisclosureConstraints;
@property (nonatomic, strong) UIImageView *disclosureIndicatorImageView;
@property (nonatomic, strong) BUYTheme *theme;
@end

@implementation BUYProductVariantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.layoutMargins = UIEdgeInsetsMake([BUYTheme paddingMedium], self.layoutMargins.left, [BUYTheme paddingMedium], self.layoutMargins.right);

		UIView *backgroundView = [[UIView alloc] init];
		[self setSelectedBackgroundView:backgroundView];
		
		_optionView1 = [[BUYVariantOptionView alloc] init];
		_optionView1.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_optionView1];
		
		_optionView2 = [[BUYVariantOptionView alloc] init];
		_optionView2.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_optionView2];
		
		_optionView3 = [[BUYVariantOptionView alloc] init];
		_optionView3.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_optionView3];
		
		_disclosureIndicatorImageView = [[UIImageView alloc] init];
		_disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_disclosureIndicatorImageView];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_optionView1, _optionView2, _optionView3, _disclosureIndicatorImageView);
		
		NSDictionary *metricsDictionary = @{ @"paddingBlue" : [NSNumber numberWithDouble:[BUYTheme paddingLarge]], @"paddingRed" : [NSNumber numberWithDouble:[BUYTheme paddingSmall]] };
		
		self.disclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_optionView1]-(paddingBlue)-[_optionView2]-(paddingBlue)-[_optionView3]-(>=paddingRed)-[_disclosureIndicatorImageView]-|" options:0 metrics:metricsDictionary views:views];
		self.noDisclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_optionView1]-(paddingBlue)-[_optionView2]-(paddingBlue)-[_optionView3]-(>=paddingRed)-|" options:0 metrics:metricsDictionary views:views];
		
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionView1]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionView2]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionView3]-|" options:0 metrics:nil views:views]];
		
		[self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:_disclosureIndicatorImageView
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:_disclosureIndicatorImageView.superview
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.0f
																	   constant:0.0f]];
	}

	return self;
}

- (void)setProductVariant:(BUYProductVariant *)productVariant
{
	_productVariant = productVariant;

	NSArray *productOptions = productVariant.options;
	
	switch (productVariant.options.count) {
		case 3:
			[self.optionView3 setTextForOptionValue:productOptions[2]];
			[self.optionView2 setTextForOptionValue:productOptions[1]];
			[self.optionView1 setTextForOptionValue:productOptions[0]];
			break;
		
		case 2:
			[self.optionView3 setTextForOptionValue:nil];
			[self.optionView2 setTextForOptionValue:productOptions[1]];
			[self.optionView1 setTextForOptionValue:productOptions[0]];
			break;
			
		case 1:
			[self.optionView3 setTextForOptionValue:nil];
			[self.optionView2 setTextForOptionValue:nil];
			[self.optionView1 setTextForOptionValue:productOptions[0]];
			break;
		
		default:
			break;
		}
}

-(void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
	self.disclosureIndicatorImageView.hidden = accessoryType != UITableViewCellAccessoryDisclosureIndicator;
	if (accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		self.selectionStyle = UITableViewCellSelectionStyleDefault;
		[NSLayoutConstraint activateConstraints:self.disclosureConstraints];
		[NSLayoutConstraint deactivateConstraints:self.noDisclosureConstraints];
	} else {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[NSLayoutConstraint deactivateConstraints:self.disclosureConstraints];
		[NSLayoutConstraint activateConstraints:self.noDisclosureConstraints];
	}
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.backgroundColor = [theme backgroundColor];
	self.selectedBackgroundView.backgroundColor = [theme selectedBackgroundColor];
	self.disclosureIndicatorImageView.image = [BUYImageKit imageOfDisclosureIndicatorImageWithFrame:CGRectMake(0, 0, 10, 16) color:[theme disclosureIndicatorColor]];
	
	[self.optionView1 setTheme:theme];
	[self.optionView2 setTheme:theme];
	[self.optionView3 setTheme:theme];
}

@end

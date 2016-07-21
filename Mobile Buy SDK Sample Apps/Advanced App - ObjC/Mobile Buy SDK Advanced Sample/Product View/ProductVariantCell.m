//
//  ProductVariantCell.m
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

#import "DisclosureIndicatorView.h"
#import "ImageKit.h"
#import "ProductVariantCell.h"
#import "Theme+Additions.h"
#import "VariantOptionView.h"

@interface ProductVariantCell ()

@property (nonatomic, strong) VariantOptionView *optionView1;
@property (nonatomic, strong) VariantOptionView *optionView2;
@property (nonatomic, strong) VariantOptionView *optionView3;
@property (nonatomic, strong) NSArray *disclosureConstraints;
@property (nonatomic, strong) NSArray *noDisclosureConstraints;
@property (nonatomic, strong) DisclosureIndicatorView *disclosureIndicatorImageView;

@end

@implementation ProductVariantCell

CGFloat const buttonWidth = 10.0f;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingMedium, self.layoutMargins.left, kBuyPaddingMedium, self.layoutMargins.right);

		UIView *backgroundView = [[UIView alloc] init];
		[self setSelectedBackgroundView:backgroundView];
		
		_optionView1 = [[VariantOptionView alloc] init];
		_optionView1.translatesAutoresizingMaskIntoConstraints = NO;
		[_optionView1 setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:_optionView1];
		
		_optionView2 = [[VariantOptionView alloc] init];
		_optionView2.translatesAutoresizingMaskIntoConstraints = NO;
		[_optionView3 setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:_optionView2];
		
		_optionView3 = [[VariantOptionView alloc] init];
		_optionView3.translatesAutoresizingMaskIntoConstraints = NO;
		[_optionView3 setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:_optionView3];
		
		_disclosureIndicatorImageView = [[DisclosureIndicatorView alloc] init];
		_disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_disclosureIndicatorImageView];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_optionView1, _optionView2, _optionView3, _disclosureIndicatorImageView);
		
		NSDictionary *metricsDictionary = @{ @"paddingExtraLarge" : @(kBuyPaddingExtraLarge), @"paddingSmall" : @(kBuyPaddingSmall), @"buttonWidth" : @(buttonWidth) };
		
		self.disclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_optionView1]-(paddingExtraLarge)-[_optionView2]-(paddingExtraLarge)-[_optionView3]-(>=paddingSmall)-[_disclosureIndicatorImageView(buttonWidth)]-|" options:0 metrics:metricsDictionary views:views];
		self.noDisclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_optionView1]-(paddingExtraLarge)-[_optionView2]-(paddingExtraLarge)-[_optionView3]-(>=paddingSmall)-|" options:0 metrics:metricsDictionary views:views];
		
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

- (void)setOptionsForProductVariant:(BUYProductVariant *)productVariant
{
	NSArray *productOptions = [productVariant.options allObjects];
	
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
		[NSLayoutConstraint deactivateConstraints:self.noDisclosureConstraints];
		[NSLayoutConstraint activateConstraints:self.disclosureConstraints];
	} else {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[NSLayoutConstraint deactivateConstraints:self.disclosureConstraints];
		[NSLayoutConstraint activateConstraints:self.noDisclosureConstraints];
	}
}

- (void)setSelectedBackgroundViewBackgroundColor:(UIColor *)selectedBackgroundViewBackgroundColor
{
	self.selectedBackgroundView.backgroundColor = selectedBackgroundViewBackgroundColor;
}

@end

//
//  BUYProductView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductView.h"
#import "BUYProductViewHeader.h"
#import "BUYProductViewHeaderBackgroundImageView.h"
#import "BUYProductViewFooter.h"
#import "BUYGradientView.h"
#import "BUYTheme.h"
#import "BUYProductVariantCell.h"
#import "BUYProductDescriptionCell.h"
#import "BUYProductHeaderCell.h"
#import "BUYImage.h"
#import "BUYImageView.h"

@implementation BUYProductView

- (instancetype)initWithTheme:(BUYTheme*)theme
{
	self = [super init];
	if (self) {
		self.theme = theme;
		
		self.productViewHeader = [[BUYProductViewHeader alloc] init];
		[self.productViewHeader.productImageView setTheme:self.theme];
		
		self.backgroundImageView = [[BUYProductViewHeaderBackgroundImageView alloc] initWithTheme:theme];
		self.backgroundImageView.hidden = self.theme.showsProductImageBackground == NO;
		self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.backgroundImageView];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView
															  attribute:NSLayoutAttributeHeight
															  relatedBy:NSLayoutRelationEqual
																 toItem:self
															  attribute:NSLayoutAttributeHeight
															 multiplier:1.0
															   constant:0.0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView
															  attribute:NSLayoutAttributeWidth
															  relatedBy:NSLayoutRelationEqual
																 toItem:self
															  attribute:NSLayoutAttributeWidth
															 multiplier:1.0
															   constant:0.0]];
		
		self.stickyFooterView = [UIView new];
		self.stickyFooterView.backgroundColor = (self.theme.style == BUYThemeStyleDark) ? [UIColor blackColor] : [UIColor whiteColor];
		self.stickyFooterView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.stickyFooterView];
		
		self.footerHeightLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.stickyFooterView
																		 attribute:NSLayoutAttributeHeight
																		 relatedBy:NSLayoutRelationEqual
																			toItem:nil
																		 attribute:NSLayoutAttributeNotAnAttribute
																		multiplier:1.0
																		  constant:0.0];
		[self addConstraint:self.footerHeightLayoutConstraint];
		
		self.footerOffsetLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.stickyFooterView
																		 attribute:NSLayoutAttributeTop
																		 relatedBy:NSLayoutRelationEqual
																			toItem:self
																		 attribute:NSLayoutAttributeBottom
																		multiplier:1.0
																		  constant:0.0];
		[self addConstraint:self.footerOffsetLayoutConstraint];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.stickyFooterView
															  attribute:NSLayoutAttributeWidth
															  relatedBy:NSLayoutRelationEqual
																 toItem:self
															  attribute:NSLayoutAttributeWidth
															 multiplier:1.0
															   constant:0.0]];
		
		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		self.tableView.backgroundColor = [UIColor clearColor];
		self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
		self.tableView.estimatedRowHeight = 60.0;
		self.tableView.rowHeight = UITableViewAutomaticDimension;
		self.tableView.tableFooterView = [UIView new];
		self.tableView.layoutMargins = UIEdgeInsetsMake(0, 16, 0, 12);
		[self addSubview:self.tableView];
		
		[self.tableView registerClass:[BUYProductHeaderCell class] forCellReuseIdentifier:@"headerCell"];
		[self.tableView registerClass:[BUYProductVariantCell class] forCellReuseIdentifier:@"variantCell"];
		[self.tableView registerClass:[BUYProductDescriptionCell class] forCellReuseIdentifier:@"descriptionCell"];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
																		  options:0
																		  metrics:nil
																			views:NSDictionaryOfVariableBindings(_tableView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
																		  options:0
																		  metrics:nil
																			views:NSDictionaryOfVariableBindings(_tableView)]];
		
		[self.productViewHeader setFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetWidth([[UIScreen mainScreen] bounds]))];
		self.tableView.tableHeaderView = self.productViewHeader;
		
		self.productViewFooter = [[BUYProductViewFooter alloc] initWithTheme:self.theme];
		self.productViewFooter.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.productViewFooter];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productViewFooter]|"
																		  options:0
																		  metrics:nil
																			views:NSDictionaryOfVariableBindings(_productViewFooter)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_productViewFooter(60)]|"
																		  options:0
																		  metrics:nil
																			views:NSDictionaryOfVariableBindings(_productViewFooter)]];
		
		self.topGradientView = [[BUYGradientView alloc] init];
		self.topGradientView.topColor = [UIColor colorWithWhite:0 alpha:0.25f];
		self.topGradientView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.topGradientView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topGradientView]|"
																		  options:0
																		  metrics:nil
																			views:NSDictionaryOfVariableBindings(_topGradientView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topGradientView(height)]"
																		  options:0
																		  metrics:@{ @"height" : @114 }
																			views:NSDictionaryOfVariableBindings(_topGradientView)]];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, self.tableView.contentInset.left, CGRectGetHeight(self.productViewFooter.frame), self.tableView.contentInset.right);
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.tintColor = _theme.tintColor;
	UIColor *backgroundColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(64, 64, 64) : BUY_RGB(229, 229, 229);
	self.stickyFooterView.backgroundColor = (_theme.style == BUYThemeStyleDark) ? [UIColor blackColor] : [UIColor whiteColor];;
	self.backgroundColor = backgroundColor;
	self.backgroundImageView.hidden = _theme.showsProductImageBackground == NO;
	[self.productViewHeader.productImageView setTheme:_theme];
}

- (void)setProductImage:(BUYImage *)image
{
	if (self.productViewHeader && image) {
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", image.src]];
		[self.productViewHeader.productImageView loadImageWithURL:url
													   completion:^(UIImage *image, NSError *error) {
														   if (self.backgroundImageView.productImageView.image) {
															   [UIView transitionWithView:self.backgroundImageView.productImageView
																				 duration:imageDuration
																				  options:UIViewAnimationOptionTransitionCrossDissolve
																			   animations:^{
																				   self.backgroundImageView.productImageView.image = image;
																			   }
																			   completion:nil];
														   } else {
															   self.backgroundImageView.productImageView.alpha = 0.0f;
															   self.backgroundImageView.productImageView.image = image;
															   [UIView animateWithDuration:imageDuration
																				animations:^{
																					self.backgroundImageView.productImageView.alpha = 1.0f;
																				}];
														   }
														   [self.productViewHeader setContentOffset:self.tableView.contentOffset];
													   }];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.productViewHeader setContentOffset:scrollView.contentOffset];
	CGFloat footerViewHeight = self.bounds.size.height - self.productViewHeader.productImageViewConstraintHeight.constant;
	if (scrollView.contentOffset.y > 0) {
		footerViewHeight += scrollView.contentOffset.y;
	}
	if (footerViewHeight <= 0) {
		footerViewHeight = 0;
	}
	self.footerHeightLayoutConstraint.constant = footerViewHeight;
	self.footerOffsetLayoutConstraint.constant = -footerViewHeight;
}

@end

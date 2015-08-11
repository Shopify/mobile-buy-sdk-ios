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

- (instancetype)initWithFrame:(CGRect)rect theme:(BUYTheme*)theme;
{
	self = [super initWithFrame:rect];
	if (self) {
		self.theme = theme;
		
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
		CGFloat width = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect));
		self.productViewHeader = [[BUYProductViewHeader alloc] initWithFrame:CGRectMake(0, 0, width, width) theme:self.theme];
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
		self.topGradientView.userInteractionEnabled = NO;
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
	self.stickyFooterView.backgroundColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(26, 26, 26) : [UIColor whiteColor];
	self.tableView.separatorColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(76, 76, 76) : BUY_RGB(217, 217, 217);
	self.backgroundColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(26, 26, 26) : BUY_RGB(255, 255, 255);
	self.backgroundImageView.hidden = _theme.showsProductImageBackground == NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat imageHeight = [self.productViewHeader imageHeightWithScrollViewDidScroll:scrollView];
	CGFloat footerViewHeight = self.bounds.size.height - imageHeight;
	if (scrollView.contentOffset.y > 0) {
		footerViewHeight += scrollView.contentOffset.y;
	}
	if (footerViewHeight <= 0) {
		footerViewHeight = 0;
	}
	self.footerHeightLayoutConstraint.constant = footerViewHeight;
	self.footerOffsetLayoutConstraint.constant = -footerViewHeight;
	
	CGFloat opaqueOffset = CGRectGetHeight(self.productViewHeader.bounds);
	CGFloat whiteStartingOffset = opaqueOffset - CGRectGetHeight(self.topGradientView.bounds);
	self.topGradientView.alpha = -(scrollView.contentOffset.y - whiteStartingOffset) / (opaqueOffset - whiteStartingOffset);
}

@end

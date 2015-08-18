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
#import "BUYProductVariantCell.h"
#import "BUYProductDescriptionCell.h"
#import "BUYProductHeaderCell.h"
#import "BUYImage.h"
#import "BUYImageView.h"
#import "BUYProductViewErrorView.h"
#import "BUYTheme.h"
#import "BUYTheme+Additions.h"

@interface BUYProductView ()

@property (nonatomic, strong) UILabel *poweredByShopifyLabel;
@property (nonatomic, strong) NSLayoutConstraint *poweredByShopifyLabelConstraint;
@property (nonatomic, strong) BUYProductViewErrorView *errorView;

@end

@implementation BUYProductView

- (instancetype)initWithFrame:(CGRect)rect theme:(BUYTheme*)theme;
{
	self = [super initWithFrame:rect];
	if (self) {
		self.backgroundImageView = [[BUYProductViewHeaderBackgroundImageView alloc] initWithTheme:theme];
		self.backgroundImageView.hidden = theme.showsProductImageBackground == NO;
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
		self.stickyFooterView.backgroundColor = [theme backgroundColor];
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
		self.tableView.layoutMargins = UIEdgeInsetsMake(0, [BUYTheme paddingBlue], 0, [BUYTheme paddingPurple]);
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
		self.productViewHeader = [[BUYProductViewHeader alloc] initWithFrame:CGRectMake(0, 0, width, width) theme:theme];
		self.tableView.tableHeaderView = self.productViewHeader;
		
		_poweredByShopifyLabel = [[UILabel alloc] init];
		_poweredByShopifyLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_poweredByShopifyLabel.backgroundColor = [UIColor clearColor];
		_poweredByShopifyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
		_poweredByShopifyLabel.text = @"Powered by Shopify";
		_poweredByShopifyLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_poweredByShopifyLabel];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_poweredByShopifyLabel]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_poweredByShopifyLabel)]];
		
		_poweredByShopifyLabelConstraint = [NSLayoutConstraint constraintWithItem:_poweredByShopifyLabel
																		attribute:NSLayoutAttributeTop
																		relatedBy:NSLayoutRelationEqual
																		   toItem:self
																		attribute:NSLayoutAttributeBottom
																	   multiplier:1.0
																		 constant:0.0];
		[self addConstraint:_poweredByShopifyLabelConstraint];
		
		self.productViewFooter = [[BUYProductViewFooter alloc] initWithTheme:theme];
		self.productViewFooter.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.productViewFooter];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productViewFooter]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_productViewFooter)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_productViewFooter(height)]|"
																	 options:0
																	 metrics:@{ @"height" : [NSNumber numberWithDouble:[BUYTheme productFooterHeight]] }
																	   views:NSDictionaryOfVariableBindings(_productViewFooter)]];
		
		self.topGradientView = [[BUYGradientView alloc] init];
		self.topGradientView.topColor = [BUYTheme topGradientViewTopColor];
		self.topGradientView.translatesAutoresizingMaskIntoConstraints = NO;
		self.topGradientView.userInteractionEnabled = NO;
		[self addSubview:self.topGradientView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topGradientView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_topGradientView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topGradientView(height)]"
																	 options:0
																	 metrics:@{ @"height" : [NSNumber numberWithDouble:[BUYTheme topGradientViewHeight]] }
																	   views:NSDictionaryOfVariableBindings(_topGradientView)]];
		
		self.theme = theme;
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
	self.tableView.separatorColor = [theme separatorColor];
	self.backgroundColor = [theme backgroundColor];
	self.stickyFooterView.backgroundColor = self.backgroundColor;
	self.backgroundImageView.hidden = theme.showsProductImageBackground == NO;
	self.poweredByShopifyLabel.textColor = self.tableView.separatorColor;
}

- (void)updateBackgroundImage:(NSArray *)images
{
	if ([images count] > 0) {
		NSInteger page = 0;
		if (CGSizeEqualToSize(self.productViewHeader.collectionView.contentSize, CGSizeZero) == NO) {
			page = (int)(self.productViewHeader.collectionView.contentOffset.x / self.productViewHeader.collectionView.frame.size.width);
		}
		[self.productViewHeader setCurrentPage:page];
		BUYImage *image = images[page];
		[self.backgroundImageView setBackgroundProductImage:image];
	}
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
	
	CGFloat labelOffset = scrollView.contentSize.height - (scrollView.contentOffset.y + CGRectGetHeight(scrollView.bounds));
	self.poweredByShopifyLabelConstraint.constant = (CGRectGetHeight(scrollView.bounds) / 3) + labelOffset;
}

#pragma mark - Error Handling

- (BUYProductViewErrorView *)errorView
{
	if (_errorView == nil) {
		_errorView = [[BUYProductViewErrorView alloc] initWithTheme:self.theme];
		_errorView.alpha = 0;
		_errorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self insertSubview:_errorView belowSubview:self.productViewFooter];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_errorView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_errorView)]];
		
		_errorView.hiddenConstraint = [NSLayoutConstraint constraintWithItem:_errorView
																   attribute:NSLayoutAttributeTop
																   relatedBy:NSLayoutRelationEqual
																	  toItem:self
																   attribute:NSLayoutAttributeBottom
																  multiplier:1.0
																	constant:0.0];
		[self addConstraint:_errorView.hiddenConstraint];
		
		_errorView.visibleConstraint = [NSLayoutConstraint constraintWithItem:_errorView
																	attribute:NSLayoutAttributeBottom
																	relatedBy:NSLayoutRelationEqual
																	   toItem:self.productViewFooter
																	attribute:NSLayoutAttributeTop
																   multiplier:1.0
																	 constant:0.0];
		
		[NSLayoutConstraint activateConstraints:@[_errorView.hiddenConstraint]];
		[_errorView layoutIfNeeded];
	}
	return _errorView;
}

- (void)showErrorWithMessage:(NSString*)errorMessage
{
	self.errorView.errorLabel.text = errorMessage;
	[NSLayoutConstraint deactivateConstraints:@[self.errorView.hiddenConstraint]];
	[NSLayoutConstraint activateConstraints:@[self.errorView.visibleConstraint]];
	[UIView animateWithDuration:0.3f
						  delay:0
		 usingSpringWithDamping:0.8f
		  initialSpringVelocity:10
						options:0
					 animations:^{
						 self.errorView.alpha = 1;
						 [self.errorView layoutIfNeeded];
					 }
					 completion:^(BOOL finished) {
						 [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeErrorView) userInfo:nil repeats:NO];
					 }];
}

- (void)removeErrorView
{
	[NSLayoutConstraint deactivateConstraints:@[self.errorView.visibleConstraint]];
	[NSLayoutConstraint activateConstraints:@[self.errorView.hiddenConstraint]];
	[UIView animateWithDuration:0.3f
					 animations:^{
						 self.errorView.alpha = 0;
						 [self.errorView layoutIfNeeded];
					 }
					 completion:^(BOOL finished) {
						 [self.errorView removeFromSuperview];
						 self.errorView = nil;
					 }];
}

@end

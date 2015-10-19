//
//  BUYProductView.m
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
#import "BUYProduct.h"
#import "BUYProductViewErrorView.h"
#import "BUYTheme.h"
#import "BUYTheme+Additions.h"

@interface BUYProductView ()

@property (nonatomic, strong) UILabel *poweredByShopifyLabel;
@property (nonatomic, strong) NSLayoutConstraint *poweredByShopifyLabelConstraint;
@property (nonatomic, strong) BUYProductViewErrorView *errorView;
@property (nonatomic, strong) NSLayoutConstraint *topInsetConstraint;

@end

@implementation BUYProductView

- (instancetype)initWithFrame:(CGRect)rect product:(BUYProduct*)product theme:(BUYTheme*)theme shouldShowApplePaySetup:(BOOL)showApplePaySetup
{
	self = [super initWithFrame:rect];
	if (self) {
		_backgroundImageView = [[BUYProductViewHeaderBackgroundImageView alloc] initWithTheme:theme];
		_backgroundImageView.hidden = theme.showsProductImageBackground == NO;
		_backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_backgroundImageView];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView
														 attribute:NSLayoutAttributeHeight
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeHeight
														multiplier:1.0
														  constant:0.0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeWidth
														multiplier:1.0
														  constant:0.0]];
		
		_stickyFooterView = [UIView new];
		_stickyFooterView.backgroundColor = [theme backgroundColor];
		_stickyFooterView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_stickyFooterView];
		
		_footerHeightLayoutConstraint = [NSLayoutConstraint constraintWithItem:_stickyFooterView
																	 attribute:NSLayoutAttributeHeight
																	 relatedBy:NSLayoutRelationEqual
																		toItem:nil
																	 attribute:NSLayoutAttributeNotAnAttribute
																	multiplier:1.0
																	  constant:0.0];
		[self addConstraint:_footerHeightLayoutConstraint];
		
		_footerOffsetLayoutConstraint = [NSLayoutConstraint constraintWithItem:_stickyFooterView
																	 attribute:NSLayoutAttributeTop
																	 relatedBy:NSLayoutRelationEqual
																		toItem:self
																	 attribute:NSLayoutAttributeBottom
																	multiplier:1.0
																	  constant:0.0];
		[self addConstraint:_footerOffsetLayoutConstraint];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_stickyFooterView
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeWidth
														multiplier:1.0
														  constant:0.0]];
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		_tableView.backgroundColor = [UIColor clearColor];
		_tableView.translatesAutoresizingMaskIntoConstraints = NO;
		_tableView.estimatedRowHeight = 60.0;
		_tableView.rowHeight = UITableViewAutomaticDimension;
		_tableView.tableFooterView = [UIView new];
		_tableView.layoutMargins = UIEdgeInsetsMake(_tableView.layoutMargins.top, kBuyPaddingExtraLarge, _tableView.layoutMargins.bottom, kBuyPaddingMedium);
		[self addSubview:_tableView];
		
		[_tableView registerClass:[BUYProductHeaderCell class] forCellReuseIdentifier:@"headerCell"];
		[_tableView registerClass:[BUYProductVariantCell class] forCellReuseIdentifier:@"variantCell"];
		[_tableView registerClass:[BUYProductDescriptionCell class] forCellReuseIdentifier:@"descriptionCell"];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_tableView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_tableView)]];
		
		_topInsetConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
														   attribute:NSLayoutAttributeTop
														   relatedBy:NSLayoutRelationEqual
															  toItem:self
														   attribute:NSLayoutAttributeTop
														  multiplier:1.0
															constant:0];
		[self addConstraint:_topInsetConstraint];
		
		CGFloat size = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect));
		if ([product.images count] > 0) {
			_productViewHeader = [[BUYProductViewHeader alloc] initWithFrame:CGRectMake(0, 0, size, size) theme:theme];
			_tableView.tableHeaderView = self.productViewHeader;
		} else {
			_tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
		}
		
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
		
		_productViewFooter = [[BUYProductViewFooter alloc] initWithTheme:theme showApplePaySetup:showApplePaySetup];
		_productViewFooter.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_productViewFooter];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productViewFooter]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_productViewFooter)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_productViewFooter]-|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_productViewFooter)]];
		
		if (_productViewHeader) {
			_topGradientView = [[BUYGradientView alloc] init];
			_topGradientView.topColor = [BUYTheme topGradientViewTopColor];
			_topGradientView.translatesAutoresizingMaskIntoConstraints = NO;
			_topGradientView.userInteractionEnabled = NO;
			[self addSubview:_topGradientView];
			
			[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topGradientView]|"
																		 options:0
																		 metrics:nil
																		   views:NSDictionaryOfVariableBindings(_topGradientView)]];
			[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topGradientView(height)]"
																		 options:0
																		 metrics:@{ @"height" : @(kBuyTopGradientViewHeight) }
																		   views:NSDictionaryOfVariableBindings(_topGradientView)]];
		}
		
		self.theme = theme;
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self setInsets:UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, CGRectGetHeight(self.bounds) - CGRectGetMinY(self.productViewFooter.frame), self.tableView.contentInset.right) appendToCurrentInset:NO];
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
	CGFloat imageHeight = 0;
	if (self.productViewHeader) {
		imageHeight = [self.productViewHeader imageHeightWithScrollViewDidScroll:scrollView];
	}
	CGFloat footerViewHeight = self.bounds.size.height - imageHeight;
	if (scrollView.contentOffset.y > 0) {
		footerViewHeight += scrollView.contentOffset.y;
	}
	if (footerViewHeight <= 0) {
		footerViewHeight = 0;
	}
	
	// Add the top inset for the navigation bar (when pushed in a navigation controller stack, not presented)
	footerViewHeight += -self.topInsetConstraint.constant;
	
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

- (void)setInsets:(UIEdgeInsets)edgeInsets appendToCurrentInset:(BOOL)appendToCurrentInset
{
	CGFloat top = appendToCurrentInset ? self.tableView.contentInset.top + edgeInsets.top : edgeInsets.top;
	CGFloat left = appendToCurrentInset ? self.tableView.contentInset.left + edgeInsets.left : edgeInsets.left;
	CGFloat bottom = appendToCurrentInset ? self.tableView.contentInset.bottom + edgeInsets.bottom : edgeInsets.bottom;
	CGFloat right = appendToCurrentInset ? self.tableView.contentInset.right + edgeInsets.right : edgeInsets.right;
	self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, left, bottom, right);
}

- (void)setTopInset:(CGFloat)topInset
{
	self.topInsetConstraint.constant = topInset;
}

@end

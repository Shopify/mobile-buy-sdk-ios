//
//  ProductView.m
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

#import "ProductView.h"
#import "ProductViewHeader.h"
#import "HeaderBackgroundView.h"
#import "ActionableFooterView.h"
#import "GradientView.h"
#import "ProductVariantCell.h"
#import "ProductDescriptionCell.h"
#import "ProductHeaderCell.h"
#import "AsyncImageView.h"
#import "ErrorView.h"
#import "Theme+Additions.h"

@interface ProductView ()

@property (nonatomic, strong) ErrorView *errorView;
@property (nonatomic, strong) NSLayoutConstraint *topInsetConstraint;

@end

@implementation ProductView

- (instancetype)initWithFrame:(CGRect)rect product:(BUYProduct*)product shouldShowApplePaySetup:(BOOL)showApplePaySetup
{
	self = [super initWithFrame:rect];
	if (self) {
		_backgroundImageView = [[HeaderBackgroundView alloc] init];
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
		
		[_tableView registerClass:[ProductHeaderCell class] forCellReuseIdentifier:@"headerCell"];
		[_tableView registerClass:[ProductVariantCell class] forCellReuseIdentifier:@"variantCell"];
		[_tableView registerClass:[ProductDescriptionCell class] forCellReuseIdentifier:@"descriptionCell"];
		
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
			_productViewHeader = [[ProductViewHeader alloc] initWithFrame:CGRectMake(0, 0, size, size)];
			_tableView.tableHeaderView = self.productViewHeader;
		} else {
			_tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
		}
		
		_productViewFooter = [ActionableFooterView new];
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
			_topGradientView = [[GradientView alloc] init];
			_topGradientView.topColor = [Theme topGradientViewTopColor];
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
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self setInsets:UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, CGRectGetHeight(self.bounds) - CGRectGetMinY(self.productViewFooter.frame), self.tableView.contentInset.right) appendToCurrentInset:NO];
}

- (void)updateBackgroundImage:(NSArray *)images
{
	if ([images count] > 0) {
		NSInteger page = 0;
		if (CGSizeEqualToSize(self.productViewHeader.collectionView.contentSize, CGSizeZero) == NO) {
			page = (int)(self.productViewHeader.collectionView.contentOffset.x / self.productViewHeader.collectionView.frame.size.width);
		}
		[self.productViewHeader setCurrentPage:page];
		BUYImageLink *image = images[page];
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
}

#pragma mark - Error Handling

- (ErrorView *)errorView
{
	if (_errorView == nil) {
		_errorView = [[ErrorView alloc] init];
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
	[self.errorView presentErrorViewWithMessage:errorMessage completion:^{
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

#pragma mark - Appearance

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	[super setBackgroundColor:backgroundColor];
	_stickyFooterView.backgroundColor = backgroundColor;
}

- (void)setShowsProductImageBackground:(BOOL)showsProductImageBackground
{
	_backgroundImageView.hidden = showsProductImageBackground == NO;
}

@end

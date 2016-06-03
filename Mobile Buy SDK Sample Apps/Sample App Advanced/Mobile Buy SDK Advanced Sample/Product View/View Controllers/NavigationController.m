//
//  NavigationController.m
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

#import "NavigationController.h"

static CGFloat const kSeperatorVisibilityCurve = 0.01f;
static void *kObservationContext = &kObservationContext;

@interface NavigationController() <UINavigationBarDelegate>
@property (strong, nonatomic) UIView *separatorMask;
@property (readonly) UIScrollView *scrollView;
@end

@implementation NavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	if (self) {
		UINavigationBar *navigationBar = self.navigationBar;
		self.separatorMask = [UIView new];
		self.separatorMask.backgroundColor = [UIColor whiteColor];
		self.separatorMask.hidden = YES;
		[navigationBar addSubview:self.separatorMask];
	}
	return self;
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	CGFloat height = 1.0f / [UIScreen mainScreen].scale;
	UINavigationBar *navigationBar = self.navigationBar;
	 self.separatorMask.frame = CGRectMake(CGRectGetMinX(navigationBar.bounds), CGRectGetMaxY(navigationBar.bounds), CGRectGetWidth(navigationBar.bounds), height);
}

- (void)setAutomaticallyMasksSeparator:(BOOL)automaticallyMasksSeparator
{
	self.separatorMask.hidden = !automaticallyMasksSeparator;
}

- (void)dealloc
{
	[self.scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
}

- (UIScrollView *)scrollView
{
    UIView *view = [self.topViewController isViewLoaded] ? self.topViewController.view : nil;
	if ([view isKindOfClass:[UIScrollView class]]) {
		return (id)view;
	} else {
		return [view.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
			return [evaluatedObject isKindOfClass:[UIScrollView class]];
		}]].firstObject;
	}
}

- (CGFloat)seperatorAlphaWithOffset:(CGFloat)offset
{
	CGFloat alpha = offset + CGRectGetMaxY(self.navigationBar.frame);
	alpha *= kSeperatorVisibilityCurve;
	return 1.0f - alpha;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
	if (context == kObservationContext) {
		UIScrollView *scrollView = object;
		if (scrollView != self.scrollView) {
			[scrollView removeObserver:self forKeyPath:keyPath];
		} else {
			CGFloat alpha = [self seperatorAlphaWithOffset:self.scrollView.contentOffset.y];
			self.separatorMask.alpha = alpha;
		}
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

- (void)updateObservedValues
{
	if (!self.scrollView) {
		return;
	}
	NSString *keyPath = NSStringFromSelector(@selector(contentOffset));
	[self.scrollView addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:kObservationContext];
}

#pragma mark - UINavigationBarDelegate

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item
{
	[self updateObservedValues];
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
{
	[self updateObservedValues];
}

@end

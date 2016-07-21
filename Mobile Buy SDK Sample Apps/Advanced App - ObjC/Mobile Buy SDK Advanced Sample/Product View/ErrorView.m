//
//  ErrorView.m
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

#import "ErrorView.h"

static CGFloat const kPaddingMedium = 12.0f;
static CGFloat const kPaddingExtraLarge = 16.0f;

@interface ErrorView ()

@property (nonatomic, strong) UIView *overlayView;

@end

@implementation ErrorView

- (instancetype)init
{
	self = [super init];
	if (self) {
		UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] init];
		visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:visualEffectView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[visualEffectView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(visualEffectView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[visualEffectView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(visualEffectView)]];
		
		_overlayView = [[UIView alloc] init];
		_overlayView.translatesAutoresizingMaskIntoConstraints = NO;
		[visualEffectView.contentView addSubview:_overlayView];
		[visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_overlayView]|"
																							 options:0
																							 metrics:nil
																							   views:NSDictionaryOfVariableBindings(_overlayView)]];
		[visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_overlayView]|"
																							 options:0
																							 metrics:nil
																							   views:NSDictionaryOfVariableBindings(_overlayView)]];
		
		_errorLabel = [[UILabel alloc] init];
		_errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_errorLabel.textAlignment = NSTextAlignmentCenter;
		_errorLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		_errorLabel.textColor = [UIColor whiteColor];
		_errorLabel.backgroundColor = [UIColor clearColor];
		_errorLabel.numberOfLines = 0;
		[visualEffectView.contentView addSubview:_errorLabel];
		
		NSDictionary *metricsDictionary = @{ @"paddingExtraLarge" : @(kPaddingExtraLarge), @"paddingMedium" : @(kPaddingMedium) };
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(paddingExtraLarge)-[_errorLabel]-(paddingExtraLarge)-|"
																	 options:0
																	 metrics:metricsDictionary
																	   views:NSDictionaryOfVariableBindings(_errorLabel)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(paddingMedium)-[_errorLabel]-(paddingMedium)-|"
																	 options:0
																	 metrics:metricsDictionary
																	   views:NSDictionaryOfVariableBindings(_errorLabel)]];
	}
	return self;
}

- (void)setOverlayColor:(UIColor*)color
{
	self.overlayView.backgroundColor = color;
}

- (void)presentErrorViewWithMessage:(NSString *)errorMessage completion:(void (^)(void))callback
{

	self.errorLabel.text = errorMessage;
	[NSLayoutConstraint deactivateConstraints:@[self.hiddenConstraint]];
	[NSLayoutConstraint activateConstraints:@[self.visibleConstraint]];
	[UIView animateWithDuration:0.3f
						  delay:0
		 usingSpringWithDamping:0.8f
		  initialSpringVelocity:10
						options:0
					 animations:^{
						 self.alpha = 1;
						 [self layoutIfNeeded];
					 }
					 completion:^(BOOL finished) {
						 [NSLayoutConstraint deactivateConstraints:@[self.visibleConstraint]];
						 [NSLayoutConstraint activateConstraints:@[self.hiddenConstraint]];
						 
						 [UIView animateWithDuration:0.3f delay:3.0f options:0 animations:^{
							 self.alpha = 0;
							 [self layoutIfNeeded];
						 } completion:^(BOOL finished) {
							 [self removeFromSuperview];
							 if (callback) callback();
						 }];
					 }];
}

@end

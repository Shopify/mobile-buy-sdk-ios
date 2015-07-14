//
//  CheckoutSelectionView.m
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "CheckoutSelectionView.h"

//Views
#import "PAYButton.h"

#define kSidePadding 15.0f
#define kButtonIconPadding 8.0f
#define kPaymentButtonHeight 70.0f
#define kAnimationOffset 80.0f
#define kDelay 0.10f

@implementation CheckoutSelectionView {
	UIView *_background;
	NSArray *_buttons;
}

- (instancetype)initWithFrame:(CGRect)frame buttons:(NSArray *)buttons
{
	self = [super initWithFrame:frame];
	if (self) {
		_background = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
		_background.alpha = 0.0f;
		_background.frame = self.bounds;
		_background.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[self addSubview:_background];
	
		_buttons = buttons;
		for (UIButton *button in _buttons) {
			[_background addSubview:button];
			button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		}
	}
	return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
	NSUInteger buttonCount = [_buttons count];
	return CGSizeMake(size.width, kPaymentButtonHeight * buttonCount + kSidePadding * (buttonCount + 1));
}

- (void)layoutButtonsAsHidden
{
	CGRect bounds = _background.bounds;
	
	CGFloat offsetX = bounds.origin.x + roundf(bounds.size.width / 2) + kSidePadding;
	CGFloat offsetY = bounds.origin.y + bounds.size.height - [_buttons count] * (kPaymentButtonHeight + kSidePadding);
	CGFloat width = bounds.size.width - 2 * kSidePadding;
	
	for (UIButton *button in _buttons) {
		button.frame = CGRectMake(offsetX, offsetY, width, kPaymentButtonHeight);
		button.alpha = 0.0f;
		offsetY += kPaymentButtonHeight + kSidePadding;
	}
}

- (void)showButtons:(CGFloat)animationDuration completion:(void (^)(BOOL complete))completion
{
	[self layoutButtonsAsHidden];
	
	[UIView animateWithDuration:animationDuration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
		_background.alpha = 1.0f;
	} completion:nil];
	
	[self animateButtonsToOffset:0.0f duration:animationDuration alpha:1.0f completion:completion];
}

- (void)hideButtons:(CGFloat)animationDuration completion:(void (^)(BOOL complete))completion
{
	[UIView animateWithDuration:animationDuration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
		_background.alpha = 0.0f;
	} completion:nil];
	
	[self animateButtonsToOffset:kAnimationOffset duration:animationDuration alpha:0.0f completion:completion];
}

- (void)animateButtonsToOffset:(CGFloat)offset duration:(CGFloat)duration alpha:(CGFloat)alpha completion:(void (^)(BOOL complete))completion
{
	CGRect bounds = self.bounds;
	CGSize size = [self sizeThatFits:bounds.size];
	CGFloat offsetY = bounds.origin.y + bounds.size.height - size.height;
	CGFloat offsetX = bounds.origin.x + kSidePadding + offset;
	CGFloat delay = 0.0f;
	
	for (UIButton *button in _buttons) {
		//Animate each button independently and call the completion handler when the last button has finished animating
		[UIView animateWithDuration:duration delay:delay usingSpringWithDamping:0.8f initialSpringVelocity:0.2f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
			button.frame = CGRectMake(offsetX, offsetY, button.frame.size.width, button.frame.size.height);
			button.alpha = alpha;
		} completion:button == [_buttons lastObject] ? completion : nil];
		
		offsetY += kPaymentButtonHeight + kSidePadding;
		delay += kDelay;
	}
}

@end

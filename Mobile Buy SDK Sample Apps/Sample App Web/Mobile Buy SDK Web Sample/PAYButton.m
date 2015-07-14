//
//  PAYButton.m
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "PAYButton.h"

#define kButtonMargin 11.0f
#define kButtonSelectionInset 3.0f

@implementation PAYButton {
	UIView *_highlightView;
	UIView *_imageBackgroundView;
	
	BOOL _animating;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_imageBackgroundView = [[UIView alloc] init];
		_imageBackgroundView.backgroundColor = [UIColor whiteColor];
		_imageBackgroundView.userInteractionEnabled = NO;
		[self addSubview:_imageBackgroundView];
		
		_paymentImageView = [[UIImageView alloc] initWithFrame:_imageBackgroundView.bounds];
		_paymentImageView.contentMode = UIViewContentModeCenter;
		_paymentImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[_imageBackgroundView addSubview:_paymentImageView];
		
		_paymentLabel = [[UILabel alloc] init];
		[_paymentLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
		[_paymentLabel setTextColor:[UIColor whiteColor]];
		[self addSubview:_paymentLabel];
		
		_highlightView = [[UIView alloc] initWithFrame:frame];
		_highlightView.alpha = 0.0f;
		_highlightView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_highlightView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
		_highlightView.userInteractionEnabled = NO;
		[self addSubview:_highlightView];
	}
	return self;
}

- (CGRect)rectForHighlightedBackground
{
	CGRect bounds = self.bounds;
	return CGRectMake(bounds.origin.x + kButtonSelectionInset, bounds.origin.y + kButtonSelectionInset, bounds.size.height - kButtonSelectionInset * 2.0f, bounds.size.height - kButtonSelectionInset * 2.0f);
}

- (CGRect)rectForNormalBackground
{
	CGRect bounds = self.bounds;
	return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.height);
}

- (void)setButtonFrame:(CGRect)frame
{
	_imageBackgroundView.frame = frame;
	_highlightView.frame = _imageBackgroundView.frame;
	_imageBackgroundView.layer.cornerRadius = floorf(frame.size.height / 2);
	_highlightView.layer.cornerRadius = _imageBackgroundView.layer.cornerRadius;
}

- (void)setHighlighted:(BOOL)highlighted
{
	if (highlighted != self.isHighlighted) {
		[super setHighlighted:highlighted];
		
		CGRect rect = highlighted ? [self rectForHighlightedBackground] : [self rectForNormalBackground];
		_animating = YES;
		[UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
			_highlightView.alpha = highlighted ? 1.0f : 0.0f;
			_paymentLabel.textColor = highlighted ? [UIColor lightGrayColor] : [UIColor whiteColor];
			[self setButtonFrame:rect];
		} completion:^(BOOL finished) {
			_animating = NO;
		}];
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect bounds = self.bounds;
	if (_animating == NO) {
		[self setButtonFrame:[self rectForNormalBackground]];
	}
	
	CGFloat textHeight = ceilf([[_paymentLabel attributedText] size].height);
	CGFloat backgroundMaxX = CGRectGetMaxX([self rectForNormalBackground]) + kButtonMargin;
	_paymentLabel.frame = CGRectMake(backgroundMaxX, bounds.origin.y + roundf((bounds.size.height - textHeight) * 0.5f), bounds.size.width - backgroundMaxX - kButtonMargin, textHeight);
}

@end

//
//  BUYGradientView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYGradientView.h"

@implementation BUYGradientView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.topColor = [UIColor colorWithWhite:0 alpha:0.5];
		self.bottomColor = [UIColor clearColor];
	}
	return self;
}
- (void)drawRect:(CGRect)rect {
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	NSArray *gradientColors = [NSArray arrayWithObjects:(id)self.topColor.CGColor, (id)self.bottomColor.CGColor, nil];
	
	CGFloat gradientLocations[] = {0, 1};
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, gradientLocations);
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

@end

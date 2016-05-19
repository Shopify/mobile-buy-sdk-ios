//
//  UIButton+PaymentButton.m
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

@import PassKit;
#import "CheckoutButton.h"
#import "UIImage+Additions.h"
#import "UIImage+PaymentButton.h"
#import "UIButton+PaymentButton.h"

@implementation UIButton (PaymentButton)

+ (UIButton *)paymentButtonWithType:(PaymentButtonType)buttonType style:(PaymentButtonStyle)buttonStyle
{
	if ([PKPaymentButton class]) {
		return [PKPaymentButton buttonWithType:(PKPaymentButtonType)buttonType style:(PKPaymentButtonStyle)buttonStyle];
	}

	UIButton *button = [CheckoutButton new];

	UIColor *fillColor;
	UIColor *strokeColor;
	
	switch (buttonStyle) {
		case PaymentButtonStyleBlack:
			fillColor = [UIColor blackColor];
			break;
		case PaymentButtonStyleWhite:
			fillColor = [UIColor whiteColor];
			break;
		case PaymentButtonStyleWhiteOutline:
			fillColor = [UIColor whiteColor];
			strokeColor = [UIColor blackColor];
			break;
	}
	UIImage *backgroundImage = [[UIImage templateImageWithFill:fillColor stroke:strokeColor edgeInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
	
	UIImage *image = [UIImage paymentButtonImageWithFrame:CGRectMake(0, 0, 120.0f, 44.0f) style:buttonStyle type:buttonType];
	[button setImage:image forState:UIControlStateNormal];
	
	return button;
}



@end

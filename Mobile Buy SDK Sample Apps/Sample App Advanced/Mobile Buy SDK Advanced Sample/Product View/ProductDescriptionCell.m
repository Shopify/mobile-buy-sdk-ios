//
//  ProductDescriptionCell.m
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

#import "ProductDescriptionCell.h"
#import "Theme+Additions.h"

@interface ProductDescriptionCell ()

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UILabel *descriptionLabel;
@end

@implementation ProductDescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingMedium, self.layoutMargins.left, kBuyPaddingMedium, self.layoutMargins.right);
		
		_descriptionLabel = [[UILabel alloc] init];
		_descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_descriptionLabel.numberOfLines = 0;
		[self.contentView addSubview:self.descriptionLabel];

		NSDictionary *views = NSDictionaryOfVariableBindings(_descriptionLabel);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_descriptionLabel]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_descriptionLabel]-|" options:0 metrics:nil views:views]];
		
		_textColor = [Theme descriptionTextColor];
	}
	
	return self;
}

- (void)setDescriptionHTML:(NSString *)html
{
	if (html != nil) {
		
		UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		
		html = [html stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx; color:%@;}</style>",
											  font.fontName, font.pointSize, [self hexStringFromColor:self.textColor]]];
		
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
																							  options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
																				   documentAttributes:nil
																								error:nil];
		self.descriptionLabel.attributedText = attributedString;
	}
	else {
		self.descriptionLabel.attributedText = nil;
	}
}

- (NSString *)descriptionString
{
	return self.descriptionLabel.attributedText.string;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
	[super setBackgroundColor:backgroundColor];
	self.descriptionLabel.backgroundColor = self.backgroundColor;
}

- (NSString *)hexStringFromColor:(UIColor *)color {
	
	CGFloat r;
	CGFloat g;
	CGFloat b;
	
	[color getRed:&r green:&g blue:&b alpha:nil];
	
	return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
			lround(r * 255),
			lround(g * 255),
			lround(b * 255)];
}

@end

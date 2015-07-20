//
//  BUYProductDescriptionCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductDescriptionCell.h"
#import "BUYTheme.h"

@interface BUYProductDescriptionCell ()

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) BUYTheme *theme;
@end

@implementation BUYProductDescriptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		_descriptionLabel = [[UILabel alloc] init];
		_descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_descriptionLabel.backgroundColor = [UIColor whiteColor];
		_descriptionLabel.numberOfLines = 0;
		[self.contentView addSubview:self.descriptionLabel];

		NSDictionary *views = NSDictionaryOfVariableBindings(_descriptionLabel);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_descriptionLabel]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_descriptionLabel]-|" options:0 metrics:nil views:views]];
		
		_textColor = [UIColor colorWithWhite:0.6f alpha:1];
	}
	
	return self;
}

- (void)setDescriptionHTML:(NSString *)html
{
	if ((html != nil) && ![html isKindOfClass:[NSNull class]]) {
		
		UIFont *font = [UIFont systemFontOfSize:16.0];
		
		html = [html stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx; color:%@;}</style>",
											  font.fontName, font.pointSize, [self hexStringFromColor:self.textColor]]];
		
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
																							  options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
																										NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
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

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	
	switch (theme.style) {
		case BUYThemeStyleDark:
			self.backgroundColor = [UIColor blackColor];
			self.descriptionLabel.backgroundColor = [UIColor blackColor];
			break;
			
		case BUYThemeStyleLight:
			self.backgroundColor = [UIColor whiteColor];
			self.descriptionLabel.backgroundColor = [UIColor whiteColor];
			break;
			
		default:
			break;
	}
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

//
//  BUYOptionValueCell.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-23.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYTheme;
@class BUYOptionValue;
@class BUYProductVariant;

@interface BUYOptionValueCell : UITableViewCell

@property (nonatomic, strong) BUYOptionValue *optionValue;

@property (nonatomic, strong) UIImageView *selectedImageView;

- (void)setOptionValue:(BUYOptionValue *)optionValue productVariant:(BUYProductVariant*)productVariant currencyFormatter:(NSNumberFormatter*)currencyFormatter theme:(BUYTheme *)theme;

@end


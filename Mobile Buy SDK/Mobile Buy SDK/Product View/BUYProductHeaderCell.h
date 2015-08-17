//
//  BUYProductHeaderCell.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUYTheme.h"
@class BUYProductVariant;

@interface BUYProductHeaderCell : UITableViewCell <BUYThemeable>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *comparePriceLabel;

- (void)setProductVariant:(BUYProductVariant *)productVariant withCurrencyFormatter:(NSNumberFormatter*)currencyFormatter;

@end

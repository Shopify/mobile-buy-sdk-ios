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

@property (nonatomic, strong) BUYProductVariant *productVariant;
@property (nonatomic, strong) NSString *currency;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

//
//  BUYProductHeaderCell.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUYTheme.h"

@interface BUYProductHeaderCell : UITableViewCell <BUYThemeable>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

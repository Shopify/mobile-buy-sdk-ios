//
//  BUYOptionValueCell.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-23.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUYTheme.h"

@class BUYOptionValue;

@interface BUYOptionValueCell : UITableViewCell <BUYThemeable>

@property (nonatomic, strong) BUYOptionValue *optionValue;

@property (nonatomic, strong) UIImageView *selectedImageView;

@end


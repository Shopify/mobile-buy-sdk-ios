//
//  ShippingRateTableViewCell.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by Rune Madsen on 2015-09-21.
//  Copyright © 2015 Shopify. All rights reserved.
//

#import "ShippingRateTableViewCell.h"

@implementation ShippingRateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

@end

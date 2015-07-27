//
//  BUYVariantOptionView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-05-22.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
@class BUYOptionValue;
#import "BUYTheme.h"

@interface BUYVariantOptionView : UIView <BUYThemeable>

- (void)setTextForOptionValue:(BUYOptionValue*)optionValue;

@end

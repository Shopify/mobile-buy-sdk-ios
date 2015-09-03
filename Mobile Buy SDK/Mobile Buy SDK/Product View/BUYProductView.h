//
//  BUYProductView.h
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

#import <UIKit/UIKit.h>
@class BUYProductViewHeader;
@class BUYProductViewHeaderBackgroundImageView;
@class BUYProductViewFooter;
@class BUYGradientView;
@class BUYTheme;
@class BUYImage;
@class BUYProduct;

@interface BUYProductView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *stickyFooterView;
@property (nonatomic, strong) NSLayoutConstraint *footerHeightLayoutConstraint;
@property (nonatomic, strong) NSLayoutConstraint *footerOffsetLayoutConstraint;
@property (nonatomic, strong) BUYProductViewHeader *productViewHeader;
@property (nonatomic, strong) BUYProductViewHeaderBackgroundImageView *backgroundImageView;
@property (nonatomic, strong) BUYProductViewFooter *productViewFooter;
@property (nonatomic, strong) BUYGradientView *topGradientView;
@property (nonatomic, weak) BUYTheme *theme;
@property (nonatomic, assign) BOOL hasSetVariantOnCollectionView;

- (instancetype)initWithFrame:(CGRect)rect product:(BUYProduct*)product theme:(BUYTheme*)theme;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)updateBackgroundImage:(NSArray *)images;
- (void)showErrorWithMessage:(NSString*)errorMessage;
- (void)setInsets:(UIEdgeInsets)edgeInsets appendToCurrentInset:(BOOL)appendToCurrentInset;

@end

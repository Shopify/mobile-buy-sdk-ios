//
//  BUYVariantSelectionViewController.h
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

@import UIKit;

@class BUYProduct;
@class BUYVariantSelectionViewController;
@class BUYProductVariant;
@class BUYTheme;

@protocol BUYVariantSelectionDelegate <NSObject>

/**
 *  Called when a user selects the last option for a product variant
 *
 *  @param controller The displayed variant selection view controller
 *  @param variant    The selected product variant
 */
- (void)variantSelectionController:(BUYVariantSelectionViewController *)controller didSelectVariant:(BUYProductVariant *)variant;

/**
 *  Called when a user cancels out of the flow
 *
 *  @param controller  The displayed variant selection view controller
 *  @param optionIndex The index matching the option value when the user cancelled selection in the flow
 */
- (void)variantSelectionControllerDidCancelVariantSelection:(BUYVariantSelectionViewController *)controller atOptionIndex:(NSUInteger)optionIndex;

@end

/**
 *  The view controller that manages the option selection view controllers
 */
@interface BUYVariantSelectionViewController : UIViewController

/**
 *  Initalizer that takes a product and theme
 *
 *  @param product The product to display variant options for selection
 *  @param theme   The current theme
 *
 *  @return An instance of BUYVariantSelectionViewController
 */
- (instancetype)initWithProduct:(BUYProduct *)product theme:(BUYTheme*)theme;

/**
 *  The product displaying variant option for
 */
@property (nonatomic, strong, readonly) BUYProduct *product;

/**
 *  The current product variant selection in the main product view. This is used to display checkmark throughout the flow to indicate initial current selection
 */
@property (nonatomic, strong) BUYProductVariant *selectedProductVariant;

/**
 *  A currency formatter set to the shop's currency so the price can be displayed for the last variant option
 */
@property (nonatomic, weak) NSNumberFormatter *currencyFormatter;

/**
 *  The delegate that informs the product view of selection or cancellation
 */
@property (nonatomic, weak) id <BUYVariantSelectionDelegate> delegate;

@end

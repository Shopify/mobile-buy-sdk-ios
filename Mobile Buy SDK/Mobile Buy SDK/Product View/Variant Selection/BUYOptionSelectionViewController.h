//
//  BUYOptionSelectionViewController.h
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
#import "BUYTheme.h"

@class BUYOptionValue;
@class BUYOptionSelectionViewController;

@protocol BUYOptionSelectionDelegate <NSObject>

/**
 *  Called when a user selected an option value
 *
 *  @param controller  The BUYOptionSelectionViewController
 *  @param optionValue The selected BUYOptionValue
 */
- (void)optionSelectionController:(BUYOptionSelectionViewController *)controller didSelectOptionValue:(BUYOptionValue *)optionValue;

/**
 *  Called when a user pops the navigation controller and backs out of the current option
 *
 *  @param controller The BUYOptionSelectionViewController
 */
- (void)optionSelectionControllerDidBackOutOfChoosingOption:(BUYOptionSelectionViewController *)controller;

@end

/**
 *  The view controller containing a table view with variant options for selection
 */
@interface BUYOptionSelectionViewController : UITableViewController <BUYThemeable>

/**
 *  Initalizer for the BUYOptionSelectionViewController
 *
 *  @param optionValues                              An array of BUYOptionValue objects to display for selection
 *  @param filteredProductVariantsForSelectionOption An array of BUYProductVariants filtered to the current set selected BUYOptionValue objects
 *
 *  @return An instance of the BUYOptionSelectionViewController
 */
- (instancetype)initWithOptionValues:(NSArray *)optionValues filteredProductVariantsForSelectionOption:(NSArray*)filteredProductVariantsForSelectionOption;

/**
 *  Array of BUYOptionValue objects to display for selection
 */
@property (nonatomic, strong, readonly) NSArray *optionValues;

/**
 *  The selected BUYOptionValue
 */
@property (nonatomic, strong) BUYOptionValue *selectedOptionValue;

/**
 *  True when there are no more options to display after the current selection
 */
@property (nonatomic, assign) BOOL isLastOption;

/**
 *  Array of BUYProductVariants filtered to the current set selected BUYOptionValue objects
 */
@property (nonatomic, strong, readonly) NSArray *filteredProductVariantsForSelectionOption;

/**
 *  Currency formatter with the shop's currency
 */
@property (nonatomic, weak) NSNumberFormatter *currencyFormatter;

/**
 *  Delegate to inform about option selections and cancellations
 */
@property (nonatomic, weak) id <BUYOptionSelectionDelegate> delegate;

@end

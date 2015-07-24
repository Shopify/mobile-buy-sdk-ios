//
//  BUYOptionSelectionViewController.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUYOptionValue;
@class BUYOptionSelectionViewController;
@class BUYTheme;

@protocol BUYOptionSelectionDelegate <NSObject>

- (void)optionSelectionController:(BUYOptionSelectionViewController *)controller didSelectOptionValue:(BUYOptionValue *)optionValue;

- (void)optionSelectionControllerDidBackOutOfChoosingOption:(BUYOptionSelectionViewController *)controller;

@end

@interface BUYOptionSelectionViewController : UITableViewController

- (instancetype)initWithOptionValues:(NSArray *)optionValues theme:(BUYTheme*)theme filteredProductVariantsForSelectionOption:(NSArray*)filteredProductVariantsForSelectionOption;

@property (nonatomic, strong, readonly) NSArray *optionValues;

@property (nonatomic, strong) BUYOptionValue *selectedOptionValue;

@property (nonatomic, assign) BOOL isLastOption;

@property (nonatomic, strong) NSArray *filteredProductVariantsForSelectionOption;

@property (nonatomic, weak) id <BUYOptionSelectionDelegate> delegate;

@end

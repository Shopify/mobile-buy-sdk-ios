//
//  BUYVariantSelectionViewController.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYImageKit.h"
#import "BUYOptionSelectionNavigationController.h"
#import "BUYOptionSelectionViewController.h"
#import "BUYPresentationControllerForVariantSelection.h"
#import "BUYProduct+Options.h"
#import "BUYProductVariant+Options.h"
#import "BUYTheme.h"
#import "BUYTheme+Additions.h"
#import "BUYVariantSelectionViewController.h"
#import "BUYNavigationTitleView.h"

@interface BUYVariantSelectionViewController () <BUYOptionSelectionDelegate>

@property (nonatomic, strong) BUYProduct *product;
@property (nonatomic, weak) BUYTheme *theme;
@property (nonatomic, strong) NSMutableDictionary *selectedOptions;
@property (nonatomic, assign) BOOL changedOptionSelection;
@property (nonatomic, strong) NSArray *filteredProductVariantsForSelectionOption;
@property (nonatomic, strong) NSMutableArray *optionValueNames;

@end

@implementation BUYVariantSelectionViewController

- (instancetype)initWithProduct:(BUYProduct *)product theme:(BUYTheme*)theme
{
	NSParameterAssert(product);
	
	self = [super init];
	
	if (self) {
		self.product = product;
		self.selectedOptions = [NSMutableDictionary new];
		self.optionValueNames = [NSMutableArray new];
		self.theme = theme;
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	BUYOptionSelectionViewController *controller = [self nextOptionSelectionController];
	
	// Add close button
	UIImage *closeButton = [[BUYImageKit imageOfVariantCloseImageWithFrame:CGRectMake(0, 0, 18, 18)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:closeButton style:UIBarButtonItemStylePlain target:self action:@selector(dismissPopover)];
	controller.navigationItem.leftBarButtonItem = barButtonItem;
	[self.navigationController pushViewController:controller animated:NO];
	
	BUYOptionSelectionNavigationController *navigationController = (BUYOptionSelectionNavigationController*)self.navigationController;
	UIVisualEffectView *backgroundView = [(BUYPresentationControllerForVariantSelection*)navigationController.presentationController backgroundView];
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopover)];
	[backgroundView addGestureRecognizer:tapGestureRecognizer];
}

- (void)presentNextOption
{
	BUYOptionSelectionViewController *controller = [self nextOptionSelectionController];
	[self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)hasNextOption
{
	NSUInteger index = [[self.selectedOptions allKeys] count];
	return self.product.options.count > index;
}

- (BOOL)isLastOption
{
	NSUInteger index = [[self.selectedOptions allKeys] count];
	return self.product.options.count - 1 == index;
}

- (BUYOptionSelectionViewController *)nextOptionSelectionController
{
	NSUInteger index = [[self.selectedOptions allKeys] count];
	BUYOption *option = self.product.options[index];
	
	NSArray *options = [self.product valuesForOption:option variants:self.filteredProductVariantsForSelectionOption];
	BUYOptionSelectionViewController *optionController = [[BUYOptionSelectionViewController alloc] initWithOptionValues:options filteredProductVariantsForSelectionOption:self.filteredProductVariantsForSelectionOption];
	optionController.theme = self.theme;
	optionController.delegate = self;
	optionController.selectedOptionValue = self.changedOptionSelection ? nil : [self.selectedProductVariant optionValueForName:option.name];
	optionController.isLastOption = [self isLastOption];
	optionController.currencyFormatter = self.currencyFormatter;
	optionController.title = nil;
	BUYNavigationTitleView *navigationTitleView = [[BUYNavigationTitleView alloc] init];
	navigationTitleView.theme = self.theme;
	[navigationTitleView setTitleWithBuyOption:option selectedBuyOptionValues:self.optionValueNames];
	optionController.navigationItem.titleView = navigationTitleView;
	return optionController;
}

- (void)dismissPopover
{
	[(BUYOptionSelectionNavigationController*)self.navigationController setDismissWithCancelAnimation:YES];
	if ([self.delegate respondsToSelector:@selector(variantSelectionControllerDidCancelVariantSelection:atOptionIndex:)]) {
		[self.delegate variantSelectionControllerDidCancelVariantSelection:self atOptionIndex:self.selectedOptions.count];
	}
}

#pragma mark - BUYOptionSelectionDelegate

- (void)optionSelectionController:(BUYOptionSelectionViewController *)controller didSelectOptionValue:(BUYOptionValue *)optionValue
{
	self.changedOptionSelection |= ![controller.selectedOptionValue.value isEqualToString:optionValue.value];
	self.selectedOptions[optionValue.name] = optionValue;
	[self.optionValueNames addObject:optionValue.value];
	
	self.filteredProductVariantsForSelectionOption = [BUYProductVariant filterProductVariants:controller.filteredProductVariantsForSelectionOption forOptionValue:optionValue];

	if ([self hasNextOption]) {
		[self presentNextOption];
	}
	else {
		BUYProductVariant *variant = [self.product variantWithOptions:self.selectedOptions.allValues];
		if ([self.delegate respondsToSelector:@selector(variantSelectionController:didSelectVariant:)]) {
			[self.delegate variantSelectionController:self didSelectVariant:variant];
		}
	}
}

- (void)optionSelectionControllerDidBackOutOfChoosingOption:(BUYOptionSelectionViewController *)controller
{
	BUYOption *option = [controller.optionValues firstObject];
	[self.selectedOptions removeObjectForKey:option.name];
	[self.optionValueNames removeLastObject];
	self.filteredProductVariantsForSelectionOption = controller.filteredProductVariantsForSelectionOption;
}

- (NSArray*)filteredProductVariantsForSelectionOption
{
	if (_filteredProductVariantsForSelectionOption == nil) {
		_filteredProductVariantsForSelectionOption = [self.product.variants copy];
	}
	return _filteredProductVariantsForSelectionOption;
}

@end

//
//  VariantSelectionViewController.m
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

#import "ImageKit.h"
#import "OptionSelectionNavigationController.h"
#import "OptionSelectionViewController.h"
#import "VariantSelectionPresentationController.h"
#import "VariantSelectionViewController.h"
#import "OptionBreadCrumbsView.h"

@interface VariantSelectionViewController () <OptionSelectionDelegate>

@property (nonatomic, strong) BUYProduct *product;
@property (nonatomic, strong) NSMutableDictionary *selectedOptions;
@property (nonatomic, assign) BOOL changedOptionSelection;
@property (nonatomic, strong) NSArray *filteredProductVariantsForSelectionOption;
@property (nonatomic, strong) NSMutableArray *optionValueNames;

@end

@implementation VariantSelectionViewController

- (instancetype)initWithProduct:(BUYProduct *)product
{
	NSParameterAssert(product);
	
	self = [super init];
	
	if (self) {
		self.product = product;
		self.selectedOptions = [NSMutableDictionary new];
		self.optionValueNames = [NSMutableArray new];
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	OptionSelectionViewController *controller = [self nextOptionSelectionController];
	
	// Add close button
	UIImage *closeButton = [[ImageKit imageOfVariantCloseImageWithFrame:CGRectMake(0, 0, 18, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:closeButton style:UIBarButtonItemStylePlain target:self action:@selector(dismissPopover)];
	controller.navigationItem.leftBarButtonItem = barButtonItem;
	[self.navigationController pushViewController:controller animated:NO];
	
	OptionSelectionNavigationController *navigationController = (OptionSelectionNavigationController*)self.navigationController;
	UIVisualEffectView *backgroundView = [(VariantSelectionPresentationController*)navigationController.presentationController backgroundView];
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopover)];
	[backgroundView addGestureRecognizer:tapGestureRecognizer];
}

- (void)presentNextOption
{
	OptionSelectionViewController *controller = [self nextOptionSelectionController];
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

- (BOOL)isFirstOption
{
	return [[self.selectedOptions allKeys] count] == 1;
}

- (OptionSelectionViewController *)nextOptionSelectionController
{
	NSUInteger index = [[self.selectedOptions allKeys] count];
	BUYOption *option = self.product.options[index];
	
	NSArray *options = [self.product valuesForOption:option variants:self.filteredProductVariantsForSelectionOption];
	OptionSelectionViewController *optionController = [[OptionSelectionViewController alloc] initWithOptionValues:options filteredProductVariantsForSelectionOption:self.filteredProductVariantsForSelectionOption];
	optionController.delegate = self;
	optionController.selectedOptionValue = self.changedOptionSelection ? nil : [self.selectedProductVariant optionValueForName:option.name];
	optionController.isLastOption = [self isLastOption];
	optionController.currencyFormatter = self.currencyFormatter;
	optionController.title = option.name;
	if (index > 0) {
		[[(OptionSelectionNavigationController*)self.navigationController breadsCrumbsView] setSelectedBuyOptionValues:[self.optionValueNames copy]];
		optionController.tableView.contentInset = optionController.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(optionController.tableView.contentInset.top + CGRectGetHeight([[(OptionSelectionNavigationController*)self.navigationController breadsCrumbsView] bounds]), optionController.tableView.contentInset.left, optionController.tableView.contentInset.bottom, optionController.tableView.contentInset.right);
	}
	return optionController;
}

- (void)dismissPopover
{
	[(OptionSelectionNavigationController*)self.navigationController setDismissWithCancelAnimation:YES];
	if ([self.delegate respondsToSelector:@selector(variantSelectionControllerDidCancelVariantSelection:atOptionIndex:)]) {
		[self.delegate variantSelectionControllerDidCancelVariantSelection:self atOptionIndex:self.selectedOptions.count];
	}
}

#pragma mark - OptionSelectionDelegate

- (void)optionSelectionController:(OptionSelectionViewController *)controller didSelectOptionValue:(BUYOptionValue *)optionValue
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

- (void)optionSelectionControllerDidBackOutOfChoosingOption:(OptionSelectionViewController *)controller
{
	BUYOption *option = [controller.optionValues firstObject];
	[self.selectedOptions removeObjectForKey:option.name];
	[self.optionValueNames removeLastObject];
	self.filteredProductVariantsForSelectionOption = controller.filteredProductVariantsForSelectionOption;
	[[(OptionSelectionNavigationController*)self.navigationController breadsCrumbsView] setSelectedBuyOptionValues:[self.optionValueNames copy]];
}

- (NSArray*)filteredProductVariantsForSelectionOption
{
	if (_filteredProductVariantsForSelectionOption == nil) {
		_filteredProductVariantsForSelectionOption = [self.product.variants copy];
	}
	return _filteredProductVariantsForSelectionOption;
}

@end

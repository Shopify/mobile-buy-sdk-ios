//
//  BUYVariantSelectionViewController.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYVariantSelectionViewController.h"
#import "BUYOptionSelectionViewController.h"
#import "BUYProduct+Options.h"
#import "BUYTheme.h"
#import "BUYPresentationControllerForVariantSelection.h"
#import "BUYOptionSelectionNavigationController.h"

@interface BUYVariantSelectionViewController () <BUYOptionSelectionDelegate>

@property (nonatomic, strong) BUYProduct *product;

@property (nonatomic, strong) NSMutableDictionary *selectedOptions;
@end

@implementation BUYVariantSelectionViewController

- (instancetype)initWithProduct:(BUYProduct *)product
{
	NSParameterAssert(product);
	
	self = [super init];
	
	if (self) {
		self.product = product;
		self.selectedOptions = [NSMutableDictionary new];
		self.theme = [[BUYTheme alloc] init];
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	BUYOptionSelectionViewController *controller = [self nextOptionSelectionController];
	controller.navigationItem.hidesBackButton = YES;
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
	NSUInteger index = self.selectedOptions.count;
	return self.product.options.count > index;
}

- (BUYOptionSelectionViewController *)nextOptionSelectionController
{
	NSUInteger index = self.selectedOptions.count;
	BUYOption *option = self.product.options[index];
	
	NSArray *options = [self.product valuesForOption:option];
	BUYOptionSelectionViewController *optionController = [[BUYOptionSelectionViewController alloc] initWithOptionValues:options];
	optionController.delegate = self;
	optionController.theme = self.theme;

	return optionController;
}

- (void)dismissPopover
{
	if ([self.delegate respondsToSelector:@selector(variantSelectionControllerDidCancelVariantSelection:atOptionIndex:)]) {
		[self.delegate variantSelectionControllerDidCancelVariantSelection:self atOptionIndex:self.selectedOptions.count];
	}
}

#pragma mark - BUYOptionSelectionDelegate

- (void)optionSelectionController:(BUYOptionSelectionViewController *)controller didSelectOption:(BUYOptionValue *)option
{
	self.selectedOptions[option.name] = option;
	
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
}

@end

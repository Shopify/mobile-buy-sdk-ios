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
#import "BUYImageKit.h"

@interface BUYVariantSelectionViewController () <BUYOptionSelectionDelegate>

@property (nonatomic, strong) BUYProduct *product;
@property (nonatomic, weak) BUYTheme *theme;
@property (nonatomic, strong) NSMutableDictionary *selectedOptions;

@end

@implementation BUYVariantSelectionViewController

- (instancetype)initWithProduct:(BUYProduct *)product theme:(BUYTheme*)theme
{
	NSParameterAssert(product);
	
	self = [super init];
	
	if (self) {
		self.product = product;
		self.selectedOptions = [NSMutableDictionary new];
		self.theme = theme;
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	BUYOptionSelectionViewController *controller = [self nextOptionSelectionController];
	
	// Add close button
	UIImage *closeButton = [BUYImageKit imageOfVariantCloseImageWithFrame:CGRectMake(0, 0, 18, 18)];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:closeButton style:UIBarButtonItemStylePlain target:self action:@selector(dismissPopover)];
	barButtonItem.tintColor = [UIColor colorWithWhite:(float)(152.0/255.0) alpha:1.0];
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
	NSUInteger index = self.selectedOptions.count;
	return self.product.options.count > index;
}

- (BUYOptionSelectionViewController *)nextOptionSelectionController
{
	NSUInteger index = self.selectedOptions.count;
	BUYOption *option = self.product.options[index];
	
	NSArray *options = [self.product valuesForOption:option];
	BUYOptionSelectionViewController *optionController = [[BUYOptionSelectionViewController alloc] initWithOptionValues:options theme:self.theme];
	optionController.delegate = self;
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

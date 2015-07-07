//
//  ProductViewController.m
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import <Buy/Buy.h>

#import "ProductController.h"
#import "ProductView.h"

@interface ProductController ()

@property (nonatomic, strong) ProductView *productView;
@property (nonatomic, strong) BUYProductVariant *productVariant;
@property (nonatomic, strong) NSString *initialProductId;

@end

@implementation ProductController

- (instancetype)initWithClient:(BUYClient *)client productId:(NSString *)productId;
{
	self = [super initWithClient:client];
	if (self) {
		_initialProductId = productId;
	}
	return self;
}

- (void)loadView
{
	self.productView = [[ProductView alloc] init];
	self.view = self.productView;
	
	[self.productView.paymentButton addTarget:self action:@selector(applePayPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.productView.checkoutButton addTarget:self action:@selector(checkoutPressed:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.productView showLoading:YES];
	
	//Download the necessary product information from Shopify, given a handle and (optionally) a variant id.
    [self.client getProductById:_initialProductId completion:^(BUYProduct *product, NSError *error) {
        
    	//NOTE: You would want to display your product + a picker to select the correct variant or iterate the variants and pick the right one
		self.productVariant = [product.variants firstObject];
        
		UIImage *image = nil;
		if ([[product images] count] > 0) {
			BUYImage *productImage = [[product images] firstObject];
			image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:productImage.src]]];
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.productView showLoading:NO];
			self.productView.productImageView.image = image;
			self.productView.titleLabel.text = product.title;
			 //NOTE: You will want to format this correctly, based on the user locale + currency of your shop.
			self.productView.priceLabel.text = self.productVariant ? [NSString stringWithFormat:@"$%@", [self.productVariant.price stringValue]] : @"No product";
			self.productView.paymentButton.enabled = self.productVariant != nil;
		});
	}];
}

- (void)checkoutPressed:(id)sender
{
    BUYCart *cart = [[BUYCart alloc] init];
    [cart addVariant:self.productVariant];
    
    [self startWebCheckoutWithCart:cart];
}

- (void)applePayPressed:(id)sender
{
	// Step 1 - Create the checkout on Shopify. This demo only works with ApplePay.
	if ([PKPaymentAuthorizationViewController canMakePayments]) {
        BUYCart *cart = [[BUYCart alloc] init];
        [cart addVariant:self.productVariant];

		[self startApplePayCheckoutWithCart:cart];
	}
    else
    {
        // Alternativelty, a web view with the checkout flow could be displayed, or a fully native checkout which then calls `completeCheckout:completion`
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Apple Pay not supported on this device" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end

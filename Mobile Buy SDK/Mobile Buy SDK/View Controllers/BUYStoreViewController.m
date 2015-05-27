//
//  BUYStoreController.m
//  Mobile Buy SDK
//
//  Created by Joshua Tessier on 2015-02-10.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import WebKit;
#import "BUYLineItem.h"
#import "BUYProduct.h"
#import "BUYProductVariant.h"
#import "BUYStoreViewController.h"

#define kCheckoutEvent @"com.shopify.hybrid.checkout"
#define kToolbarHeight 44.0f

NSString * const BUYShopifyError = @"shopify";

@interface BUYStoreViewController () <WKNavigationDelegate>
@end

@implementation BUYStoreViewController {
	NSURL *_url;
	WKWebView *_webView;
	
	UIBarButtonItem *_backButton;
	UIBarButtonItem *_forwardButton;
	
	BOOL _skippingAppCheckout;
	
	NSURLRequest *_checkoutRequest;
}

@synthesize delegate;

- (instancetype)initWithClient:(BUYClient *)client url:(NSURL *)url
{
	self = [super initWithDataProvider:client];
	
	if (self) {
		_url = url;
	}
	
	return self;
}

- (instancetype)initWithDataProvider:(BUYClient *)provider
{
	self = [super initWithDataProvider:provider];
	
	if (self) {
		_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", provider.shopDomain]];
	}
	
	return self;
}

- (void)loadView
{
	_webView = [[WKWebView alloc] initWithFrame:CGRectZero];
	_webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
	_webView.navigationDelegate = self;
	self.view = _webView;
	
	_backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:_webView action:@selector(goBack)];
	_forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:_webView action:@selector(goForward)];
	UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	self.toolbarItems = @[_backButton, flexible, _forwardButton, flexible, flexible, flexible, flexible, flexible];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[_webView loadRequest:[NSURLRequest requestWithURL:_url]];
	[self updateButtons];
	
	

}

#pragma mark - Button Presses

- (void)updateButtons
{
	_backButton.enabled = [_webView canGoBack];
	_forwardButton.enabled = [_webView canGoForward];
}

#pragma mark - Web View Navigation Delegate Methods

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
	//This is the first approach, where we respond to /checkout links.
	//This takes advantage of Shopify's 'cart.js' functionality. We can fetch the entire active cart by hitting /cart.json.
	//It will fetch the current session's cart, and return it to you in json.
	//
	//The `fetchCart();` method is defined in `app.js` which is a small Javascript bundle we've prepared for demo purposes.
	//
	NSString *currentUrlString = [[[navigationAction request] URL] absoluteString];
	
	BOOL checkoutLink = [currentUrlString containsString:@"/checkout"] || [currentUrlString containsString:@"/sessions"];
	BOOL thankYouPage = [currentUrlString containsString:@"thank_you"];
	
	if (checkoutLink && thankYouPage == NO) {
		if (_skippingAppCheckout) {
			decisionHandler(WKNavigationActionPolicyAllow);
		}
		else {
			decisionHandler(WKNavigationActionPolicyCancel);
			
			[self presentCheckoutMethodSelectionMenuWithCheckoutRequest:[navigationAction request]];
		}
	}
	else {
		_skippingAppCheckout = NO;
		decisionHandler(WKNavigationActionPolicyAllow);
	}
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{	
	[self updateButtons];
}

#pragma mark - Checkout Methods

- (void)presentCheckoutMethodSelectionMenuWithCheckoutRequest:(NSURLRequest *)request
{
	_checkoutRequest = request;
	
	if ([self.delegate respondsToSelector:@selector(controller:shouldProceedWithCheckoutType:)]) {
		
		[self.delegate controller:self shouldProceedWithCheckoutType:^(BUYCheckoutType type) {
			
			switch (type) {
				case BUYCheckoutTypeNormal:
					[self checkoutWithNormalCheckout];
					break;
					
				case BUYCheckoutTypeApplePay:
					[self checkoutWithApplePay];
					break;
					
				default:
					break;
			}
		}];
	}
	
	else {
		[self checkoutWithNormalCheckout];
	}
}

- (void)getProduct:(NSString *)productId withVariantId:(NSString *)variantId completion:(void (^)(BUYProductVariant *variant, NSError *error))completion;
{
	[self.provider getProductById:productId completion:^(BUYProduct *product, NSError *error) {
		BUYProductVariant *selectedVariant = nil;

		if (error == nil) {
			for (BUYProductVariant *variant in product.variants) {
				if ([variant.identifier isEqual:@([variantId longLongValue])]) {
					selectedVariant = variant;
					break;
				}
			}
		}
		else {
			NSLog(@"Failed to fetch variant: %@", error);
		}
		
		completion(selectedVariant, error);
	}];
}

#pragma mark - Checkout Selection Delegate Methods

- (void)checkoutWithApplePay
{
	NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:_url];
	
	NSString *cartToken = nil;
	for (NSHTTPCookie *cookie in cookies) {
		if ([cookie.name isEqualToString:@"cart"]) {
			cartToken = cookie.value;
			break;
		}
	}
	
	if (cartToken) {
		[self startCheckoutWithCartToken:cartToken];
	}
	else {
		[self.delegate controller:self failedToCreateCheckout:nil];
	}
}

- (void)checkoutWithNormalCheckout
{
	_skippingAppCheckout = YES;
	[_webView loadRequest:_checkoutRequest];
}

#pragma mark - Checkout Completion Handling

- (void)checkoutCompleted:(BUYCheckout *)checkout status:(BUYStatus)status
{
	if (status == BUYStatusComplete) {
		[self.provider getCheckout:checkout completion:^(BUYCheckout *updatedCheckout, NSError *error) {
			dispatch_async(dispatch_get_main_queue(), ^{
				if (updatedCheckout.orderStatusURL) {
					[_webView loadRequest:[NSURLRequest requestWithURL:updatedCheckout.orderStatusURL]];
				}
				else {
					NSLog(@"Couldn't redirect to thank you page: %@ (url: %@)", updatedCheckout, updatedCheckout.orderStatusURL);
				}
			});
		}];
	}
	else {
		NSError *error = [NSError errorWithDomain:BUYShopifyError code:status userInfo:@{@"checkout": checkout}];
		[self.delegate controller:self failedToCompleteCheckout:checkout withError:error];
	}
}

@end

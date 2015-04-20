//
//  PAYStoreController.m
//  CheckoutAnywhereSample
//
//  Created by Joshua Tessier on 2015-02-10.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import WebKit;
#import "CHKStoreController.h"
#import "CheckoutAnywhere.h"

#define kBuyNowEvent @"com.shopify.hybrid.buynow"
#define kCheckoutEvent @"com.shopify.hybrid.checkout"
#define kToolbarHeight 44.0f

@interface CHKStoreController () <WKNavigationDelegate, WKScriptMessageHandler>
@end

@implementation CHKStoreController {
	NSURL *_url;
	WKWebView *_webView;
	
	UIBarButtonItem *_backButton;
	UIBarButtonItem *_forwardButton;
	
	BOOL _skippingAppCheckout;
    
    NSURLRequest *_checkoutRequest;
}

@synthesize delegate;

- (instancetype)initWithShopAddress:(NSString *)shopAddress apiKey:(NSString *)apiKey merchantId:(NSString *)merchantId
{
	return [self initWithShopAddress:shopAddress apiKey:apiKey merchantId:merchantId url:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", shopAddress]]];
}

- (instancetype)initWithShopAddress:(NSString *)shopAddress apiKey:(NSString *)apiKey merchantId:(NSString *)merchantId url:(NSURL *)url
{
	self = [super initWithShopAddress:shopAddress apiKey:apiKey merchantId:merchantId];
	if (self) {
		_url = url;
		
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Store" image:[UIImage imageNamed:@"shop"] tag:1];
	}
	return self;
}

- (void)loadView
{
	WKWebViewConfiguration *configuration = [self webViewConfiguration];
	_webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
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

#pragma mark - Web View Script Handling

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	NSDictionary *options = message.body;
	NSString *eventName = options[@"eventName"];
	if ([eventName isEqual:kBuyNowEvent]) {
		[self receivedCart:options[@"cart"]];
	}
	else if ([eventName isEqual:kCheckoutEvent]) {
		[self receivedCartToken:options[@"token"]];
	}
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
	[_webView evaluateJavaScript:@"nativeAppSetup();" completionHandler:^(id result, NSError *error) {
		if (error) {
			NSLog(@"Setup - %@ - %@", result, error);
		}
	}];
	
	[self updateButtons];
}

#pragma mark - Checkout Methods

- (void)presentCheckoutMethodSelectionMenuWithCheckoutRequest:(NSURLRequest *)request
{
    if ([self.delegate respondsToSelector:@selector(controller:shouldProceedWithCheckoutType:)]) {
        
        [self.delegate controller:self shouldProceedWithCheckoutType:^(CHKCheckoutType type) {
            
            switch (type) {
                case CHKheckoutTypeNormal:
                    [self checkoutWithNormalCheckout];
                    break;
                    
                case CHKCheckoutTypeApplePay:
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

- (void)getProduct:(NSString *)handle withVariantId:(NSString *)variantId completion:(void (^)(CHKProductVariant *variant, NSError *error))completion;
{
	[self.provider getProductByHandle:handle completion:^(CHKProduct *product, NSError *error) {
		CHKProductVariant *selectedVariant = nil;
		if (error == nil) {
			for (CHKProductVariant *variant in product.variants) {
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

- (void)receivedCart:(NSDictionary *)cart
{
	//This is useful when we don't have a persisted cart on Shopify (i.e the user added a buy now button to their shop)
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		//Download all of the products that we need
		NSArray *lineItems = cart[@"lineItems"];
		
		dispatch_group_t group = dispatch_group_create();
		
		__block BOOL successful = YES;
		CHKCart *checkoutCart = [[CHKCart alloc] init];
		for (NSDictionary *lineItem in lineItems) {
			dispatch_group_enter(group);
			
			[self getProduct:lineItem[@"handle"] withVariantId:lineItem[@"variantId"] completion:^(CHKProductVariant *variant, NSError *error) {
				if (variant) {
					CHKLineItem *cartLineItem = [[CHKLineItem alloc] initWithVariant:variant];
					cartLineItem.quantity = [NSDecimalNumber decimalNumberWithDecimal:[lineItem[@"quantity"] decimalValue]];
					cartLineItem.price = [cartLineItem.quantity decimalNumberByMultiplyingBy:variant.price];
					[checkoutCart addLineItemsObject:cartLineItem];
				}
				else {
					successful = NO;
					NSLog(@"Did not have a variant!");
				}
				dispatch_group_leave(group);
			}];
		}
		dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (successful) {
				[self startCheckoutWithCart:checkoutCart];
			}
			else {
				[[[UIAlertView alloc] initWithTitle:@"Failed!" message:@"Failed to initiate checkout :(" delegate:nil cancelButtonTitle:@"(;´༎ຶД༎ຶ`)" otherButtonTitles:nil] show];
			}
		});
	});
}

- (void)receivedCartToken:(NSString *)token
{
	[self startCheckoutWithCartToken:token];
}

#pragma mark - Checkout Selection Delegate Methods

- (void)checkoutWithApplePay
{
    [_webView evaluateJavaScript:@"fetchCart();" completionHandler:^(id result, NSError *error) {
        NSLog(@"Fetch Cart - %@ - %@", result, error);
    }];
}

- (void)checkoutWithNormalCheckout
{
    _skippingAppCheckout = YES;
    [_webView loadRequest:_checkoutRequest];
}

#pragma mark - Checkout Completion Handling

- (void)checkoutCompleted:(CHKCheckout *)checkout status:(CHKStatus)status
{
	if (status == CHKStatusComplete) {
		[self.provider getCheckout:checkout completion:^(CHKCheckout *updatedCheckout, NSError *error) {
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
}

#pragma mark - Web View Configuration

- (WKWebViewConfiguration *)webViewConfiguration
{
	WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
	configuration.userContentController = [self userContentConfiguration];
	configuration.processPool = [self processPool];
	return configuration;
}

- (WKProcessPool *)processPool
{
	static WKProcessPool *pool = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		pool = [[WKProcessPool alloc] init];
	});
	return pool;
}

- (WKUserContentController *)userContentConfiguration
{
	//Register our native bridge
	WKUserContentController *contentController = [WKUserContentController new];
	WKUserScript *userScript = [self userScriptWithName:@"app"];
	[contentController addUserScript:userScript];
	[contentController addScriptMessageHandler:self name:@"nativeApp"];
	return contentController;
}

- (WKUserScript *)userScriptWithName:(NSString*)scriptName
{
	NSData *jsData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:scriptName ofType:@"js"]];
	NSString *js = [[NSString alloc] initWithData:jsData encoding:NSUTF8StringEncoding];
	return [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
}

@end

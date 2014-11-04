//
//  CHKAnywhereIntegrationTest.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-19.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

//Data
#import "CHKDataProvider.h"
#import "MERDataProvider.h"

//Other
#import "Stripe.h"
#import "CHKTestCredentials.h"

//Models
#import "CHKCart.h"
#import "MERProduct.h"
#import "MERProductVariant.h"
#import "CHKCheckout.h"
#import "CHKCreditCard.h"

#define WAIT_FOR_TASK(task, sempahore) \
	if (task) { \
		dispatch_semaphore_wait(sempahore, DISPATCH_TIME_FOREVER); \
	} \
	else { \
		XCTFail(@"Task was nil, could not wait"); \
	} \

@interface CHKAnywhereIntegrationTest : XCTestCase
@end

@implementation CHKAnywhereIntegrationTest {
	CHKDataProvider *_checkoutDataProvider;
	MERDataProvider *_storefrontDataProvider;
	
	MERShop *_shop;
	NSMutableArray *_collections;
	NSMutableArray *_products;
	
	CHKCart *_cart;
	CHKCheckout *_checkout;
	NSArray *_shippingRates;
	STPToken *token;
}

- (void)setUp
{
	[super setUp];

	XCTAssert([CHECKOUT_ANYWHERE_SHOP length] > 0, @"You must provide a valid CHECKOUT_ANYWHERE_SHOP. This is your 'shopname.myshopify.com' address.");
	XCTAssert([CHECKOUT_ANYHWERE_API_KEY length] > 0, @"You must provide a valid CHECKOUT_ANYHWERE_API_KEY. This is the API_KEY of your app.");
	
	_checkoutDataProvider = [[CHKDataProvider alloc] initWithShopDomain:CHECKOUT_ANYWHERE_SHOP apiKey:CHECKOUT_ANYHWERE_API_KEY];
	_storefrontDataProvider = [[MERDataProvider alloc] initWithShopDomain:CHECKOUT_ANYWHERE_SHOP];
	
	_collections = [[NSMutableArray alloc] init];
	_products = [[NSMutableArray alloc] init];
	
	[Stripe setDefaultPublishableKey:STRIPE_PUBLISHABLE_KEY];
	
	//TODO: This currently does a bunch of API calls. We should add some fixtures to the tests.
	[self fetchShop];
	[self fetchCollections];
	[self fetchProducts];
}

#pragma mark - Helpers

- (void)fetchShop
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_storefrontDataProvider getShop:^(MERShop *shop, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(shop);
		
		_shop = shop;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)fetchCollections
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	__block BOOL done = NO;
	NSUInteger currentPage = 0;
	while (done == NO) {
		NSURLSessionDataTask *task = [_storefrontDataProvider getCollectionsPage:currentPage completion:^(NSArray *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {
			done = reachedEnd || error;
			
			XCTAssertNil(error);
			XCTAssertNotNil(collections);
			
			[_collections addObjectsFromArray:collections];
			dispatch_semaphore_signal(semaphore);
		}];
		WAIT_FOR_TASK(task, semaphore);
		
		if (done == NO) {
			++currentPage;
		}
	}
	NSLog(@"Fetched collections (Pages: %d, Count: %d)", (int)(currentPage + 1), (int)[_collections count]);
}

- (void)fetchProducts
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	__block BOOL done = NO;
	NSUInteger currentPage = 0;
	while (done == NO) {
		NSURLSessionDataTask *task = [_storefrontDataProvider getProductsPage:currentPage completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
			done = reachedEnd || error;
			
			XCTAssertNil(error);
			XCTAssertNotNil(products);
			
			[_products addObjectsFromArray:products];
			dispatch_semaphore_signal(semaphore);
		}];
		WAIT_FOR_TASK(task, semaphore);
		
		if (done == NO) {
			++currentPage;
		}
	}
	NSLog(@"Fetched products (Pages: %d, Count: %d)", (int)(currentPage + 1), (int)[_products count]);
}

- (void)createCart
{
	_cart = [[CHKCart alloc] init];
	[_cart addVariant:[_products[0] variants][0]];
}

- (void)createCheckout
{
	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
	_checkout.shippingAddress = [self shippingAddress];
	_checkout.billingAddress = [self billingAddress];
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	XCTAssertEqualObjects(_checkout.shippingAddress.address1, @"126 York Street");
	XCTAssertEqualObjects(_checkout.billingAddress.address1, @"150 Elgin Street");
}

- (void)fetchShippingRates
{
	__block CHKStatus shippingStatus = CHKStatusUnknown;
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	while (_checkout.token && shippingStatus != CHKStatusFailed && shippingStatus != CHKStatusComplete) {
		NSLog(@"Fetching shipping rates...");
		NSURLSessionDataTask *task = [_checkoutDataProvider getShippingRatesForCheckout:_checkout block:^(NSArray *returnedShippingRates, CHKStatus status, NSError *error) {
			XCTAssertNil(error);
			shippingStatus = status;
			if (shippingStatus == CHKStatusComplete) {
				XCTAssertNotNil(returnedShippingRates);
				_shippingRates = returnedShippingRates;
			}
			dispatch_semaphore_signal(semaphore);
		}];
		WAIT_FOR_TASK(task, semaphore);
		
		if (shippingStatus != CHKStatusComplete) {
			[NSThread sleepForTimeInterval:0.5f];
		}
	}
	XCTAssertTrue([_shippingRates count] > 0);
	XCTAssertEqual(shippingStatus, CHKStatusComplete);
}

- (void)updateCheckout
{
	_checkout.email = @"banana@testasaurus.com";
	_checkout.shippingRate = _shippingRates[0];
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider updateCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	XCTAssertEqualObjects(_checkout.email, @"banana@testasaurus.com");
}

- (void)addCreditCardToCheckout
{
	CHKCreditCard *creditCard = [[CHKCreditCard alloc] init];
	creditCard.number = @"4242424242424242";
	creditCard.expiryMonth = @"12";
	creditCard.expiryYear = @"20";
	creditCard.cvv = @"123";
	creditCard.nameOnCard = @"Dinosaur Banana";
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider storeCreditCard:creditCard checkout:_checkout completion:^(CHKCheckout *returnedCheckout, NSString *paymentSessionId, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(paymentSessionId);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)fetchStripeToken
{
	//This is done to simulate the ApplePay flow. We'll get an ApplePay token from Apple for a credit card, hand it to stripe, and then get a stripe token.
	STPCard *card = [[STPCard alloc] init];
	card.number = @"4242424242424242";
	card.expMonth = 12;
	card.expYear = 20;
	card.cvc = @"123";
	card.name = @"Dinosaur Banana";
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[Stripe createTokenWithCard:card operationQueue:queue completion:^(STPToken *returnedToken, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedToken);
		
		token = returnedToken;
		dispatch_semaphore_signal(semaphore);
	}];
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)completeCheckout
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider completeCheckout:_checkout block:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)completeCheckoutWithStripeToken
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider completeCheckout:_checkout withStripeToken:token block:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)pollUntilCheckoutIsComplete
{
	__block CHKStatus checkoutStatus = CHKStatusUnknown;
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	while (_checkout.token && checkoutStatus != CHKStatusFailed && checkoutStatus != CHKStatusComplete) {
		NSLog(@"Checking completion status...");
		NSURLSessionDataTask *task = [_checkoutDataProvider getCompletionStatusOfCheckout:_checkout block:^(CHKCheckout *returnedCheckout, CHKStatus returnedStatus, NSError *error) {
			XCTAssertNil(error);
			XCTAssertNotNil(returnedCheckout);
			
			checkoutStatus = returnedStatus;
			dispatch_semaphore_signal(semaphore);
		}];
		WAIT_FOR_TASK(task, semaphore);
		
		if (checkoutStatus != CHKStatusComplete) {
			[NSThread sleepForTimeInterval:0.5f];
		}
	}
	XCTAssertEqual(checkoutStatus, CHKStatusComplete);
}

- (void)verifyCompletedCheckout
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider getCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	XCTAssertNotNil(_checkout.orderId);
}

#pragma mark - Tests

- (void)testCheckoutAnywhereWithoutAuthToken
{
	[self createCart];
	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
	
	_checkoutDataProvider = [[CHKDataProvider alloc] initWithShopDomain:CHECKOUT_ANYWHERE_SHOP apiKey:@""];
	[_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqualObjects(error.domain, @"shopify");
		XCTAssertEqual(error.code, 401);
	}];
}

- (void)testCheckoutAnywhereFlowUsingCreditCard
{
	[self createCart];
	[self createCheckout];
	[self fetchShippingRates];
	[self updateCheckout];
	[self addCreditCardToCheckout];
	[self completeCheckout];
	
	[self pollUntilCheckoutIsComplete];
	[self verifyCompletedCheckout];
}

- (void)testCheckoutAnywhereFlowUsingStripeToken
{
	[self createCart];
	[self createCheckout];
	[self fetchShippingRates];
	[self updateCheckout];
	[self fetchStripeToken];
	[self completeCheckoutWithStripeToken];
	[self pollUntilCheckoutIsComplete];
	[self verifyCompletedCheckout];
}

#pragma mark - Test Data

- (CHKAddress *)billingAddress
{
	CHKAddress *address = [[CHKAddress alloc] init];
	address.address1 = @"150 Elgin Street";
	address.address2 = @"8th Floor";
	address.city = @"Ottawa";
	address.company = @"Shopify Inc.";
	address.firstName = @"Test Guy";
	address.lastName = @"マクドナルドス";
	address.phone = @"1-555-555-5555";
	address.countryCode = @"CA";
	address.provinceCode = @"ON";
	address.zip = @"K1N5T5";
	return address;
}

- (CHKAddress *)shippingAddress
{
	CHKAddress *address = [[CHKAddress alloc] init];
	address.address1 = @"126 York Street";
	address.address2 = @"2nd Floor";
	address.city = @"Ottawa";
	address.company = @"Shopify Inc.";
	address.firstName = @"Tobi";
	address.lastName = @"Lütke";
	address.phone = @"1-555-555-5555";
	address.countryCode = @"CA";
	address.provinceCode = @"ON";
	address.zip = @"K1N5T5";
	return address;
}

@end

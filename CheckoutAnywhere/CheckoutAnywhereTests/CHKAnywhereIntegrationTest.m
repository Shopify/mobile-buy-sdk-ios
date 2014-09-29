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
}

- (void)setUp
{
	[super setUp];
	
	_checkoutDataProvider = [[CHKDataProvider alloc] initWithShopDomain:@"coffeehut.myshopify.com"];
	_storefrontDataProvider = [[MERDataProvider alloc] initWithShopDomain:@"coffeehut.myshopify.com"];
	
	_collections = [[NSMutableArray alloc] init];
	_products = [[NSMutableArray alloc] init];
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

#pragma mark - Tests

- (CHKAddress *)testBillingAddress
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

- (CHKAddress *)testShippingAddress
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

- (void)testCheckoutAnywhereFlow
{
	[self fetchShop];
	[self fetchCollections];
	[self fetchProducts];
	
	//=======================================
	//1) Create the base cart
	//=======================================
	CHKCart *cart = [[CHKCart alloc] init];
	[cart addVariant:[_products[0] variants][0]];
	
	//=======================================
	//2) Create the checkout with Shopify
	//=======================================
	__block CHKCheckout *checkout = [[CHKCheckout alloc] initWithCart:cart];
	checkout.shippingAddress = [self testShippingAddress];
	checkout.billingAddress = [self testBillingAddress];
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	XCTAssertEqualObjects(checkout.shippingAddress.address1, @"126 York Street");
	XCTAssertEqualObjects(checkout.billingAddress.address1, @"150 Elgin Street");
	
	//=======================================
	//2) Fetch shipping rates
	//=======================================
	__block NSArray *shippingRates = nil;
	__block CHKStatus shippingStatus = CHKStatusUnknown;
	while (checkout.token && shippingStatus != CHKStatusFailed && shippingStatus != CHKStatusComplete) {
		NSLog(@"Fetching shipping rates...");
		task = [_checkoutDataProvider getShippingRatesForCheckout:checkout block:^(NSArray *returnedShippingRates, CHKStatus status, NSError *error) {
			XCTAssertNil(error);
			shippingStatus = status;
			if (shippingStatus == CHKStatusComplete) {
				XCTAssertNotNil(returnedShippingRates);
				shippingRates = returnedShippingRates;
			}
			dispatch_semaphore_signal(semaphore);
		}];
		WAIT_FOR_TASK(task, semaphore);
		
		if (shippingStatus != CHKStatusComplete) {
			[NSThread sleepForTimeInterval:0.5f];
		}
	}
	XCTAssertTrue([shippingRates count] > 0);
	XCTAssertEqual(shippingStatus, CHKStatusComplete);
	
	//=======================================
	//3) Add some information to it
	//=======================================
	checkout.email = @"banana@testasaurus.com";
	checkout.shippingRate = shippingRates[0];
	task = [_checkoutDataProvider updateCheckout:checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	XCTAssertEqualObjects(checkout.email, @"banana@testasaurus.com");
	
	//=======================================
	//5) Store a credit card on the secure server
	//=======================================
	CHKCreditCard *creditCard = [[CHKCreditCard alloc] init];
	creditCard.number = @"4242424242424242";
	creditCard.expiryMonth = @"12";
	creditCard.expiryYear = @"20";
	creditCard.cvv = @"123";
	creditCard.nameOnCard = @"Dinosaur Banana";
	task = [_checkoutDataProvider storeCreditCard:creditCard checkout:checkout completion:^(CHKCheckout *returnedCheckout, NSString *paymentSessionId, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(paymentSessionId);
		XCTAssertNotNil(returnedCheckout);
		
		checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	
	//=======================================
	//6) Complete the checkout
	//=======================================
	task = [_checkoutDataProvider completeCheckout:checkout block:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	
	//=======================================
	//7) Poll for job status
	//=======================================
	__block CHKStatus checkoutStatus = CHKStatusUnknown;
	while (checkout.token && checkoutStatus != CHKStatusFailed && checkoutStatus != CHKStatusComplete) {
		NSLog(@"Checking completion status...");
		task = [_checkoutDataProvider getCompletionStatusOfCheckout:checkout block:^(CHKCheckout *returnedCheckout, CHKStatus returnedStatus, NSError *error) {
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
	
	//=======================================
	//8) Fetch the checkout again
	//=======================================
	task = [_checkoutDataProvider getCheckout:checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	XCTAssertNotNil(checkout.orderId);
}

@end

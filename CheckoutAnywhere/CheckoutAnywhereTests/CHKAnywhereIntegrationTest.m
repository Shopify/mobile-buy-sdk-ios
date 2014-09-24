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

@interface CHKAnywhereIntegrationTest : XCTestCase

@end

@implementation CHKAnywhereIntegrationTest {
	CHKDataProvider *_checkoutDataProvider;
	MERDataProvider *_storefrontDataProvider;
	
	MERShop *_shop;
	NSArray *_collections;
	NSArray *_products;
}

- (void)setUp
{
	[super setUp];
	
	_checkoutDataProvider = [[CHKDataProvider alloc] initWithShopDomain:@"dinobanana.myshopify.com"];
	_storefrontDataProvider = [[MERDataProvider alloc] initWithShopDomain:@"dinobanana.myshopify.com"];
}

#pragma mark - Helpers

- (void)fetchShop
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	[_storefrontDataProvider fetchShop:^(MERShop *shop, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(shop);
		
		_shop = shop;
		dispatch_semaphore_signal(semaphore);
	}];
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)fetchCollections
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	[_storefrontDataProvider fetchCollections:^(NSArray *collections, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(collections);
		
		_collections = collections;
		dispatch_semaphore_signal(semaphore);
	}];
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)fetchProducts
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	[_storefrontDataProvider fetchProducts:^(NSArray *products, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		
		_products = products;
		dispatch_semaphore_signal(semaphore);
	}];
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

#pragma mark - Tests

- (CHKAddress *)testBillingAddress
{
	CHKAddress *address = [[CHKAddress alloc] init];
	address.address1 = @"150 Elgin Street";
	address.address2 = @"8th Floor";
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
	
	//1) Create the base cart
	CHKCart *cart = [[CHKCart alloc] init];
	[cart addVariant:[_products[0] variants][0]];
	
	//2) Create the checkout with Shopify
	__block CHKCheckout *checkout;
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	[_checkoutDataProvider createCheckoutWithCart:cart completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNotNil(returnedCheckout);
		XCTAssertNil(error);
		
		checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
	
	//3) Add some information to it
	checkout.email = @"banana@testausaurus.com";
	checkout.shippingAddress = [self testShippingAddress];
	checkout.billingAddress = [self testBillingAddress];
	
	[_checkoutDataProvider updateCheckout:checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNotNil(returnedCheckout);
		XCTAssertNil(error);
		
		checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

@end

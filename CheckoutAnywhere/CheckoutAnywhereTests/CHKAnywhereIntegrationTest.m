//
//  CHKAnywhereIntegrationTest.m
//  Checkout
//
//  Created by Shopify on 2014-09-19.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "Checkout.h"
#import "CHKTestConstants.h"
#import "CHKGiftCard.h"
#import "NSProcessInfo+Environment.h"

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
	
	CHKShop *_shop;
	NSMutableArray *_collections;
	NSMutableArray *_products;
	
	CHKCart *_cart;
	CHKCheckout *_checkout;
	NSArray *_shippingRates;
	CHKGiftCard *_giftCard;
    
    
    NSString *shopDomain;
    NSString *apiKey;
    NSString *giftCardCode;
    NSString *expiredGiftCardCode;
    NSString *expiredGiftCardId;
}

- (void)setUp
{
	[super setUp];
    
    shopDomain = [NSProcessInfo environmentForKey:kCHKTestDomain];
    apiKey = [NSProcessInfo environmentForKey:kCHKTestAPIKey];
    giftCardCode = [NSProcessInfo environmentForKey:kCHKTestGiftCardCode];
    expiredGiftCardCode = [NSProcessInfo environmentForKey:kCHKTestExpiredGiftCardCode];
    expiredGiftCardId = [NSProcessInfo environmentForKey:kCHKTestExpiredGiftCardID];
    
    NSLog(@"Creds: %@ \n%@ \n%@ \n%@ \n%@", shopDomain, apiKey, giftCardCode, expiredGiftCardCode, expiredGiftCardId);
    
    
	XCTAssert([shopDomain length] > 0, @"You must provide a valid CHECKOUT_ANYWHERE_SHOP. This is your 'shopname.myshopify.com' address.");
	XCTAssertEqualObjects([shopDomain substringFromIndex:shopDomain.length - 14], @".myshopify.com", @"You must provide a valid CHECKOUT_ANYWHERE_SHOP. This is your 'shopname.myshopify.com' address.");
	XCTAssert([apiKey length] > 0, @"You must provide a valid CHECKOUT_ANYHWERE_API_KEY. This is the API_KEY of your app.");
	
	_checkoutDataProvider = [[CHKDataProvider alloc] initWithShopDomain:shopDomain apiKey:apiKey];
	
	_collections = [[NSMutableArray alloc] init];
	_products = [[NSMutableArray alloc] init];
	
	//TODO: This currently does a bunch of API calls. We should add some fixtures to the tests.
	[self fetchShop];
	[self fetchCollections];
	[self fetchProducts];
}

#pragma mark - Helpers

- (void)fetchShop
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider getShop:^(CHKShop *shop, NSError *error) {
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
		NSURLSessionDataTask *task = [_checkoutDataProvider getCollectionsPage:currentPage completion:^(NSArray *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {
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
		NSURLSessionDataTask *task = [_checkoutDataProvider getProductsPage:currentPage completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
			done = reachedEnd || error;
			
			XCTAssertNil(error, @"There was an error getting your store's products");
			XCTAssertNotNil(products, @"Add products to your store for tests to pass");

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
		NSURLSessionDataTask *task = [_checkoutDataProvider getShippingRatesForCheckout:_checkout completion:^(NSArray *returnedShippingRates, CHKStatus status, NSError *error) {
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
		XCTAssertNotNil(returnedCheckout.shippingRate.shippingRateIdentifier);
		XCTAssertNotNil(returnedCheckout.email);
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

- (void)completeCheckout
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider completeCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
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
	__block NSError *checkoutError = nil;
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	while (_checkout.token && checkoutStatus != CHKStatusFailed && checkoutStatus != CHKStatusComplete) {
		NSLog(@"Checking completion status...");
		NSURLSessionDataTask *task = [_checkoutDataProvider getCompletionStatusOfCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, CHKStatus returnedStatus, NSError *error) {
			XCTAssertNil(error);
			XCTAssertNotNil(returnedCheckout);
			
			checkoutError = error;
			checkoutStatus = returnedStatus;
			dispatch_semaphore_signal(semaphore);
		}];
		WAIT_FOR_TASK(task, semaphore);
		
		if (checkoutStatus != CHKStatusComplete) {
			[NSThread sleepForTimeInterval:0.5f];
		}
	}
	XCTAssertNil(checkoutError);
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

- (void)testApplyingGiftCardToCheckout
{
	[self createCart];
	[self createCheckout];
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider applyGiftCardWithCode:giftCardCode toCheckout:_checkout completion:^(CHKGiftCard *giftCard, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured GIFT_CARD_CODE above
		XCTAssertNil(error);
		XCTAssertNotNil(giftCard);
		XCTAssertEqualObjects([giftCardCode substringWithRange:NSMakeRange(giftCardCode.length - 4, 4)], giftCard.lastCharacters);
		_giftCard = giftCard;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testApplyingInvalidGiftCardToCheckout
{
	[self createCart];
	[self createCheckout];
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider applyGiftCardWithCode:@"000" toCheckout:_checkout completion:^(CHKGiftCard *giftCard, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testApplyingExpiredGiftCardToCheckout
{
	[self createCart];
	[self createCheckout];
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider applyGiftCardWithCode:expiredGiftCardCode toCheckout:_checkout completion:^(CHKGiftCard *giftCard, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testRemovingGiftCardFromCheckout
{
	[self testApplyingGiftCardToCheckout];
	
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider removeGiftCard:_giftCard fromCheckout:_checkout completion:^(CHKGiftCard *giftCard, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured GIFT_CARD_CODE above
		XCTAssertNil(error);
		XCTAssertNotNil(giftCard);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testRemovingInvalidGiftCardFromCheckout
{
	[self testApplyingGiftCardToCheckout];
	
	CHKGiftCard *giftCard = [[CHKGiftCard alloc] initWithDictionary:@{ @"id" : @"000" }];
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider removeGiftCard:giftCard fromCheckout:_checkout completion:^(CHKGiftCard *giftCard, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testRemovingExpiredGiftCardFromCheckout
{
	[self testApplyingGiftCardToCheckout];
	
	CHKGiftCard *giftCard = [[CHKGiftCard alloc] initWithDictionary:@{ @"id" : expiredGiftCardId }];
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider removeGiftCard:giftCard fromCheckout:_checkout completion:^(CHKGiftCard *giftCard, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testCheckoutAnywhereWithoutAuthToken
{
	[self createCart];
	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

	_checkoutDataProvider = [[CHKDataProvider alloc] initWithShopDomain:shopDomain apiKey:@""];
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqualObjects(error.domain, @"shopify");
		XCTAssertEqual(error.code, 401);
        dispatch_semaphore_signal(semaphore);
	}];
    
    WAIT_FOR_TASK(task, semaphore);
}

- (void)testCheckoutAnywhereWithInvalidShop
{
	[self createCart];
	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

	_checkoutDataProvider = [[CHKDataProvider alloc] initWithShopDomain:@"asdfdsasdfdsasdfdsadsfowinfaoinfw.myshopify.com" apiKey:apiKey];
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqualObjects(error.domain, @"shopify");
		XCTAssertEqual(error.code, 404);
        dispatch_semaphore_signal(semaphore);

	}];
    
    WAIT_FOR_TASK(task, semaphore);
}

- (void)testFetchingShippingRatesWithoutShippingAddressShouldReturnPreconditionFailed
{
	[self createCart];
	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
	
	task = [_checkoutDataProvider getShippingRatesForCheckout:_checkout completion:^(NSArray *returnedShippingRates, CHKStatus status, NSError *error) {
		XCTAssertEqual(CHKStatusPreconditionFailed, status);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testFetchingShippingRatesForInvalidCheckoutShouldReturnNotFound
{
	CHKCheckout *checkout = [[CHKCheckout alloc] init];
	checkout.token = @"bananaaaa";

	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider getShippingRatesForCheckout:checkout completion:^(NSArray *returnedShippingRates, CHKStatus status, NSError *error) {
		XCTAssertEqual(CHKStatusNotFound, status);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
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

- (void)testCheckoutAnywhereWithAPartialAddress
{
	[self createCart];
	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
	_checkout.shippingAddress = [self partialShippingAddress];
	
	//Create the checkout
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);

	//Fetch the rates
	[self fetchShippingRates];
	
	//Select the first rate
	[self updateCheckout];
	
	//Update with full addresses
	_checkout.shippingAddress = [self shippingAddress];
	_checkout.billingAddress = [self billingAddress];
	[self updateCheckout];
	
	//We use a credit card here because we're not generating apple pay tokens in the tests
	[self addCreditCardToCheckout];
	[self completeCheckout];
	[self pollUntilCheckoutIsComplete];
	[self verifyCompletedCheckout];
}

- (void)testCheckoutAnywhereWithApplicableDiscount
{
	[self createCart];

	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
	_checkout.discount = [self applicableDiscount];
	
	//Create the checkout
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you create the following discounts on your test shop:
		//
		// applicable 	- this should be valid
		// inapplicable - this should be invalid (i.e expired)
		//
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		_checkout = returnedCheckout;
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);

	XCTAssertNotNil(_checkout.discount);
	XCTAssertTrue(_checkout.discount.applicable);
}

- (void)testCheckoutAnywhereWithInapplicableDiscount
{
	[self createCart];

	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
	_checkout.discount = [self inapplicableDiscount];

	//Create the checkout
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssert(error);
		XCTAssertEqual(422, error.code); //This is a validation error
		XCTAssertNil(returnedCheckout);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testCheckoutAnywhereWithNonExistentDiscount
{
	[self createCart];

	_checkout = [[CHKCheckout alloc] initWithCart:_cart];
	_checkout.discount = [self nonExistentDiscount];

	//Create the checkout
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_checkoutDataProvider createCheckout:_checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(error.code, 422);
		NSDictionary *info = [error userInfo];
		XCTAssertNotNil(info[@"errors"][@"checkout"][@"discount"][@"code"]);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
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

- (CHKAddress *)partialShippingAddress
{
	CHKAddress *address = [[CHKAddress alloc] init];
	address.address1 = @"--";
	address.city = @"Ottawa";
	address.firstName = @"---";
	address.lastName = @"---";
	address.countryCode = @"CA";
	address.provinceCode = @"ON";
	address.zip = @"K1N5T5";
	return address;
}

- (CHKDiscount *)applicableDiscount
{
	CHKDiscount *discount = [[CHKDiscount alloc] initWithCode:@"applicable"];
	return discount;
}

- (CHKDiscount *)inapplicableDiscount
{
	CHKDiscount *discount = [[CHKDiscount alloc] initWithCode:@"inapplicable"];
	return discount;
}

- (CHKDiscount *)nonExistentDiscount
{
	CHKDiscount *discount = [[CHKDiscount alloc] initWithCode:@"asdfasdfasdfasdf"];
	return discount;
}

@end

//
//  BUYAnywhereIntegrationTest.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-19.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import <Buy/Buy.h>
#import "BUYTestConstants.h"
#import "BUYAddress+Additions.h"
#import "BUYCheckout_Private.h"
#import "BUYClient+Test.h"

@interface BUYIntegrationTest : XCTestCase
@end

@implementation BUYIntegrationTest {
	BUYClient *_checkoutClient;
	
	NSMutableArray *_products;
	
	BUYCart *_cart;
	BUYCheckout *_checkout;
	NSArray *_shippingRates;
	BUYGiftCard *_giftCard;
	
	
	NSString *shopDomain;
	NSString *apiKey;
	NSString *channelId;
	NSString *giftCardCode;
	NSString *giftCardCode2;
	NSString *giftCardCode3;
	NSString *expiredGiftCardCode;
	NSString *expiredGiftCardId;
}

- (void)setUp
{
	[super setUp];
	
	NSDictionary *environment = [[NSProcessInfo processInfo] environment];
	shopDomain = environment[kBUYTestDomain];
	apiKey = environment[kBUYTestAPIKey];
	channelId = environment[kBUYTestChannelId];
	giftCardCode = environment[kBUYTestGiftCardCode];
	giftCardCode2 = environment[kBUYTestGiftCardCode2];
	giftCardCode3 = environment[kBUYTestGiftCardCode3];
	expiredGiftCardCode = environment[kBUYTestExpiredGiftCardCode];
	expiredGiftCardId = environment[kBUYTestExpiredGiftCardID];
	
	XCTAssert([shopDomain length] > 0, @"You must provide a valid shop domain. This is your 'shopname.myshopify.com' address.");
	XCTAssertEqualObjects([shopDomain substringFromIndex:shopDomain.length - 14], @".myshopify.com", @"You must provide a valid shop domain. This is your 'shopname.myshopify.com' address.");
	XCTAssert([apiKey length] > 0, @"You must provide a valid API Key.");
	XCTAssert([channelId length], @"You must provide a valid Channel ID");
	
	_checkoutClient = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
	
	_products = [[NSMutableArray alloc] init];
	
	//TODO: This currently does a bunch of API calls. We should add some fixtures to the tests.
	[self fetchProducts];
}

#pragma mark - Helpers

- (void)fetchProducts
{
	__block BOOL done = NO;
	NSUInteger currentPage = 0;
	while (done == NO) {
		XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
		
		[_checkoutClient getProductsPage:currentPage completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
			done = reachedEnd || error;
			
			XCTAssertNil(error, @"There was an error getting your store's products");
			XCTAssertNotNil(products, @"Add products to your store for tests to pass");
			
			[_products addObjectsFromArray:products];
			[expectation fulfill];
		}];
		
		if (done == NO) {
			++currentPage;
		}
		
		[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
			XCTAssertNil(error);
		}];
	}
	
	NSLog(@"Fetched products (Pages: %d, Count: %d)", (int)(currentPage + 1), (int)[_products count]);
}

- (void)createCart
{
	_cart = [[BUYCart alloc] init];
	for (BUYProduct *product in _products) {
		if ([product.productId isEqualToNumber:@458943719]) {
			[_cart addVariant:product.variants[0]];
			return;
		}
	}
}

- (void)createCheckout
{
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	_checkout.shippingAddress = [self shippingAddress];
	_checkout.billingAddress = [self billingAddress];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	XCTAssertEqualObjects(_checkout.shippingAddress.address1, @"126 York Street");
	XCTAssertEqualObjects(_checkout.billingAddress.address1, @"150 Elgin Street");
}

- (void)fetchShippingRates
{
	__block BUYStatus shippingStatus = BUYStatusUnknown;
	
	do {
		NSLog(@"Fetching shipping rates...");
		XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
		
		[_checkoutClient getShippingRatesForCheckout:_checkout completion:^(NSArray *returnedShippingRates, BUYStatus status, NSError *error) {
			XCTAssertNil(error);
			shippingStatus = status;
			if (shippingStatus == BUYStatusComplete) {
				XCTAssertNotNil(returnedShippingRates);
				_shippingRates = returnedShippingRates;
			}
			[expectation fulfill];
		}];
		
		[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
			XCTAssertNil(error);
		}];
		
		if (shippingStatus == BUYStatusProcessing) {
			[NSThread sleepForTimeInterval:0.5f];
		}
	} while (shippingStatus == BUYStatusProcessing);
	
	XCTAssertTrue([_shippingRates count] > 0);
	XCTAssertEqual(shippingStatus, BUYStatusComplete);
}

- (void)updateCheckout
{
	_checkout.email = @"banana@testasaurus.com";
	_checkout.shippingRate = _shippingRates[0];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient updateCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		XCTAssertNotNil(returnedCheckout.shippingRate.shippingRateIdentifier);
		XCTAssertNotNil(returnedCheckout.email);
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	XCTAssertEqualObjects(_checkout.email, @"banana@testasaurus.com");
}

- (void)addCreditCardToCheckout
{
	BUYCreditCard *creditCard = [[BUYCreditCard alloc] init];
	creditCard.number = @"4242424242424242";
	creditCard.expiryMonth = @"12";
	creditCard.expiryYear = @"20";
	creditCard.cvv = @"123";
	creditCard.nameOnCard = @"Dinosaur Banana";
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient storeCreditCard:creditCard checkout:_checkout completion:^(BUYCheckout *returnedCheckout, NSString *paymentSessionId, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(paymentSessionId);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)completeCheckout
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient completeCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)pollUntilCheckoutIsComplete
{
	__block BUYStatus checkoutStatus = BUYStatusUnknown;
	__block NSError *checkoutError = nil;
	
	while (_checkout.token && checkoutStatus != BUYStatusFailed && checkoutStatus != BUYStatusComplete) {
		
		NSLog(@"Checking completion status...");
		XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
		
		[_checkoutClient getCompletionStatusOfCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, BUYStatus returnedStatus, NSError *error) {
			XCTAssertNil(error);
			XCTAssertNotNil(returnedCheckout);
			
			checkoutError = error;
			checkoutStatus = returnedStatus;
			[expectation fulfill];
		}];
		
		[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
			XCTAssertNil(error);
		}];
		
		if (checkoutStatus != BUYStatusComplete) {
			[NSThread sleepForTimeInterval:0.5f];
		}
	}
	XCTAssertNil(checkoutError);
	XCTAssertEqual(checkoutStatus, BUYStatusComplete);
}

- (void)verifyCompletedCheckout
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient getCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	XCTAssertNotNil(_checkout.orderId);
}

#pragma mark - Tests

- (void)testApplyingGiftCardToCheckout
{
	[self createCart];
	[self createCheckout];
	
	NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"225.75"];
	NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
	XCTAssertEqual(result, NSOrderedSame);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient applyGiftCardWithCode:giftCardCode toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		_giftCard = _checkout.giftCards[0];
		XCTAssertNotNil(_giftCard);
		XCTAssertEqualObjects([giftCardCode substringWithRange:NSMakeRange(giftCardCode.length - 4, 4)], _giftCard.lastCharacters);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"215.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		NSDecimalNumber *amountUsed = [NSDecimalNumber decimalNumberWithString:@"10.00"];
		result = [_giftCard.amountUsed compare:amountUsed];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testApplyingInvalidGiftCardToCheckout
{
	[self createCart];
	[self createCheckout];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient applyGiftCardWithCode:@"000" toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"225.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testApplyingExpiredGiftCardToCheckout
{
	[self createCart];
	[self createCheckout];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient applyGiftCardWithCode:expiredGiftCardCode toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"225.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingGiftCardFromCheckout
{
	[self testApplyingGiftCardToCheckout];
	BUYGiftCard *giftCard = _checkout.giftCards[0];
	
	NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"215.75"];
	NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
	XCTAssertEqual(result, NSOrderedSame);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient removeGiftCard:giftCard fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		XCTAssertTrue([checkout.giftCards count] == 0);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"225.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingInvalidGiftCardFromCheckout
{
	[self testApplyingGiftCardToCheckout];
	
	BUYGiftCard *giftCard = [[BUYGiftCard alloc] initWithDictionary:@{ @"id" : @"000" }];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient removeGiftCard:giftCard fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"215.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingExpiredGiftCardFromCheckout
{
	[self testApplyingGiftCardToCheckout];
	
	BUYGiftCard *giftCard = [[BUYGiftCard alloc] initWithDictionary:@{ @"id" : expiredGiftCardId }];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient removeGiftCard:giftCard fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"215.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testAddingTwoGiftCards
{
	[self testApplyingGiftCardToCheckout];
	XCTAssertEqual([_checkout.giftCards count], 1);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient applyGiftCardWithCode:giftCardCode2 toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 2);
		
		BUYGiftCard *giftCard2 = _checkout.giftCards[1];
		XCTAssertEqualObjects([giftCardCode2 substringWithRange:NSMakeRange(giftCardCode2.length - 4, 4)], giftCard2.lastCharacters);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"205.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testAddingThreeGiftCards
{
	[self testAddingTwoGiftCards];
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient applyGiftCardWithCode:giftCardCode3 toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 3);
		
		BUYGiftCard *giftCard3 = _checkout.giftCards[2];
		XCTAssertEqualObjects([giftCardCode3 substringWithRange:NSMakeRange(giftCardCode3.length - 4, 4)], giftCard3.lastCharacters);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"195.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingSecondGiftCard
{
	[self testAddingThreeGiftCards];
	XCTAssertEqual([_checkout.giftCards count], 3);
	
	BUYGiftCard *giftCard2 = _checkout.giftCards[1];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient removeGiftCard:giftCard2 fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 2);
		
		BUYGiftCard *giftCard3 = _checkout.giftCards[1];
		XCTAssertEqualObjects([giftCardCode3 substringWithRange:NSMakeRange(giftCardCode3.length - 4, 4)], giftCard3.lastCharacters);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"205.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingFirstGiftCard
{
	[self testRemovingSecondGiftCard];
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	BUYGiftCard *giftCard1 = _checkout.giftCards[0];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient removeGiftCard:giftCard1 fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 1);
		
		BUYGiftCard *giftCard3 = _checkout.giftCards[0];
		XCTAssertEqualObjects([giftCardCode3 substringWithRange:NSMakeRange(giftCardCode3.length - 4, 4)], giftCard3.lastCharacters);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"215.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingAllGiftCards
{
	[self testRemovingFirstGiftCard];
	XCTAssertEqual([_checkout.giftCards count], 1);
	
	BUYGiftCard *giftCard3 = _checkout.giftCards[0];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient removeGiftCard:giftCard3 fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 0);
		
		NSDecimalNumber *paymentDue = [NSDecimalNumber decimalNumberWithString:@"225.75"];
		NSComparisonResult result = [_checkout.paymentDue compare:paymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCheckoutAnywhereWithoutAuthToken
{
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	_checkoutClient = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:@"" channelId:nil];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqualObjects(error.domain, @"shopify");
		XCTAssertEqual(error.code, 401);
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCheckoutAnywhereWithInvalidShop
{
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	_checkoutClient = [[BUYClient alloc] initWithShopDomain:@"asdfdsasdfdsasdfdsadsfowinfaoinfw.myshopify.com" apiKey:apiKey channelId:nil];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqualObjects(error.domain, @"shopify");
		XCTAssertEqual(error.code, 404);
		[expectation fulfill];
		
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testFetchingShippingRatesWithoutShippingAddressShouldReturnPreconditionFailed
{
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	
	XCTestExpectation *expectation2 = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[_checkoutClient getShippingRatesForCheckout:_checkout completion:^(NSArray *returnedShippingRates, BUYStatus status, NSError *error) {
		XCTAssertEqual(BUYStatusPreconditionFailed, status);
		[expectation2 fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testFetchingShippingRatesForInvalidCheckoutShouldReturnNotFound
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:nil];
	checkout.token = @"bananaaaa";
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient getShippingRatesForCheckout:checkout completion:^(NSArray *returnedShippingRates, BUYStatus status, NSError *error) {
		XCTAssertEqual(BUYStatusNotFound, status);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
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

- (void)testCheckoutAnywhereWithAPartialAddress
{
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	_checkout.shippingAddress = [self partialShippingAddress];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
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
	
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	_checkout.discount = [self applicableDiscount];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you create the following discounts on your test shop:
		//
		// applicable 	- this should be valid
		// inapplicable - this should be invalid (i.e expired)
		//
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	XCTAssertNotNil(_checkout.discount);
	XCTAssertTrue(_checkout.discount.applicable);
}

- (void)testCheckoutAnywhereWithInapplicableDiscount
{
	[self createCart];
	
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	_checkout.discount = [self inapplicableDiscount];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssert(error);
		XCTAssertEqual(422, error.code); //This is a validation error
		XCTAssertNil(returnedCheckout);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCheckoutAnywhereWithNonExistentDiscount
{
	[self createCart];
	
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	_checkout.discount = [self nonExistentDiscount];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(error.code, 422);
		NSDictionary *info = [error userInfo];
		XCTAssertNotNil(info[@"errors"][@"checkout"][@"discount"][@"code"]);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testIntegration
{
	XCTAssertTrue([_checkoutClient testIntegrationWithMerchantId:nil]);
	XCTAssertTrue([_checkoutClient testIntegrationWithMerchantId:@"merchant.com.shopify.applepay"]);

	BUYClient *badClient = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:@"asdvfdbfdgasfgdsfg"];
	XCTAssertFalse([badClient testIntegrationWithMerchantId:nil]);
	
	badClient = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:@"sadgsefgsdfgsdfgsdfg" channelId:channelId];
	XCTAssertFalse([badClient testIntegrationWithMerchantId:nil]);
	
	badClient = [[BUYClient alloc] initWithShopDomain:@"asdvfdbfdgasfgdsfg.myshopify.com" apiKey:apiKey channelId:channelId];
	XCTAssertFalse([badClient testIntegrationWithMerchantId:nil]);
	
	XCTAssertFalse([badClient testIntegrationWithMerchantId:@"blah"]);
}

#pragma mark - Test Data

- (BUYAddress *)billingAddress
{
	BUYAddress *address = [[BUYAddress alloc] init];
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

- (BUYAddress *)shippingAddress
{
	BUYAddress *address = [[BUYAddress alloc] init];
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

- (BUYAddress *)partialShippingAddress
{
	BUYAddress *address = [[BUYAddress alloc] init];
	address.address1 = BUYPartialAddressPlaceholder;
	address.city = @"Ottawa";
	address.firstName = BUYPartialAddressPlaceholder;
	address.lastName = BUYPartialAddressPlaceholder;
	address.countryCode = @"CA";
	address.provinceCode = @"ON";
	address.zip = @"K1N5T5";
	address.phone = BUYPartialAddressPlaceholder;
	return address;
}

- (BUYDiscount *)applicableDiscount
{
	BUYDiscount *discount = [[BUYDiscount alloc] initWithCode:@"applicable"];
	return discount;
}

- (BUYDiscount *)inapplicableDiscount
{
	BUYDiscount *discount = [[BUYDiscount alloc] initWithCode:@"inapplicable"];
	return discount;
}

- (BUYDiscount *)nonExistentDiscount
{
	BUYDiscount *discount = [[BUYDiscount alloc] initWithCode:@"asdfasdfasdfasdf"];
	return discount;
}

- (void)testReservationTimeModification
{
	[self createCart];
	
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_checkoutClient createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		
		XCTAssertNil(error);
		
		_checkout = returnedCheckout;
		XCTAssertEqual(300, returnedCheckout.reservationTime.intValue);
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	
	XCTestExpectation *expectation2 = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	_checkout.reservationTime = @0;
	
	[_checkoutClient updateCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		
		XCTAssertEqual(0, returnedCheckout.reservationTime.intValue);
		[expectation2 fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

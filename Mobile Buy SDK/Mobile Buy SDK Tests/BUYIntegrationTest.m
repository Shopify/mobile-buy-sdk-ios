//
//  BUYIntegrationTest.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

@import UIKit;
@import XCTest;
@import Buy;

#import "BUYClient+Routing.h"

#import "BUYTestConstants.h"
#import "BUYClientTestBase.h"

#import <OHHTTPStubs/OHHTTPStubs.h>
#import "OHHTTPStubsResponse+Helpers.h"

@interface BUYIntegrationTest : BUYClientTestBase
@end

@implementation BUYIntegrationTest {
	
	BUYModelManager *_modelManager;

	NSMutableArray *_products;
	
	BUYCart *_cart;
	BUYCheckout *_checkout;
	NSArray *_shippingRates;
	BUYGiftCard *_giftCard;
}

- (void)setUp
{
	[super setUp];
	
	_modelManager = [BUYModelManager modelManager];
	_products = [[NSMutableArray alloc] init];
	
	[self fetchProducts];
}

- (void)tearDown {
	[super tearDown];
	
	[OHHTTPStubs removeAllStubs];
}

#pragma mark - Helpers

- (void)fetchProducts
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetProductPage_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client getProductsByIds:self.productIds completion:^(NSArray *products, NSError *error) {
		
		XCTAssertNil(error, @"There was an error getting your store's products");
		XCTAssertNotNil(products, @"Add products to your store for tests to pass");
		
		[_products addObjectsFromArray:products];
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	
	NSLog(@"Fetched products (count: %tu", _products.count);
}

- (void)createCart
{
	_cart = [_modelManager insertCartWithJSONDictionary:nil];
	for (BUYProduct *product in _products) {
		[_cart addVariant:product.variants[0]];
	}
}

- (void)createCheckout
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCheckoutFlowUsingCreditCard_1" useMocks:[self shouldUseMocks]];
	
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];
	_checkout.shippingAddress = [self shippingAddress];
	_checkout.billingAddress = [self billingAddress];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	XCTAssertEqualObjects(_checkout.shippingAddress.address1, @"150 Elgin Street");
	XCTAssertEqualObjects(_checkout.billingAddress.address1, @"150 Elgin Street");
}

- (void)testCheckoutAttributesAndNotes
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCheckoutFlowUsingCreditCard_1" useMocks:[self shouldUseMocks]];
	
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];

	NSString *note = @"Order note";
	_checkout.note = note;
	NSArray *attributes = @[ [[BUYCheckoutAttribute alloc] initWithModelManager:_modelManager JSONDictionary:@{ @"name" : @"attribute1", @"value" : @"value1" }],
							 [[BUYCheckoutAttribute alloc] initWithModelManager:_modelManager JSONDictionary:@{ @"name" : @"attribute2", @"value" : @"value2" }] ];
	_checkout.attributes = [NSSet setWithArray:attributes];
	 
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		XCTAssertEqualObjects(returnedCheckout.note, note);
		XCTAssertEqualObjects(returnedCheckout.attributes, _checkout.attributes);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)fetchShippingRates
{
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testCheckoutFlowUsingCreditCard_2" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getShippingRatesForCheckoutWithToken:_checkout.token completion:^(NSArray *shippingRates, BUYStatus status, NSError *error) {
		XCTAssertNil(error);
		XCTAssertEqual(status, BUYStatusComplete);
		
		XCTAssertNotNil(shippingRates);
		XCTAssertTrue([shippingRates count] > 0);
		
		_shippingRates = shippingRates;
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {}];
}

- (void)updateCheckout
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCheckoutFlowUsingCreditCard_3" useMocks:[self shouldUseMocks]];
	_checkout.email = @"test@test.com";
	_checkout.shippingRate = _shippingRates[0];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client updateCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
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
	XCTAssertEqualObjects(_checkout.email, @"test@test.com");
}

- (id<BUYPaymentToken>)addCreditCardToCheckout
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testCheckoutFlowUsingCreditCard_4" useMocks:[self shouldUseMocks]];
	
	BUYCreditCard *creditCard = [self creditCard];
	__block id<BUYPaymentToken> token = nil;
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client storeCreditCard:creditCard checkout:_checkout completion:^(id<BUYPaymentToken> paymentToken, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(paymentToken);
		
		token = paymentToken;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	
	return token;
}

- (BUYCreditCard *)creditCard
{
	BUYCreditCard *creditCard = [[BUYCreditCard alloc] init];
	creditCard.number = @"4242424242424242";
	creditCard.expiryMonth = @"5";
	creditCard.expiryYear = @"2020";
	creditCard.cvv = @"123";
	creditCard.nameOnCard = @"John Smith";
	
	return creditCard;
}

- (void)completeCheckoutWithToken:(id<BUYPaymentToken>)paymentToken
{
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
		return [self shouldUseMocks];
	} withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
		NSString *path = request.URL.absoluteString.lastPathComponent;
		if ([path isEqualToString:[self.client urlForCheckoutsCompletionWithToken:_checkout.token].lastPathComponent]) {
			return [OHHTTPStubsResponse responseWithKey:@"testCheckoutFlowUsingCreditCard_5"];
			
		} else if ([path isEqualToString:[self.client urlForCheckoutsProcessingWithToken:_checkout.token].lastPathComponent]) {
			return [OHHTTPStubsResponse responseWithKey:@"testCheckoutFlowUsingCreditCard_14"];
			
		} else if ([path isEqualToString:[self.client urlForCheckoutsWithToken:_checkout.token].lastPathComponent]) {
			return [OHHTTPStubsResponse responseWithKey:@"testCheckoutFlowUsingCreditCard_15"];
		}
		return [OHHTTPStubsResponse responseWithData:[NSData new] statusCode:500 headers:nil];;
	}];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client completeCheckoutWithToken:_checkout.token paymentToken:paymentToken completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		XCTAssertNotNil(returnedCheckout.order);
		XCTAssertNotNil(returnedCheckout.order.identifier);
		XCTAssertNotNil(returnedCheckout.order.statusURL);
		XCTAssertNotNil(returnedCheckout.order.name);
		
		_checkout = returnedCheckout;
		
		[expectation fulfill];
		
		[self confirmCreditCard];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)confirmCreditCard
{
	BUYCreditCard *creditCard = [self creditCard];
	BUYMaskedCreditCard *maskedCard = _checkout.creditCard;
	
	NSArray *names = [creditCard.nameOnCard componentsSeparatedByString:@" "];
	XCTAssertEqualObjects(maskedCard.firstName, names.firstObject);
	XCTAssertEqualObjects(maskedCard.lastName, names.lastObject);
	
	XCTAssertEqual(maskedCard.expiryMonth.integerValue, creditCard.expiryMonth.integerValue);
	XCTAssertEqual(maskedCard.expiryYear.integerValue, creditCard.expiryYear.integerValue);

	XCTAssertEqualObjects(maskedCard.firstDigits, [creditCard.number substringWithRange:NSMakeRange(0, 6)]);
	XCTAssertEqualObjects(maskedCard.lastDigits, [creditCard.number substringWithRange:NSMakeRange(12, 4)]);
}

#pragma mark - Tests

- (void)testApplyingGiftCardToCheckout
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingGiftCardToCheckout_2" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardToCheckout];
}

- (void)applyGiftCardToCheckout
{
	// Check that we have a checkout with a paymentDue greater than 10
	XCTAssertGreaterThan([_checkout.paymentDue integerValue], 11);
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client applyGiftCardCode:self.giftCardCode toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		
		XCTAssertNil(error);
		_checkout = checkout;
		_giftCard = _checkout.giftCards[0];
		XCTAssertNotNil(_giftCard);
		XCTAssertEqualObjects([self.giftCardCode substringWithRange:NSMakeRange(self.giftCardCode.length - 4, 4)], _giftCard.lastCharacters);
		
		NSDecimalNumber *amountUsed = [NSDecimalNumber decimalNumberWithString:@"11.00"];
		NSComparisonResult result = [_giftCard.amountUsed compare:amountUsed];
		XCTAssertEqual(result, NSOrderedSame);
		
		NSDecimalNumber *paymentDue = [originalPaymentDue decimalNumberBySubtracting:amountUsed];
		result = [_checkout.paymentDue compare:paymentDue];
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
	
	// Check that we have a checkout with a paymentDue
	XCTAssertGreaterThan([_checkout.paymentDue integerValue], 1);
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingInvalidGiftCardToCheckout_2" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client applyGiftCardCode:@"000" toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSComparisonResult result = [_checkout.paymentDue compare:originalPaymentDue];
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
	
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingInvalidGiftCardToCheckout_2" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client applyGiftCardCode:self.giftCardCodeExpired toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSComparisonResult result = [_checkout.paymentDue compare:originalPaymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingGiftCardFromCheckout
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingGiftCardFromCheckout_2" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardToCheckout];
	
	BUYGiftCard *giftCard = _checkout.giftCards[0];
	
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	NSDecimalNumber *giftCardValue = [giftCard.amountUsed copy];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingGiftCardFromCheckout_3" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client removeGiftCard:giftCard fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		XCTAssertTrue([checkout.giftCards count] == 0);
		
		NSDecimalNumber *paymentDue = [originalPaymentDue decimalNumberByAdding:giftCardValue];
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
	
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingInvalidGiftCardFromCheckout_2" useMocks:[self shouldUseMocks]];
	
	BUYGiftCard *giftCard = [[BUYGiftCard alloc] initWithModelManager:_modelManager JSONDictionary:@{ @"id" : @(000) }];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client removeGiftCard:giftCard fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSComparisonResult result = [_checkout.paymentDue compare:originalPaymentDue];
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
	
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingExpiredGiftCardFromCheckout_2" useMocks:[self shouldUseMocks]];
	
	BUYGiftCard *giftCard = [[BUYGiftCard alloc] initWithModelManager:_modelManager JSONDictionary:@{ @"id" : self.giftCardIdExpired }];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client removeGiftCard:giftCard fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(422, error.code);
		
		NSComparisonResult result = [_checkout.paymentDue compare:originalPaymentDue];
		XCTAssertEqual(result, NSOrderedSame);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testAddingTwoGiftCards
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingTwoGiftCardsToCheckout_2" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 1);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingTwoGiftCardsToCheckout_3" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardTwoToCheckout];
}

- (void)applyGiftCardTwoToCheckout
{
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client applyGiftCardCode:self.giftCardCode2 toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 2);
		
		BUYGiftCard *giftCard2 = _checkout.giftCards[1];
		XCTAssertEqualObjects([self.giftCardCode2 substringWithRange:NSMakeRange(self.giftCardCode2.length - 4, 4)], giftCard2.lastCharacters);
		
		// Ensure the amount before applying the second gift card is greater than the new paymentDue amount
		XCTAssertGreaterThan([originalPaymentDue integerValue], [_checkout.paymentDue integerValue]);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testAddingThreeGiftCards
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingThreeGiftCardsToCheckout_2" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 1);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingThreeGiftCardsToCheckout_3" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardTwoToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testApplyingThreeGiftCardsToCheckout_4" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardThreeToCheckout];
}

- (void)applyGiftCardThreeToCheckout
{
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client applyGiftCardCode:self.giftCardCode3 toCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 3);
		
		BUYGiftCard *giftCard3 = _checkout.giftCards[2];
		XCTAssertEqualObjects([self.giftCardCode3 substringWithRange:NSMakeRange(self.giftCardCode3.length - 4, 4)], giftCard3.lastCharacters);
		
		// Ensure the amount before applying the third gift card is greater than the new paymentDue amount
		XCTAssertGreaterThan([originalPaymentDue integerValue], [_checkout.paymentDue integerValue]);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingSecondGiftCard
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingSecondGiftCard_2" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 1);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingSecondGiftCard_3" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardTwoToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingSecondGiftCard_4" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardThreeToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 3);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingSecondGiftCard_5" useMocks:[self shouldUseMocks]];
	
	[self removeSecondGiftCard];
}

- (void)removeSecondGiftCard
{
	BUYGiftCard *giftCard2 = _checkout.giftCards[1];
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client removeGiftCard:giftCard2 fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 2);
		
		BUYGiftCard *giftCard3 = _checkout.giftCards[1];
		XCTAssertEqualObjects([self.giftCardCode3 substringWithRange:NSMakeRange(self.giftCardCode3.length - 4, 4)], giftCard3.lastCharacters);
		
		// Ensure the amount after removing the second gift card is less than the new paymentDue amount
		XCTAssertLessThan([originalPaymentDue integerValue], [_checkout.paymentDue integerValue]);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingFirstGiftCard
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingFirstGiftCard_2" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 1);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingFirstGiftCard_3" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardTwoToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingFirstGiftCard_4" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardThreeToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 3);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingFirstGiftCard_5" useMocks:[self shouldUseMocks]];

	[self removeSecondGiftCard];
	
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingFirstGiftCard_6" useMocks:[self shouldUseMocks]];
	
	[self removeFirstGiftCard];
}

- (void)removeFirstGiftCard
{
	BUYGiftCard *giftCard1 = _checkout.giftCards[0];
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client removeGiftCard:giftCard1 fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 1);
		
		BUYGiftCard *giftCard3 = _checkout.giftCards[0];
		XCTAssertEqualObjects([self.giftCardCode3 substringWithRange:NSMakeRange(self.giftCardCode3.length - 4, 4)], giftCard3.lastCharacters);
		
		// Ensure the amount after removing the first gift card is less than the new paymentDue amount
		XCTAssertLessThan([originalPaymentDue integerValue], [_checkout.paymentDue integerValue]);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testRemovingAllGiftCards
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingAllGiftCards_2" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 1);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingAllGiftCards_3" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardTwoToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingAllGiftCards_4" useMocks:[self shouldUseMocks]];
	
	[self applyGiftCardThreeToCheckout];
	
	XCTAssertEqual([_checkout.giftCards count], 3);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingAllGiftCards_5" useMocks:[self shouldUseMocks]];
	
	[self removeSecondGiftCard];
	
	XCTAssertEqual([_checkout.giftCards count], 2);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingAllGiftCards_6" useMocks:[self shouldUseMocks]];
	
	[self removeFirstGiftCard];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testRemovingAllGiftCards_7" useMocks:[self shouldUseMocks]];
	
	[self removeAllGiftCards];
}

- (void)removeAllGiftCards
{
	BUYGiftCard *giftCard3 = _checkout.giftCards[0];
	NSDecimalNumber *originalPaymentDue = [_checkout.paymentDue copy];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client removeGiftCard:giftCard3 fromCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		//NOTE: Is this test failing? Make sure that you have configured giftCardCode above
		XCTAssertNil(error);
		_checkout = checkout;
		XCTAssertEqual([_checkout.giftCards count], 0);
		
		// Ensure the amount after removing all gift cards is less than the new paymentDue amount
		XCTAssertLessThan([originalPaymentDue integerValue], [_checkout.paymentDue integerValue]);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCheckoutWithInvalidShop
{
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testInvalidIntegrationBadShopUrl_0" useMocks:[self shouldUseMocks]];
	
	self.client = [[BUYClient alloc] initWithShopDomain:@"asdfdsasdfdsasdfdsadsfowinfaoinfw.myshopify.com" apiKey:self.apiKey appId:@"88234"];
	[self.client createCheckout:_checkout completion:^(BUYCheckout *checkout, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqualObjects(error.domain, @"BUYShopifyErrorDomain");
		XCTAssertEqual(error.code, 404);
		[expectation fulfill];
		
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testFetchingShippingRatesWithoutShippingAddressShouldReturnPreconditionFailed
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testFetchingShippingRatesWithoutShippingAddress_1" useMocks:[self shouldUseMocks]];
	
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(returnedCheckout);
		
		_checkout = returnedCheckout;
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testFetchingShippingRatesWithoutShippingAddress_2" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation2 = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client getShippingRatesForCheckoutWithToken:_checkout.token completion:^(NSArray *returnedShippingRates, BUYStatus status, NSError *error) {
		XCTAssertEqual(BUYStatusPreconditionFailed, status);
		[expectation2 fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testFetchingShippingRatesForInvalidCheckoutShouldReturnNotFound
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testFetchingShippingRatesWithInvalidCheckout_1" useMocks:[self shouldUseMocks]];
	
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:[BUYCart new]];
	checkout.token = @"bananaaaa";
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getShippingRatesForCheckoutWithToken:checkout.token completion:^(NSArray *returnedShippingRates, BUYStatus status, NSError *error) {
		XCTAssertEqual(BUYStatusNotFound, status);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCheckoutFlowUsingCreditCard
{
	[self createCart];
	[self createCheckout];
	[self fetchShippingRates];
	[self updateCheckout];
	
	[self completeCheckoutWithToken:[self addCreditCardToCheckout]];
}

- (void)testCheckoutWithAPartialAddress
{
	[self createCart];
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];
	_checkout.shippingAddress = [self partialShippingAddress];

	if ([_checkout.shippingAddress isPartialAddress]) {
		_checkout.partialAddressesValue = YES;
	}
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testCheckoutWithAPartialAddress" useMocks:[self shouldUseMocks]];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
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
	id<BUYPaymentToken> token = [self addCreditCardToCheckout];
	[self completeCheckoutWithToken:token];
}

- (void)testCheckoutCreationWithApplicableDiscount
{
	[self createCart];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testCreateCheckoutWithValidDiscount_1" useMocks:[self shouldUseMocks]];
	
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];
	_checkout.discount = [self applicableDiscount];
	
	// Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		// NOTE: Is this test failing? Make sure that you create the following discounts on your test shop:
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

- (void)testCheckoutCreationWithInapplicableDiscount
{
	[self createCart];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testCreateCheckoutWithExpiredDiscount_1" useMocks:[self shouldUseMocks]];
	
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];
	_checkout.discount = [self inapplicableDiscount];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		XCTAssert(error);
		XCTAssertEqual(422, error.code); //This is a validation error
		XCTAssertNil(returnedCheckout);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCheckoutCreationWithNonExistentDiscount
{
	[self createCart];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testCreateCheckoutWithNonExistentDiscount_1" useMocks:[self shouldUseMocks]];
	
	_checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager cart:_cart];
	_checkout.discount = [self nonExistentDiscount];
	
	//Create the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client createCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
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

- (void)testCheckoutUpdateWithApplicableDiscount
{
	[self createCart];
	[self createCheckout];
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testCreateCheckoutWithValidDiscount_1" useMocks:[self shouldUseMocks]];
	
	_checkout.discount = [self applicableDiscount];
	
	// Update the checkout
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client updateCheckout:_checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
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

- (void)testGetCheckoutWithInvalidToken
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetCheckoutWithInvalidToken_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getCheckoutWithToken:@"zzzzzzzzzzz" completion:^(BUYCheckout *checkout, NSError *error) {
		
		XCTAssertEqual(404, error.code);
		[expectation fulfill];

	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

#pragma mark - Test Data

- (BUYAddress *)billingAddress
{
	BUYAddress *address = [_modelManager insertAddressWithJSONDictionary:nil];
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
	BUYAddress *address = [_modelManager insertAddressWithJSONDictionary:nil];
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

- (BUYAddress *)partialShippingAddress
{
	BUYAddress *address = [_modelManager insertAddressWithJSONDictionary:nil];
	address.address1 = nil;
	address.city = @"Ottawa";
	address.firstName = nil;
	address.lastName = nil;
	address.countryCode = @"CA";
	address.provinceCode = @"ON";
	address.zip = @"K1N5T5";
	address.phone = nil;
	return address;
}

- (BUYDiscount *)applicableDiscount
{
	return [_modelManager discountWithCode:self.discountCodeValid];
}

- (BUYDiscount *)inapplicableDiscount
{
	return [_modelManager discountWithCode:self.discountCodeExpired];
}

- (BUYDiscount *)nonExistentDiscount
{
	return [_modelManager discountWithCode:@"asdfasdfasdfasdf"];
}

- (void)testExpiringCheckout
{
	[self createCart];
	[self createCheckout];
	XCTAssertGreaterThanOrEqual([_checkout.lineItems count], 1);
	XCTAssertNotNil(_checkout.reservationTime);
	XCTAssertTrue([_checkout.reservationTime isKindOfClass:[NSNumber class]]);
	XCTAssertEqual(300, _checkout.reservationTime.intValue);
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testExpiringCheckout_2" useMocks:[self shouldUseMocks]];
	
	// Expire the checkout
	XCTestExpectation *expectation2 = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client removeProductReservationsFromCheckoutWithToken:_checkout.token completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		
		XCTAssertNil(error);
		
		_checkout = returnedCheckout;
		XCTAssertGreaterThanOrEqual([_checkout.lineItems count], 1);
		XCTAssertEqual(0, _checkout.reservationTime.intValue);
		[expectation2 fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCallbackQueue
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetShop_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	XCTestExpectation *expectation2 = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client getShop:^(BUYShop *shop, NSError *error) {
		
		BOOL isMainThread = [NSThread isMainThread];
		XCTAssertTrue(isMainThread);
		[expectation fulfill];
	}];
	
	NSString *shopDomain = [self shouldUseMocks] ? BUYShopDomain_Placeholder : self.shopDomain;
	NSString *apiKey = [self shouldUseMocks] ? BUYAPIKey_Placeholder : self.apiKey;
	NSString *appId = [self shouldUseMocks] ? BUYAppId_Placeholder : self.appId;
	BUYClient *testClient = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:apiKey appId:appId];
	testClient.callbackQueue = [NSOperationQueue new];
	
	[testClient getShop:^(BUYShop *shop, NSError *error) {
		BOOL isMainThread = [NSThread isMainThread];
		XCTAssertFalse(isMainThread);
		[expectation2 fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

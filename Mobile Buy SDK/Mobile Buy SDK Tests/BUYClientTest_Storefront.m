//
//  BUYClientTest_Storefront.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-25.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;
#import <Buy/Buy.h>
#import "BUYTestConstants.h"
#import "BUYCollection.h"
#import "NSDateFormatter+BUYAdditions.h"

@interface BUYClientTest_Storefront : XCTestCase
@property (nonatomic, strong) BUYCollection *collection;
@end

@implementation BUYClientTest_Storefront {
	BUYClient *_client;
	
	NSString *shopDomain;
	NSString *apiKey;
	NSString *channelId;
	NSString *giftCardCode;
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
	expiredGiftCardCode = environment[kBUYTestExpiredGiftCardCode];
	expiredGiftCardId = environment[kBUYTestExpiredGiftCardID];
	
	_client = [[BUYClient alloc] initWithShopDomain:shopDomain apiKey:apiKey channelId:channelId];
}

- (void)testDefaultPageSize
{
	XCTAssertEqual(_client.pageSize, 25);
}

- (void)testSetPageSizeIsClamped
{
	[_client setPageSize:0];
	XCTAssertEqual(_client.pageSize, 1);
	
	[_client setPageSize:54];
	XCTAssertEqual(_client.pageSize, 54);
	
	[_client setPageSize:260];
	XCTAssertEqual(_client.pageSize, 250);
}

- (void)testGetProductList
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:0 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertTrue([products count] > 0);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testGetShop
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getShop:^(BUYShop *shop, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(shop);
		XCTAssertEqualObjects(shop.name, @"davidmuzi");
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testGetProductById
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductById:@"378783139" completion:^(BUYProduct *product, NSError *error) {

		XCTAssertNil(error);
		XCTAssertNotNil(product);
		XCTAssertEqualObjects(@"App crasher", [product title]);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductDates
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductById:@"378783139" completion:^(BUYProduct *product, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(product);
		NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
		XCTAssertEqualObjects([dateFormatter stringFromDate:product.createdAtDate], @"2015-07-28T09:58:24-0400");
		XCTAssertEqualObjects([dateFormatter stringFromDate:product.publishedAtDate], @"2015-07-28T09:58:24-0400");
		XCTAssertNotNil(product.updatedAtDate);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testGetMultipleProductByIds
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

	[_client getProductsByIds:@[@"378783139", @"376722235", @"458943719"] completion:^(NSArray *products, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertEqual([products count], 3);
		
		// TODO: Change to test against 
		NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
		NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
		products = [products sortedArrayUsingDescriptors:sortDescriptors];
		XCTAssertEqualObjects(@"App crasher", [products[0] title]);
		XCTAssertEqualObjects(@"Pixel", [products[1] title]);
		XCTAssertEqualObjects(@"Solar powered umbrella", [products[2] title]);
		[expectation fulfill];
	}];

	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductRequestError
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductById:@"asdfdsasdfdsasdfdsasdfjkllkj" completion:^(BUYProduct *product, NSError *error) {

		XCTAssertNil(product);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCollections
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getCollections:^(NSArray *collections, NSError *error) {
		
		XCTAssertNotNil(collections);
		
		self.collection = collections.firstObject;
		
		XCTAssertEqualObjects(@"Super Sale", [self.collection title]);
		XCTAssertEqualObjects(@"super-sale", [self.collection handle]);
		XCTAssertEqualObjects(@42362050, [self.collection collectionId]);

		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollection
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

	[_client getProductsPage:1 inCollection:self.collection.collectionId completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
	
		XCTAssertEqual(products.count, 5);
		XCTAssertEqualObjects(@"Wood", [products.firstObject title]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

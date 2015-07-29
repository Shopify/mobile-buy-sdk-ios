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
#import "BUYCollection+Additions.h"

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
	}];}

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
		XCTAssertEqualObjects(@"Pixel", [products.firstObject title]);
		XCTAssertEqualObjects(@"Solar powered umbrella", [products.lastObject title]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductCollectionSortParamterConversions
{
	XCTAssertEqualObjects(@"collection-sort", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortCollectionDefault]);
	XCTAssertEqualObjects(@"best-selling", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortBestSelling]);
	XCTAssertEqualObjects(@"created-ascending", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortCreatedAscending]);
	XCTAssertEqualObjects(@"created-descending", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortCreatedDescending]);
	XCTAssertEqualObjects(@"price-ascending", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortPriceAscending]);
	XCTAssertEqualObjects(@"price-descending", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortPriceDescending]);
	XCTAssertEqualObjects(@"title-ascending", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortTitleAscending]);
	XCTAssertEqualObjects(@"title-descending", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortTitleDescending]);
}

- (void)testProductsInCollectionWithSortOrderCollectionDefault
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortCollectionDefault completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		XCTAssertEqualObjects(@"Pixel", [products.firstObject title]);
		XCTAssertEqualObjects(@"Solar powered umbrella", [products.lastObject title]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollectionWithSortOrderBestSelling
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortBestSelling completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		XCTAssertEqualObjects(@"Pixel", [products.firstObject title]);
		XCTAssertEqualObjects(@"Solar powered umbrella", [products.lastObject title]);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollectionWithSortOrderCreatedAscending
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortCreatedAscending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		NSDate *productCreation1 = [products[0] createdAtDate];
		NSDate *productCreation2 = [products[1] createdAtDate];
		NSDate *productCreation3 = [products[2] createdAtDate];
		NSDate *productCreation4 = [products[3] createdAtDate];
		NSDate *productCreation4 = [products[4] createdAtDate];
		NSComparisonResult result = [productCreation1 compare:productCreation2];
		XCTAssertEqual(result, NSOrderedAscending);
		NSComparisonResult result = [productCreation2 compare:productCreation3];
		XCTAssertEqual(result, NSOrderedAscending);
		NSComparisonResult result = [productCreation3 compare:productCreation4];
		XCTAssertEqual(result, NSOrderedAscending);
		NSComparisonResult result = [productCreation4 compare:productCreation5];
		XCTAssertEqual(result, NSOrderedAscending);
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollectionWithSortOrderCreatedDescending
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortCreatedDescending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		NSDate *productCreation1 = [products[0] createdAtDate];
		NSDate *productCreation2 = [products[1] createdAtDate];
		NSDate *productCreation3 = [products[2] createdAtDate];
		NSDate *productCreation4 = [products[3] createdAtDate];
		NSDate *productCreation4 = [products[4] createdAtDate];
		NSComparisonResult result = [productCreation1 compare:productCreation2];
		XCTAssertEqual(result, NSOrderedDescending);
		NSComparisonResult result = [productCreation2 compare:productCreation3];
		XCTAssertEqual(result, NSOrderedDescending);
		NSComparisonResult result = [productCreation3 compare:productCreation4];
		XCTAssertEqual(result, NSOrderedDescending);
		NSComparisonResult result = [productCreation4 compare:productCreation5];
		XCTAssertEqual(result, NSOrderedDescending);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollectionWithSortOrderPriceAscending
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortPriceAscending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		NSDecimalNumber *productPrice1 = [products[0] price];
		NSDecimalNumber *productPrice2 = [products[1] price];
		NSDecimalNumber *productPrice3 = [products[2] price];
		NSDecimalNumber *productPrice4 = [products[3] price];
		NSDecimalNumber *productPrice5 = [products[4] price];
		XCTAssertLessThan(productPrice1, productPrice2);
		XCTAssertLessThan(productPrice2, productPrice3);
		XCTAssertLessThan(productPrice3, productPrice4);
		XCTAssertLessThan(productPrice4, productPrice5);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollectionWithSortOrderPriceDescending
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortPriceDescending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		NSDecimalNumber *productPrice1 = [products[0] price];
		NSDecimalNumber *productPrice2 = [products[1] price];
		NSDecimalNumber *productPrice3 = [products[2] price];
		NSDecimalNumber *productPrice4 = [products[3] price];
		NSDecimalNumber *productPrice5 = [products[4] price];
		XCTAssertGreaterThan(productPrice1, productPrice2);
		XCTAssertGreaterThan(productPrice2, productPrice3);
		XCTAssertGreaterThan(productPrice3, productPrice4);
		XCTAssertGreaterThan(productPrice4, productPrice5);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollectionWithSortOrderTitleAscending
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortTitleAscending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		NSString *productTitle1 = [products[0] title];
		NSString *productTitle2 = [products[1] title];
		NSString *productTitle3 = [products[2] title];
		NSString *productTitle4 = [products[3] title];
		NSString *productTitle5 = [products[4] title];
		NSComparisonResult result = [productTitle1 compare:productTitle2];
		XCTAssertEqual(result, NSOrderedDescending);
		NSComparisonResult result = [productTitle2 compare:productTitle3];
		XCTAssertEqual(result, NSOrderedDescending);
		NSComparisonResult result = [productTitle3 compare:productTitle4];
		XCTAssertEqual(result, NSOrderedDescending);
		NSComparisonResult result = [productTitle4 compare:productTitle5];
		XCTAssertEqual(result, NSOrderedDescending);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsInCollectionWithSortOrderTitleDescending
{
	if (self.collection == nil) {
		[self testCollections];
	}
	
	XCTAssertNotNil(self.collection);
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortTitleDescending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(products.count, 5);
		NSString *productTitle1 = [products[0] title];
		NSString *productTitle2 = [products[1] title];
		NSString *productTitle3 = [products[2] title];
		NSString *productTitle4 = [products[3] title];
		NSString *productTitle5 = [products[4] title];
		NSComparisonResult result = [productTitle1 compare:productTitle2];
		XCTAssertEqual(result, NSOrderedAscending);
		NSComparisonResult result = [productTitle2 compare:productTitle3];
		XCTAssertEqual(result, NSOrderedAscending);
		NSComparisonResult result = [productTitle3 compare:productTitle4];
		XCTAssertEqual(result, NSOrderedAscending);
		NSComparisonResult result = [productTitle4 compare:productTitle5];
		XCTAssertEqual(result, NSOrderedAscending);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

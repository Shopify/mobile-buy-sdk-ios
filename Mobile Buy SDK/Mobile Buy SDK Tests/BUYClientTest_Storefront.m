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
		
		NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
		// Integration test might run on a different timezone, so we have to force the timezone to GMT
		dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
		XCTAssertEqual([product.createdAtDate compare:[dateFormatter dateFromString:@"2015-07-28T09:58:24-0400"]], NSOrderedSame);
		XCTAssertEqual([product.publishedAtDate compare:product.createdAtDate], NSOrderedSame);
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
		XCTAssertEqual(BUYShopifyError_InvalidProductID, error.code);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsRequestError
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[_client getProductsByIds:@[@"asdfdsasdfds", @"asdfdsasdfjkllkj"] completion:^(NSArray *products, NSError *error) {
		
		XCTAssertEqual(BUYShopifyError_InvalidProductID, error.code);
		XCTAssertEqual(0, products.count);
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
		XCTAssertNil(error);
		
		XCTAssertNotNil([collections.firstObject title]);
		XCTAssertNotNil([collections.firstObject handle]);
		XCTAssertNotNil([collections.firstObject collectionId]);

		self.collection = collections.firstObject;
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
	
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThanOrEqual(products.count, 1);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductCollectionSortParamterConversions
{
	XCTAssertEqualObjects(@"collection-default", [BUYCollection sortOrderParameterForCollectionSort:BUYCollectionSortCollectionDefault]);
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

		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThanOrEqual(products.count, 1);
		
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
		
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThanOrEqual(products.count, 1);
		
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
		
		// TODO: Fix this test
		// https://github.com/Shopify/shopify/issues/50547
		/*
		BUYProduct *product = (BUYProduct*)products[0];
		for (int i = 1; i < products.count; i++) {
			BUYProduct *productToCompare = (BUYProduct*)products[i];
			XCTAssertEqual([product.createdAtDate compare:productToCompare.createdAtDate], NSOrderedAscending);
			product = productToCompare;
		}
		 */
		
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
		
		// TODO: Fix this test
		// https://github.com/Shopify/shopify/issues/50547
		/*
		BUYProduct *product = (BUYProduct*)products[0];
		for (int i = 1; i < products.count; i++) {
			BUYProduct *productToCompare = (BUYProduct*)products[i];
			XCTAssertEqual([product.createdAtDate compare:productToCompare.createdAtDate], NSOrderedDescending);
			product = productToCompare;
		}
		 */
		
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
		
		BUYProduct *product = (BUYProduct*)products[0];
		BUYProductVariant *variant = (BUYProductVariant*)product.variants[0];
		NSDecimalNumber *productPrice = variant.price;
		for (int i = 1; i < products.count; i++) {
			product = (BUYProduct*)products[i];
			variant = (BUYProductVariant*)product.variants[0];
			NSDecimalNumber *productPriceToCompare = [variant.price copy];
			XCTAssertEqual([productPrice compare:productPriceToCompare], NSOrderedAscending);
			productPrice = [productPriceToCompare copy];
		}
		
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
		
		BUYProduct *product = (BUYProduct*)products[0];
		BUYProductVariant *variant = (BUYProductVariant*)product.variants[0];
		NSDecimalNumber *productPrice = variant.price;
		for (int i = 1; i < products.count; i++) {
			product = (BUYProduct*)products[i];
			variant = (BUYProductVariant*)product.variants[0];
			NSDecimalNumber *productPriceToCompare = [variant.price copy];
			XCTAssertEqual([productPrice compare:productPriceToCompare], NSOrderedDescending);
			productPrice = [productPriceToCompare copy];
		}
		
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
		XCTAssertEqual([productTitle1 compare:productTitle2], NSOrderedAscending);
		XCTAssertEqual([productTitle2 compare:productTitle3], NSOrderedAscending);
		XCTAssertEqual([productTitle3 compare:productTitle4], NSOrderedAscending);
		XCTAssertEqual([productTitle4 compare:productTitle5], NSOrderedAscending);
		
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
		XCTAssertEqual([productTitle1 compare:productTitle2], NSOrderedDescending);
		XCTAssertEqual([productTitle2 compare:productTitle3], NSOrderedDescending);
		XCTAssertEqual([productTitle3 compare:productTitle4], NSOrderedDescending);
		XCTAssertEqual([productTitle4 compare:productTitle5], NSOrderedDescending);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

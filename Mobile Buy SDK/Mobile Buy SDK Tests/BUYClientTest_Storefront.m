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
#import "BUYClientTestBase.h"

@interface BUYClientTest_Storefront : BUYClientTestBase
@property (nonatomic, strong) BUYCollection *collection;
@end

@implementation BUYClientTest_Storefront

- (void)testDefaultPageSize
{
	XCTAssertEqual(self.client.pageSize, 25);
}

- (void)testSetPageSizeIsClamped
{
	[self.client setPageSize:0];
	XCTAssertEqual(self.client.pageSize, 1);
	
	[self.client setPageSize:54];
	XCTAssertEqual(self.client.pageSize, 54);
	
	[self.client setPageSize:260];
	XCTAssertEqual(self.client.pageSize, 250);
}

- (void)testGetProductList
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getProductsPage:0 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
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
	[self.client getShop:^(BUYShop *shop, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(shop);
		XCTAssertGreaterThan([shop.name length], 1);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testGetProductById
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getProductById:self.productIds[0] completion:^(BUYProduct *product, NSError *error) {

		XCTAssertNil(error);
		XCTAssertNotNil(product);
		
		// Test dates
		NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
		// Integration test might run on a different timezone, so we have to force the timezone to GMT
		dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
		XCTAssertEqual([product.createdAtDate compare:[NSDate date]], NSOrderedAscending);
		XCTAssertEqual([product.publishedAtDate compare:[NSDate date]], NSOrderedAscending);
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

	[self.client getProductsByIds:self.productIds completion:^(NSArray *products, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThan([products count], 1);
		
		// TODO: Change to test against 
		NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
		NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
		products = [products sortedArrayUsingDescriptors:sortDescriptors];
		int index = 0;
		do {
			BUYProduct *product = products[index];
			BUYProduct *productToCompare = products[index + 1];
			XCTAssertEqual([product.title compare:productToCompare.title], NSOrderedAscending);
			index++;
		} while (index < [products count] - 1);

		[expectation fulfill];
	}];

	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductRequestError
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getProductById:@"asdfdsasdfdsasdfdsasdfjkllkj" completion:^(BUYProduct *product, NSError *error) {

		XCTAssertNil(product);
		XCTAssertEqual(BUYShopifyError_InvalidProductID, error.code);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCollections
{
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getCollections:^(NSArray *collections, NSError *error) {
		
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

	[self.client getProductsPage:1 inCollection:self.collection.collectionId completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
	
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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortCollectionDefault completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {

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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortBestSelling completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortCreatedAscending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertGreaterThan(products.count, 1);
		
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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortCreatedDescending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertGreaterThan(products.count, 1);
		
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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortPriceAscending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertGreaterThan(products.count, 1);
		
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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortPriceDescending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertGreaterThan(products.count, 1);
		
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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortTitleAscending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThan([products count], 1);
		
		int index = 0;
		do {
			BUYProduct *product = products[index];
			BUYProduct *productToCompare = products[index + 1];
			XCTAssertEqual([product.title compare:productToCompare.title], NSOrderedAscending);
			index++;
		} while (index < [products count] - 1);
		
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
	[self.client getProductsPage:1 inCollection:self.collection.collectionId sortOrder:BUYCollectionSortTitleDescending completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThan([products count], 1);
		
		int index = 0;
		do {
			BUYProduct *product = products[index];
			BUYProduct *productToCompare = products[index + 1];
			XCTAssertEqual([product.title compare:productToCompare.title], NSOrderedDescending);
			index++;
		} while (index < [products count] - 1);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

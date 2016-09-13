//
//  BUYClientTest_Storefront.m
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

#import "BUYClientTestBase.h"
#import "BUYTestConstants.h"

#import <OHHTTPStubs/OHHTTPStubs.h>
#import "OHHTTPStubsResponse+Helpers.h"

@interface BUYClientTest_Storefront : BUYClientTestBase
@property (nonatomic, strong) BUYCollection *collection;
@end

@implementation BUYClientTest_Storefront

- (void)tearDown {
	[super tearDown];
	
	[OHHTTPStubs removeAllStubs];
}

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
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetProducts_0" useMocks:[self shouldUseMocks]];
	
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
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetShop_0" useMocks:[self shouldUseMocks]];
	
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

- (void)testGetProductByHandle
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetProduct_0" useMocks:[self shouldUseMocks]];
	
	NSString *handle = @"actinian-fur-hat";
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getProductByHandle:handle completion:^(BUYProduct *product, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(product);
		XCTAssertEqualObjects(product.handle, handle);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {}];
}

- (void)testGetProductById
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetProduct_0" useMocks:[self shouldUseMocks]];
	
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
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetProducts_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

	[self.client getProductsByIds:self.productIds completion:^(NSArray *products, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThan([products count], 1);
		
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
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetNonexistentProduct_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getProductById:@123456 completion:^(BUYProduct *product, NSError *error) {

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
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetCollection_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getCollectionsPage:1 completion:^(NSArray<BUYCollection *> *collections, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error) {
		
		XCTAssertNotNil(collections);
		XCTAssertNil(error);
		
		XCTAssertNotNil([collections.firstObject title]);
		XCTAssertNotNil([collections.firstObject handle]);
		XCTAssertNotNil([collections.firstObject identifier]);

		self.collection = collections.firstObject;
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCollectionsFromFirstPage
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetCollection_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getCollectionsPage:1 completion:^(NSArray<BUYCollection *> *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {

		XCTAssertEqual(1, page);
		
		XCTAssertNotNil((collections));
		XCTAssertNil(error);
		
		XCTAssertNotNil([collections.firstObject title]);
		XCTAssertNotNil([collections.firstObject handle]);
		XCTAssertNotNil([collections.firstObject identifier]);

		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCollectionsFromEmptyPage
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetOutOfIndexCollectionPage_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getCollectionsPage:999 completion:^(NSArray<BUYCollection *> *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertEqual(999, page);

		XCTAssertNotNil((collections));
		XCTAssert(collections.count == 0);
		XCTAssertNil(error);
		
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCollectionHandle
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetCollection_0" useMocks:[self shouldUseMocks]];
	
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.client getCollectionByHandle:@"frontpage" completion:^(BUYCollection * _Nullable collection, NSError * _Nullable error) {
        
        XCTAssertNotNil(collection);
        XCTAssertEqualObjects(@"Frontpage", collection.title);
		XCTAssertEqualObjects(@109931075, collection.identifier);
        XCTAssertNil(error);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

- (void)testCollectionsFromIDs
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetCollectionsByIds" useMocks:[self shouldUseMocks]];

	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[self.client getCollectionsByIds:self.collectionIds page:1 completion:^(NSArray<BUYCollection *> * _Nullable collections, NSError * _Nullable error) {
		
		XCTAssertTrue(collections.count == self.collectionIds.count);
		XCTAssertNil(error);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCollectionsFromIDsSmallPageSize
{
	// TODO: re-enable when mock data has been configured
	if (self.shouldUseMocks) {
		return;
	}
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetCollectionsByIdsSmallPageSize" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	self.client.pageSize = 1;
	[self.client getCollectionsByIds:self.collectionIds page:1 completion:^(NSArray<BUYCollection *> * _Nullable collections, NSError * _Nullable error) {
		
		XCTAssertEqual(collections.count, 1L);
		XCTAssertNil(error);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testCollectionsFromIDsInvalidPageNumber
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetCollectionsByIdsInvalidPageNumber" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	self.client.pageSize = 1;
	NSInteger lastPage = (NSInteger)ceil(self.collectionIds.count / self.client.pageSize);
	[self.client getCollectionsByIds:self.collectionIds page:lastPage + 1 completion:^(NSArray<BUYCollection *> * _Nullable collections, NSError * _Nullable error) {
		
		XCTAssertTrue(collections.count == 0);
		XCTAssertNil(error);
		
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
	
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetProductsInCollection_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];

	[self.client getProductsPage:1 inCollection:self.collection.identifier completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
	
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertGreaterThanOrEqual(products.count, 1);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testProductsByTags
{
//	[OHHTTPStubs stubUsingResponseWithKey:@"testGetValidTag_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client getProductsByTags:self.tags completion:^(NSArray *products, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		
		if (products.count > 0) {
			BUYProduct *product = products[0];
			if (product.tags) {
				XCTAssertTrue([product.tags isKindOfClass:[NSSet class]]);
				for (NSString *tag in [product.tags allObjects]) {
					XCTAssert([tag isKindOfClass:[NSString class]]);
				}
			}
		}
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testValidTags
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetValidTag_0" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client getProductsPage:1 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		
		if (products.count > 0) {
			BUYProduct *product = products[0];
			if (product.tags) {
				XCTAssertTrue([product.tags isKindOfClass:[NSSet class]]);
				for (NSString *tag in [product.tags allObjects]) {
					XCTAssert([tag isKindOfClass:[NSString class]]);
				}
			}
		}
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testGetAllTags
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetAllTags" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client getProductTagsPage:1 completion:^(NSArray *tags, NSUInteger page, BOOL end, NSError *error){
		
		XCTAssertNil(error);
		XCTAssertNotNil(tags);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

- (void)testGetTagsByCollection
{
	[OHHTTPStubs stubUsingResponseWithKey:@"testGetTagsByCollection" useMocks:[self shouldUseMocks]];
	
	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	
	[self.client getProductTagsInCollection:self.collectionIds[0] page:1 completion:^(NSArray *tags, NSUInteger page, BOOL end, NSError *error){
		
		XCTAssertNil(error);
		XCTAssertNotNil(tags);
		
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
		XCTAssertNil(error);
	}];
}

@end

//
//  MERDataProviderTests.m
//  Storefront
//
//  Created by Joshua Tessier on 2014-09-25.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "MERDataProvider.h"

//Model
#import "MERProduct.h"
#import "MERShop.h"

#define WAIT_FOR_TASK(task, semaphore) \
	if (task) { \
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); \
	} \
	else { \
		XCTFail(@"Task was nil, could not wait"); \
	} \

@interface MERDataProviderTests : XCTestCase
@end

@implementation MERDataProviderTests {
	MERDataProvider *_provider;
}

- (void)setUp
{
	[super setUp];
	_provider = [[MERDataProvider alloc] initWithShopDomain:@"ibukun.myshopify.com"];
}

- (void)testDefaultPageSize
{
	XCTAssertEqual(_provider.pageSize, 25);
}

- (void)testSetPageSizeIsClamped
{
	[_provider setPageSize:0];
	XCTAssertEqual(_provider.pageSize, 1);
	
	[_provider setPageSize:54];
	XCTAssertEqual(_provider.pageSize, 54);
	
	[_provider setPageSize:260];
	XCTAssertEqual(_provider.pageSize, 250);
}

- (void)testGetProductList
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_provider getProductsPage:0 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(products);
		XCTAssertTrue([products count] > 0);
		
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testGetCollectionList
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_provider getCollectionsPage:0 completion:^(NSArray *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(collections);
		XCTAssertTrue([collections count] > 0);
		
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testGetProductsInCollection
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_provider getCollectionsPage:0 completion:^(NSArray *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(collections);
		XCTAssertTrue([collections count] > 0);
		
		NSURLSessionDataTask *productsTask = [_provider getProductsInCollection:collections[0] page:0 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
			XCTAssertNil(error);
			XCTAssertNotNil(products);
			
			dispatch_semaphore_signal(semaphore);
		}];
		WAIT_FOR_TASK(productsTask, semaphore);
		
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testGetShop
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_provider getShop:^(MERShop *shop, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(shop);
		XCTAssertEqualObjects(shop.name, @"PackLeader");
		
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testGetProductByHandle
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_provider getProductByHandle:@"dogs" completion:^(MERProduct *product, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(product);
		XCTAssertEqualObjects(@"Dogs", [product title]);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

- (void)testHandleRequestError
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_provider getProductByHandle:@"asdfdsasdfdsasdfdsasdfjkllkj" completion:^(MERProduct *product, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(404, [error code]);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

@end

//
//  BUYDataProviderTest_Storefront.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-25.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "BUYClient.h"

//Model
#import "BUYProduct.h"
#import "BUYShop.h"

#define WAIT_FOR_TASK(task, semaphore) \
if (task) { \
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); \
} \
else { \
XCTFail(@"Task was nil, could not wait"); \
} \

@interface BUYDataProviderTest_Storefront : XCTestCase
@end

@implementation BUYDataProviderTest_Storefront {
	BUYClient *_provider;
}

- (void)setUp
{
	[super setUp];
	_provider = [[BUYClient alloc] initWithShopDomain:@"ibukun.myshopify.com" apiKey:nil channelId:nil];
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

- (void)testGetShop
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	NSURLSessionDataTask *task = [_provider getShop:^(BUYShop *shop, NSError *error) {
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
	NSURLSessionDataTask *task = [_provider getProductByHandle:@"dogs" completion:^(BUYProduct *product, NSError *error) {
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
	NSURLSessionDataTask *task = [_provider getProductByHandle:@"asdfdsasdfdsasdfdsasdfjkllkj" completion:^(BUYProduct *product, NSError *error) {
		XCTAssertNotNil(error);
		XCTAssertEqual(404, [error code]);
		dispatch_semaphore_signal(semaphore);
	}];
	WAIT_FOR_TASK(task, semaphore);
}

@end

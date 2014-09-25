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


@end

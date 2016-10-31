//
//  BUYProductTests.m
//  Mobile Buy SDK
//
//  Created by Brent Gulanowski on 2016-10-31.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@import Buy;

@interface BUYProductTests : XCTestCase

@end

@implementation BUYProductTests

- (void)testMinimumPrices
{
	NSArray *variantsJSON = @[
							  @{
								  @"id" : @1,
								  @"price" : [NSDecimalNumber one],
								  @"compareAtPrice": [NSDecimalNumber numberWithInt:100],
								  },
							  @{
								  @"id" : @1,
								  @"price" : [NSDecimalNumber numberWithInt:25],
								  @"compareAtPrice": [NSDecimalNumber numberWithInt:44],
								  },
							  @{
								  @"id" : @1,
								  @"price" : [NSDecimalNumber numberWithInt:90],
								  @"compareAtPrice": [NSDecimalNumber numberWithInt:12],
								  },
							  ];
	NSDictionary *json = @{
						   @"id" : @1,
						   @"variants" : variantsJSON,
						   };
	BUYProduct *product = [[BUYModelManager modelManager] insertProductWithJSONDictionary:json];
	
	XCTAssertEqualObjects(product.minimumPrice, [NSDecimalNumber one]);
	XCTAssertEqualObjects(product.minimumCompareAtPrice, [NSDecimalNumber numberWithInt:12]);
}

@end

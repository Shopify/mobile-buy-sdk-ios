//
//  BUYOrderTests.m
//  Mobile Buy SDK
//
//  Created by Gabriel O'Flaherty-Chan on 2016-02-17.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BUYOrder.h"

@interface BUYOrderTests : XCTestCase
@property (nonatomic, readonly) NSArray<BUYOrder *> *orders;
@property (nonatomic, readonly) NSDictionary *ordersJSON;
@end

@implementation BUYOrderTests

- (NSArray<BUYOrder *> *)orders
{
	return [[BUYModelManager modelManager] buy_objectsWithEntityName:[BUYOrder entityName] JSONArray:self.JSON[@"orders"]];
}

- (NSDictionary *)JSON
{
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"orders" ofType:@"json"];
	NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
	return dictionary;
}

- (void)testLineItems
{
	NSArray *ordersJSON = self.JSON[@"orders"];
	XCTAssertNotNil(ordersJSON);
	
	[ordersJSON enumerateObjectsUsingBlock:^(NSDictionary *orderJSON, NSUInteger idx, BOOL * _Nonnull stop) {
		NSArray *unfulfilledLineItems = orderJSON[@"unfulfilled_line_items"];
		NSArray *fulfilledLineItems = orderJSON[@"fulfilled_line_items"];
		NSInteger lineItemCount = unfulfilledLineItems.count + fulfilledLineItems.count;
		
		BUYOrder *order = self.orders[idx];
		XCTAssertEqual(order.lineItems.count, lineItemCount);
	}];
}

@end

//
//  BUYOrderTests.m
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

@import XCTest;
@import Buy;

@interface BUYOrderTests : XCTestCase
@property (nonatomic, readonly) NSArray<BUYOrder *> *orders;
@property (nonatomic, readonly) NSDictionary *ordersJSON;
@end

@implementation BUYOrderTests

- (NSArray<BUYOrder *> *)orders
{
	return (id)[[BUYModelManager modelManager] buy_objectsWithEntityName:[BUYOrder entityName] JSONArray:self.JSON[@"orders"]];
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

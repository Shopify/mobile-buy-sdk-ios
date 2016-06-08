//
//  _BUYOrder.m
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

#import "BUYOrder.h"
#import "BUYLineItem.h"

@implementation BUYOrder

- (NSArray<BUYLineItem *> *)lineItemsArray
{
	return self.lineItems.array ?: @[];
}

- (NSArray *)formatIDsForLineItemsJSON:(NSArray<NSDictionary *> *)lineItems
{
	__block NSMutableArray<NSDictionary *> *mutableLineItems = [NSMutableArray array];
	[lineItems enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull lineItem, NSUInteger idx, BOOL * _Nonnull stop) {
		NSNumber *identifier = lineItem[@"id"];
		NSMutableDictionary *mutableLineItem = [lineItem mutableCopy];
		if ([identifier isKindOfClass:[NSNumber class]]) {
			mutableLineItem[@"id"] = identifier.stringValue;
		}
		[mutableLineItems addObject:mutableLineItem];
	}];
	return mutableLineItems;
}

- (void)setJSONDictionary:(NSDictionary *)JSONDictionary
{
	// TODO: Have API return string IDs for line items instead of numbers
	NSArray *fulfilledLineItemsJSON = [self formatIDsForLineItemsJSON:JSONDictionary[@"fulfilled_line_items"]];
	NSArray *unFulfilledLineItemsJSON = [self formatIDsForLineItemsJSON:JSONDictionary[@"unfulfilled_line_items"]];
	
	[super setJSONDictionary:JSONDictionary];
	
	// Required if core data is not being used
	if (!self.lineItems) {
		self.lineItems = [NSOrderedSet orderedSet];
	}
	
	NSArray *fulfilledLineItems = [self.modelManager buy_objectsWithEntityName:[BUYLineItem entityName] JSONArray:fulfilledLineItemsJSON];
	[fulfilledLineItems makeObjectsPerformSelector:@selector(setFulfilled:) withObject:@YES];
	NSArray *unfulfilledLineItems = [self.modelManager buy_objectsWithEntityName:[BUYLineItem entityName] JSONArray:unFulfilledLineItemsJSON];
	
	[self.lineItemsSet addObjectsFromArray:fulfilledLineItems];
	[self.lineItemsSet addObjectsFromArray:unfulfilledLineItems];
}

@end

@implementation BUYModelManager (BUYOrder)

- (BUYOrder *)orderWithJSONDictionary:(NSDictionary *)json
{
	return (id)[self buy_objectWithEntityName:[BUYOrder entityName] JSONDictionary:json];
}

- (NSArray<BUYOrder *> *)ordersWithJSONDictionary:(NSDictionary *)json
{
	NSArray *orders = [json objectForKey:@"orders"];
	return (id)[self buy_objectsWithEntityName:[BUYOrder entityName] JSONArray:orders];
}

@end

//
//  CHKCart.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKCart.h"

@implementation CHKCart

@end


/*
 //
 //  MERCart.m
 //  Merchant
 //
 //  Created by Joshua Tessier on 2014-09-10.
 //  Copyright (c) 2014 Shopify Inc. All rights reserved.
 //
 
 #import "MERCart.h"
 
 @implementation MERCart {
	NSMutableDictionary *_variantToLineItem;
	NSMutableArray *_lineItems;
 }
 
 - (instancetype)init
 {
	self = [super init];
	if (self) {
 _variantToLineItem = [[NSMutableDictionary alloc] init];
 _lineItems = [[NSMutableArray alloc] init];
	}
	return self;
 }
 
 - (NSArray *)lineItems
 {
	return [NSArray arrayWithArray:_lineItems];
 }
 
 - (void)createLineItem:(MERProductVariant *)variant
 {
	MERLineItem *lineItem = [[MERLineItem alloc] initWithVariant:variant];
	_variantToLineItem[variant.identifier] = lineItem;
	[_lineItems addObject:lineItem];
 }
 
 - (void)addVariant:(MERProductVariant *)variant
 {
	MERLineItem *lineItem = _variantToLineItem[variant.identifier];
	if (lineItem == nil) {
 [self createLineItem:variant];
	}
	else {
 lineItem.quantity = [lineItem.quantity decimalNumberByAdding:[NSDecimalNumber one]];
	}
 }
 
 - (void)clearCart
 {
	[_lineItems removeAllObjects];
	[_variantToLineItem removeAllObjects];
 }
 
 @end
 
 @implementation MERLineItem
 
 - (NSString *)description
 {
	return [NSString stringWithFormat:@"%@ - %@ - %@", self.title, self.itemPrice, self.quantity];
 }
 
 - (instancetype)initWithVariant:(MERProductVariant*)variant
 {
	self = [super init];
	if (self) {
 _itemPrice = variant.price;
 _title = variant.title;
 _variant = variant;
 _quantity = [NSDecimalNumber one];
	}
	return self;
 }
 
 @end


*/
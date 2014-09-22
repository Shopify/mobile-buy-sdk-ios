//
//  MERCheckout.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKCheckout.h"

//Models
#import "CHKLineItem.h"

@implementation CHKCheckout

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.email = dictionary[@"email"];
	self.token = dictionary[@"token"];
	self.requiresShipping = dictionary[@"requires_shipping"];
	self.taxesIncluded = dictionary[@"taxes_included"];
	self.currency = dictionary[@"currency"];
	self.subtotalPrice = dictionary[@"subtotal_price"];
	self.totalTax = dictionary[@"total_tax"];
	self.totalPrice = dictionary[@"total_price"];
	
	self.paymentSessionId = dictionary[@"payment_session_id"];
	NSString *paymentURLString = dictionary[@"payment_url"];
	self.paymentURL = paymentURLString ? [NSURL URLWithString:paymentURLString] : nil;
	self.reservationTime = dictionary[@"reservation_time"];
	self.reservationTimeLeft = dictionary[@"reservation_time_left"];
	
	_lineItems = [CHKLineItem convertJSONArray:dictionary[@"line_items"]];
	_taxLines = [CHKTaxLine convertJSONArray:dictionary[@"tax_lines"]];
	
	self.billingAddress = [CHKAddress convertObject:dictionary[@"billing_address"]];
	self.shippingAddress = [CHKAddress convertObject:dictionary[@"shipping_address"]];
	
	self.shippingRate = [CHKShippingRate convertObject:dictionary[@"shipping_address"]];
}

@end

@implementation CHKTaxLine

@end

@implementation CHKAddress

@end

@implementation CHKShippingRate

@end

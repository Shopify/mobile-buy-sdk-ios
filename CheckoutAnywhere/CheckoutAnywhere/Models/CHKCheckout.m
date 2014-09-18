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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super initWithDictionary:dictionary];
	if (self) {
		[self updateWithDictionary:dictionary];
	}
	return self;
}

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
	
	_lineItems = [MERObject convertJSONArray:dictionary[@"line_items"] toArrayOfClass:[CHKLineItem class]];
	_taxLines = [MERObject convertJSONArray:dictionary[@"tax_lines"] toArrayOfClass:[CHKTaxLine class]];
	
	self.billingAddress = [MERObject convertDictionary:dictionary[@"billing_address"] toObjectOfClass:[CHKAddress class]];
	self.shippingAddress = [MERObject convertDictionary:dictionary[@"shipping_address"] toObjectOfClass:[CHKAddress class]];
	
	self.shippingAddress = [MERObject convertDictionary:dictionary[@"shipping_address"] toObjectOfClass:[CHKShippingRate class]];
}

@end

@implementation CHKTaxLine

@end

@implementation CHKAddress

@end

@implementation CHKShippingRate

@end

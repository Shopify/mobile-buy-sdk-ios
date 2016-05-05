//
//  BUYOrder.m
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
#import "BUYAddress.h"
#import "BUYLineItem.h"
#import "BUYShippingRate.h"
#import "NSURL+BUYAdditions.h"
#import "NSDictionary+BUYAdditions.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSDecimalNumber+BUYAdditions.h"

@implementation BUYOrder

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	NSDateFormatter *formatter = [NSDateFormatter dateFormatterForPublications];
	
	_cancelled            = [[dictionary buy_objectForKey:@"cancelled"] boolValue];
	_fulfillmentAborted   = [[dictionary buy_objectForKey:@"fulfillment_aborted"] boolValue];
	
	_name                 = [dictionary buy_objectForKey:@"name"];
	_cancelReason         = [dictionary buy_objectForKey:@"cancel_reason"];
	_currency             = [dictionary buy_objectForKey:@"currency"];
	_financialStatus      = [dictionary buy_objectForKey:@"financial_status"];
	_fulfillmentStatus    = [dictionary buy_objectForKey:@"fulfillment_status"];
	_orderNumber          = [dictionary buy_objectForKey:@"order_number"];
	
	_statusURL            = [NSURL buy_urlWithString:dictionary[@"status_url"]];
	_customerURL          = [NSURL buy_urlWithString:dictionary[@"customer_url"]];
	_orderStatusURL       = [NSURL buy_urlWithString:dictionary[@"order_status_url"]];
	
	_cancelledAt          = [formatter dateFromString:[dictionary buy_objectForKey:@"cancelled_at"]];
	_processedAt          = [formatter dateFromString:[dictionary buy_objectForKey:@"processed_at"]];
	
	_billingAddress       = [BUYAddress convertObject:[dictionary buy_objectForKey:@"billing_address"]];
	_shippingAddress      = [BUYAddress convertObject:[dictionary buy_objectForKey:@"shipping_address"]];
	_shippingRates        = [BUYShippingRate convertJSONArray:[dictionary buy_objectForKey:@"shipping_methods"]];
	_fulfilledLineItems   = [BUYLineItem convertJSONArray:dictionary[@"fulfilled_line_items"]];
	_unfulfilledLineItems = [BUYLineItem convertJSONArray:dictionary[@"unfulfilled_line_items"]];
	
	_discountSavings      = [NSDecimalNumber buy_decimalNumberFromJSON:[dictionary buy_objectForKey:@"discount_savings"]];
	_subtotalPrice        = [NSDecimalNumber buy_decimalNumberFromJSON:[dictionary buy_objectForKey:@"subtotal_price"]];
	_totalPrice           = [NSDecimalNumber buy_decimalNumberFromJSON:[dictionary buy_objectForKey:@"total_price"]];
}

@end

//
//  BUYCustomer.m
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

#import "BUYCustomer.h"

@implementation BUYCustomer

- (NSString *)fullName
{
	if (self.firstName.length > 0 || self.lastName.length > 0) {
		return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
	}
	return @"";
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_taxExempt           = dictionary[@"tax_exempt"];
	_verifiedEmail       = dictionary[@"verified_email"];
	_acceptsMarketing    = dictionary[@"accepts_marketing"];
	_customerState       = dictionary[@"customer_state"];
	_email               = dictionary[@"email"];
	_firstName           = dictionary[@"first_name"];
	_lastName            = dictionary[@"last_name"];
	_lastOrderID         = dictionary[@"last_order_id"];
	_lastOrderName       = dictionary[@"last_order_name"];
	_multipassIdentifier = dictionary[@"multipass_identifier"];
	_note                = dictionary[@"note"];
	_tags                = dictionary[@"tags"];
	_ordersCount         = dictionary[@"orders_count"];
	_totalSpent          = dictionary[@"total_spent"];
	_createdAt           = dictionary[@"created_at"];
	_updatedAt           = dictionary[@"updated_at"];
}

@end

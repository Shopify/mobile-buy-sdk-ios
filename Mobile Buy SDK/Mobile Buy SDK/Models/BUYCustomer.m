//
//  BUYCustomer.m
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-04-28.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYCustomer.h"

@implementation BUYCustomer

- (void)updateWithDictionary:(NSDictionary *)dictionary {
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

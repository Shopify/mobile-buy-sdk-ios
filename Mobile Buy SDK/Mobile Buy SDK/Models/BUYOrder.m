//
//  BUYOrder.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-09-08.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYOrder.h"
#import "NSURL+BUYAdditions.h"

@interface BUYOrder ()

@property (nonatomic, copy) NSNumber *orderId;
@property (nonatomic, strong) NSURL *statusURL;
@property (nonatomic, strong) NSString *name;

@end

@implementation BUYOrder

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.orderId = [dictionary[@"id"] isKindOfClass:[NSNull class]] ? nil : dictionary[@"id"];
	NSString *statusURLString = dictionary[@"status_url"];
	self.statusURL = [NSURL buy_urlWithString:statusURLString];
	self.name = [dictionary[@"name"] isKindOfClass:[NSNull class]] ? nil : dictionary[@"name"];
}

@end

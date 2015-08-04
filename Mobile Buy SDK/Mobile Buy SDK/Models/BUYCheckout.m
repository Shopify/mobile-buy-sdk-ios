//
//  BUYCheckout.m
//  Buy SDK
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYAddress.h"
#import "BUYCart.h"
#import "BUYCheckout.h"
#import "BUYDiscount.h"
#import "BUYLineItem.h"
#import "BUYProductVariant.h"
#import "BUYShippingRate.h"
#import "BUYTaxLine.h"
#import "BUYMaskedCreditCard.h"

#import "NSDecimalNumber+BUYAdditions.h"
#import "NSString+Trim.h"
#import "BUYCheckout_Private.h"
#import "NSDateFormatter+BUYAdditions.h"

@implementation BUYCheckout

+ (void)initialize
{
	if (self == [BUYCheckout class]) {
		[self trackDirtyProperties];
	}
}

- (instancetype)initWithCart:(BUYCart *)cart
{
	self = [super initWithDictionary:@{}];
	if (self) {
		_lineItems = [cart.lineItems copy];
		[self markPropertyAsDirty:@"lineItems"];
	}
	return self;
}

- (instancetype)initWithCartToken:(NSString *)cartToken
{
	self = [super initWithDictionary:@{@"cart_token" : cartToken}];
	if (self) {
		[self markPropertyAsDirty:@"cartToken"];
	}
	return self;
}

- (void)setShippingRateId:(NSString *)shippingRateIdentifier
{
	[self willChangeValueForKey:@"shippingRateId"];
	_shippingRateId = shippingRateIdentifier;
	[self didChangeValueForKey:@"shippingRateId"];
}

- (void)setShippingRate:(BUYShippingRate *)shippingRate
{
	[self willChangeValueForKey:@"shippingRate"];
	_shippingRate = shippingRate;
	[self didChangeValueForKey:@"shippingRate"];
	
	[self setShippingRateId:shippingRate.shippingRateIdentifier];
}

+ (NSString *)jsonKeyForProperty:(NSString *)property
{
	NSString *key = nil;
	if ([property isEqual:@"identifier"]) {
		key = @"id";
	}
	else {
		static NSCharacterSet *kUppercaseCharacters = nil;
		static dispatch_once_t onceToken;
		dispatch_once(&onceToken, ^{
			kUppercaseCharacters = [NSCharacterSet uppercaseLetterCharacterSet];
		});
		
		if ([property containsString:@"URL"]) {
			property = [property stringByReplacingOccurrencesOfString:@"URL" withString:@"Url"];
		}
		
		NSMutableString *output = [NSMutableString string];
		for (NSInteger i = 0; i < [property length]; ++i) {
			unichar c = [property characterAtIndex:i];
			if ([kUppercaseCharacters characterIsMember:c]) {
				[output appendFormat:@"_%@", [[NSString stringWithCharacters:&c length:1] lowercaseString]];
			}
			else {
				[output appendFormat:@"%C", c];
			}
		}
		key = output;
	}
	return key;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.email = dictionary[@"email"];
	self.orderId = [dictionary[@"order_id"] isKindOfClass:[NSNull class]] ? nil : dictionary[@"order_id"];
	self.token = dictionary[@"token"];
	self.cartToken = dictionary[@"cart_token"];
	self.requiresShipping = [dictionary[@"requires_shipping"] boolValue];
	self.taxesIncluded = [dictionary[@"taxes_included"] boolValue];
	self.currency = dictionary[@"currency"];
	self.subtotalPrice = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"subtotal_price"]];
	self.totalTax = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"total_tax"]];
	self.totalPrice = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"total_price"]];
	self.paymentDue = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"payment_due"]];
	
	self.paymentSessionId = dictionary[@"payment_session_id"];
	NSString *paymentURLString = dictionary[@"payment_url"];
	self.paymentURL = paymentURLString ? [NSURL URLWithString:paymentURLString] : nil;
	self.reservationTime = dictionary[@"reservation_time"];
	self.reservationTimeLeft = dictionary[@"reservation_time_left"];
	
	_lineItems = [BUYLineItem convertJSONArray:dictionary[@"line_items"]];
	_taxLines = [BUYTaxLine convertJSONArray:dictionary[@"tax_lines"]];
	
	self.billingAddress = [BUYAddress convertObject:dictionary[@"billing_address"]];
	self.shippingAddress = [BUYAddress convertObject:dictionary[@"shipping_address"]];
	self.shippingRate = [BUYShippingRate convertObject:dictionary[@"shipping_rate"]];
	self.discount = [BUYDiscount convertObject:dictionary[@"discount"]];
	self.giftCards = [BUYGiftCard convertJSONArray:dictionary[@"gift_cards"]];
	
	NSString *orderStatusURL = dictionary[@"order_status_url"];
	self.orderStatusURL = orderStatusURL && [orderStatusURL isKindOfClass:[NSString class]] ? [NSURL URLWithString:orderStatusURL] : nil;
	
	self.webCheckoutURL = [NSURL URLWithString:dictionary[@"web_url"]];
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	self.createdAtDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	self.updatedAtDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
	self.creditCard = [BUYMaskedCreditCard convertObject:dictionary[@"credit_card"]];
	self.customerId = [dictionary[@"customer_id"] copy];
	
	self.privacyPolicyURL = [NSURL URLWithString:dictionary[@"privacy_policy_url"]];
	self.refundPolicyURL = [NSURL URLWithString:dictionary[@"refund_policy_url"]];
	self.termsOfServiceURL = [NSURL URLWithString:dictionary[@"terms_of_service_url"]];
	
	self.sourceName = dictionary[@"source_name"];
	self.sourceId = dictionary[@"source_identifier"];
	self.sourceURL = [dictionary[@"source_url"] isKindOfClass:[NSString class]]? [NSURL URLWithString:dictionary[@"source_url"]] : nil;
}

- (id)jsonValueForValue:(id)value
{
	id newValue = value;
	if ([value conformsToProtocol:@protocol(BUYSerializable)]) {
		newValue = [(id <BUYSerializable>)value jsonDictionaryForCheckout];
	}
	else if ([value isKindOfClass:[NSArray class]]) {
		NSMutableArray *newArray = [[NSMutableArray alloc] init];
		for (id arrayValue in value) {
			[newArray addObject:[self jsonValueForValue:arrayValue]];
		}
		newValue = newArray;
	}
	else if ([value isKindOfClass:[NSString class]]) {
		newValue = [value buy_trim];
	}
	return newValue;
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	//We only need the dirty properties
	NSSet *dirtyProperties = [self dirtyProperties];
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	for (NSString *dirtyProperty in dirtyProperties) {
		id value = [self jsonValueForValue:[self valueForKey:dirtyProperty]];
		json[[BUYCheckout jsonKeyForProperty:dirtyProperty]] = value ?: [NSNull null];
	}
	return @{ @"checkout" : json };
}

- (BOOL)hasToken
{
	return (_token && [_token length] > 0);
}

@end

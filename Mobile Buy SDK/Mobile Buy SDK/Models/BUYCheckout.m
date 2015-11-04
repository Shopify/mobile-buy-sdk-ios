//
//  BUYCheckout.m
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

#import "BUYAddress.h"
#import "BUYCart.h"
#import "BUYCheckout.h"
#import "BUYDiscount.h"
#import "BUYLineItem.h"
#import "BUYMaskedCreditCard.h"
#import "BUYOrder.h"
#import "BUYProductVariant.h"
#import "BUYShippingRate.h"
#import "BUYTaxLine.h"
#import "BUYMaskedCreditCard.h"
#import "BUYGiftCard.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSString+Trim.h"
#import "BUYCheckout_Private.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSURL+BUYAdditions.h"
#import "NSDictionary+Additions.h"
#import "BUYCheckoutAttribute.h"

@implementation BUYCheckout

+ (void)initialize
{
	if (self == [BUYCheckout class]) {
		[self trackDirtyProperties];
	}
}

- (instancetype)initWithCart:(BUYCart *)cart
{
	self = [super init];
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
	
	self.order = [BUYOrder convertObject:dictionary[@"order"]];
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	self.orderId = self.order.identifier;
	self.orderStatusURL = self.order.statusURL;
#pragma GCC diagnostic pop
	
	self.webCheckoutURL = [NSURL URLWithString:dictionary[@"web_url"]];
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	self.createdAtDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	self.updatedAtDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
	self.creditCard = [BUYMaskedCreditCard convertObject:dictionary[@"credit_card"]];
	self.customerId = [dictionary buy_objectForKey:@"customer_id"];
	self.note = dictionary[@"note"];
	self.attributes = [BUYCheckoutAttribute convertJSONArray:dictionary[@"attributes"]];
	
	self.privacyPolicyURL = [NSURL buy_urlWithString:dictionary[@"privacy_policy_url"]];
	self.refundPolicyURL = [NSURL buy_urlWithString:dictionary[@"refund_policy_url"]];
	self.termsOfServiceURL = [NSURL buy_urlWithString:dictionary[@"terms_of_service_url"]];
	
	self.sourceName = dictionary[@"source_name"];
	self.sourceIdentifier = dictionary[@"source_identifier"];
}

- (NSString *)shippingRateId
{
	return self.shippingRate.shippingRateIdentifier;
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
	// We only need the dirty properties
	NSSet *dirtyProperties = [self dirtyProperties];
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	for (NSString *dirtyProperty in dirtyProperties) {
		id value = [self jsonValueForValue:[self valueForKey:dirtyProperty]];
		json[[BUYCheckout jsonKeyForProperty:dirtyProperty]] = value ?: [NSNull null];
	}
	
	// We need to serialize the attributes as they need to be posted as a dictionary
	if (json[@"attributes"]) {
		NSMutableDictionary *attributeDictionary = [[NSMutableDictionary alloc] init];
		for (NSDictionary *attribute in json[@"attributes"]) {
			attributeDictionary[[attribute allKeys][0]] = [attribute allValues][0];
		}
		json[@"attributes"] = attributeDictionary;
	}
	return @{ @"checkout" : json };
}

-(void)setPartialAddresses:(BOOL)partialAddresses
{
	if (partialAddresses == NO) {
		@throw [NSException exceptionWithName:@"partialAddress" reason:@"partialAddresses can only be set to true and should never be set to false on a complete address" userInfo:nil];
	}
	_partialAddresses = partialAddresses;
}

- (BOOL)hasToken
{
	return (_token && [_token length] > 0);
}

@end

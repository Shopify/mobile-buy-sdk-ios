//
//  MERProductVariant.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERProductVariant.h"

@implementation NSDecimalNumber (Additions)
+ (NSDecimalNumber*)decimalNumberOrZeroWithString:(NSString*)string
{
	NSDecimalNumber *decimalNumber = nil;
	if (string) {
		decimalNumber = [NSDecimalNumber decimalNumberWithString:string];
	}
	
	if (decimalNumber == nil || decimalNumber == [NSDecimalNumber notANumber]) {
		decimalNumber = [NSDecimalNumber zero];
	}
	return decimalNumber;
}
@end

@implementation MERProductVariant

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super initWithDictionary:dictionary];
	if (self) {
		self.title = dictionary[@"title"];
		self.option1 = dictionary[@"option1"];
		self.option2 = dictionary[@"option2"];
		self.option3 = dictionary[@"option3"];
		
		self.price = [MERProductVariant decimalNumberFromJSON:dictionary[@"price"]];
		self.compareAtPrice = [MERProductVariant decimalNumberFromJSON:dictionary[@"compare_at_price"]];
		self.grams = [MERProductVariant decimalNumberFromJSON:dictionary[@"grams"]];
		
		self.requiresShipping = dictionary[@"requires_shipping"];
		self.taxable = dictionary[@"taxable"];
		self.position = dictionary[@"position"];
	}
	return self;
}

+ (NSDecimalNumber*)decimalNumberFromJSON:(id)valueFromJSON
{
	static NSDecimalNumberHandler *numberHandler;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		numberHandler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers scale:12 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
	});
	
	NSDecimalNumber *decimalNumber = nil;
	if (valueFromJSON == nil || [valueFromJSON isKindOfClass:[NSNull class]]) {
		decimalNumber = nil;
	}
	else if ([valueFromJSON isKindOfClass:[NSString class]]) {
		decimalNumber = [NSDecimalNumber decimalNumberOrZeroWithString:valueFromJSON];
	}
	else if ([valueFromJSON isKindOfClass:[NSDecimalNumber class]]) {
		decimalNumber = valueFromJSON;
	}
	else if ([valueFromJSON isKindOfClass:[NSNumber class]]) {
		NSDecimal decimal = [(NSNumber*)valueFromJSON decimalValue];
		decimalNumber = [NSDecimalNumber decimalNumberWithDecimal:decimal];
	}
	else {
		decimalNumber = nil;
		NSLog(@"Could not create decimal value: %@", valueFromJSON);
	}
	
	return [decimalNumber decimalNumberByRoundingAccordingToBehavior:numberHandler];
}

@end

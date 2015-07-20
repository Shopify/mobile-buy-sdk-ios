//
//  BUYApplePayAdditions.m
//  Checkout
//
//  Created by Shopify on 2015-02-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import AddressBook;
@import PassKit;
#import "BUYApplePayAdditions.h"
#import "BUYDiscount.h"
#import "BUYAddress+Additions.h"
#import "NSDecimalNumber+BUYAdditions.h"

#define CFSafeRelease(obj) if (obj) { CFRelease(obj); }

@implementation BUYCheckout (ApplePay)

- (NSArray *)buy_summaryItems
{
	BOOL hasDiscount = [self.discount.amount compare:[NSDecimalNumber zero]] == NSOrderedDescending;
	BOOL hasGiftCards = [self.giftCards count] > 0;
	
	NSMutableArray *summaryItems = [[NSMutableArray alloc] init];
	
	if ((hasDiscount && hasGiftCards) || [self.lineItems count] > 1) {
		NSDecimalNumber *lineItemSubtotal = [NSDecimalNumber zero];
		for (BUYLineItem *lineItem in self.lineItems) {
			lineItemSubtotal = [lineItemSubtotal decimalNumberByAdding:lineItem.price];
		}
		[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"CART TOTAL" amount:lineItemSubtotal]];
	}
	
	if (hasDiscount) {
		NSString *discountLabel = [self.discount.code length] > 0 ? [NSString stringWithFormat:@"DISCOUNT (%@)", self.discount.code] : @"DISCOUNT";
		[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:discountLabel amount:[self.discount.amount buy_decimalNumberAsNegative]]];
	}

	[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"SUBTOTAL" amount:self.subtotalPrice ?: [NSDecimalNumber zero]]];
	
	if ([self.shippingRate.price compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
		[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"SHIPPING" amount:self.shippingRate.price]];
	}
	
	if ([self.totalTax compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
		[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"TAXES" amount:self.totalTax]];
	}
	
	if (hasGiftCards) {
		for (BUYGiftCard *giftCard in self.giftCards) {
			NSString *giftCardLabel = [giftCard.lastCharacters length] > 0 ? [NSString stringWithFormat:@"GIFT CARD (•••• %@)", giftCard.lastCharacters] : @"GIFT CARD";
			[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:giftCardLabel amount:giftCard.amountUsed ? [giftCard.amountUsed buy_decimalNumberAsNegative] : [giftCard.balance buy_decimalNumberAsNegative]]];
		}
	}
	
	[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"TOTAL" amount:self.paymentDue ?: [NSDecimalNumber zero]]];
	return summaryItems;
}

@end

@implementation BUYShippingRate (ApplePay)

+ (NSArray *)buy_convertShippingRatesToShippingMethods:(NSArray *)rates
{
	NSMutableArray *shippingMethods = [[NSMutableArray alloc] init];
	for (BUYShippingRate *shippingRate in rates) {
		PKShippingMethod *shippingMethod = [[PKShippingMethod alloc] init];
		shippingMethod.label = [shippingRate title];
		shippingMethod.amount = [shippingRate price];
		shippingMethod.identifier = [shippingRate shippingRateIdentifier];
		shippingMethod.detail = @"";
		[shippingMethods addObject:shippingMethod];
	}
	return shippingMethods;
}

@end

@implementation BUYAddress (ApplePay)

+ (NSString *)buy_emailFromRecord:(ABRecordRef)record
{
	ABMultiValueRef emailMultiValue = ABRecordCopyValue(record, kABPersonEmailProperty);
	CFArrayRef allEmails = ABMultiValueCopyArrayOfAllValues(emailMultiValue);
	
	NSString *email = nil;
	if (allEmails && CFArrayGetCount(allEmails)) {
		email = (__bridge NSString *)CFArrayGetValueAtIndex(allEmails, 0);
	}
	CFSafeRelease(allEmails);
	CFSafeRelease(emailMultiValue);
	
	return email;
}

+ (BUYAddress *)buy_addressFromRecord:(ABRecordRef)record
{
	BUYAddress *address = [[BUYAddress alloc] init];
	
	//Grab the simple information
	address.firstName = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty);
	if ([address.firstName length] == 0) {
		address.firstName = BUYPartialAddressPlaceholder;
	}
	
	address.lastName = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
	if ([[address lastName] length] == 0) {
		address.lastName = BUYPartialAddressPlaceholder;
	}
	
	//Grab the address information
	ABMultiValueRef addressMultiValue = ABRecordCopyValue(record, kABPersonAddressProperty);
	CFArrayRef allAddresses = ABMultiValueCopyArrayOfAllValues(addressMultiValue);
	if (allAddresses && CFArrayGetCount(allAddresses) > 0) {
		CFDictionaryRef firstAddress = CFArrayGetValueAtIndex(allAddresses, 0);
		
		//NOTE: We do not receive an address1 line right now via this partial address, as Apple deemds it unimportant to calculate the shipping rates. We get the actual address later on in a later step.
		address.address1 = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressStreetKey);
		if (address.address1 == nil) {
			address.address1 = BUYPartialAddressPlaceholder;
		}
		
		address.city = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressCityKey);
		address.province = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressStateKey);
		address.zip = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressZIPKey);
		address.country = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressCountryKey);
	}
	CFSafeRelease(allAddresses);
	CFSafeRelease(addressMultiValue);
	
	//Grab the phone number information
	ABMultiValueRef phoneMultiValue = ABRecordCopyValue(record, kABPersonPhoneProperty);
	CFArrayRef allPhoneNumbers = ABMultiValueCopyArrayOfAllValues(phoneMultiValue);
	if (allPhoneNumbers && CFArrayGetCount(allPhoneNumbers) > 0) {
		address.phone = (__bridge NSString *)CFArrayGetValueAtIndex(allPhoneNumbers, 0);
	}
	if ([address.phone length] == 0) {
		address.phone = BUYPartialAddressPlaceholder;
	}
	CFSafeRelease(phoneMultiValue);
	CFSafeRelease(allPhoneNumbers);
	
	return address;
}

@end

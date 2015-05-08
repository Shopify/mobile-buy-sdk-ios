//
//  CHKApplePayAdditions.m
//  Checkout
//
//  Created by Shopify on 2015-02-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import AddressBook;
@import PassKit;
#import "CHKApplePayAdditions.h"

#define CFSafeRelease(obj) if (obj) { CFRelease(obj); }

@implementation CHKCheckout (ApplePay)

- (NSArray *)chk_summaryItems
{
	NSMutableArray *summaryItems = [[NSMutableArray alloc] init];
	[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"SUBTOTAL" amount:self.subtotalPrice ?: [NSDecimalNumber zero]]];
	
	if ([self.discount.amount compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
		NSString *discountLabel = [self.discount.code length] > 0 ? [NSString stringWithFormat:@"DISCOUNT (%@)", self.discount.code] : @"DISCOUNT";
		[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:discountLabel amount:self.discount.amount]];
	}
	
	if ([self.shippingRate.price compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
		[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"SHIPPING" amount:self.shippingRate.price]];
	}
	
	if ([self.totalTax compare:[NSDecimalNumber zero]] == NSOrderedDescending) {
		[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"TAXES" amount:self.totalTax]];
	}
	
	[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:@"TOTAL" amount:self.totalPrice ?: [NSDecimalNumber zero]]];
	return summaryItems;
}

@end

@implementation CHKShippingRate (ApplePay)

+ (NSArray *)chk_convertShippingRatesToShippingMethods:(NSArray *)rates
{
	NSMutableArray *shippingMethods = [[NSMutableArray alloc] init];
	for (CHKShippingRate *shippingRate in rates) {
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

@implementation CHKAddress (ApplePay)

+ (NSString *)chk_emailFromRecord:(ABRecordRef)record
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

+ (CHKAddress *)chk_addressFromRecord:(ABRecordRef)record
{
	CHKAddress *address = [[CHKAddress alloc] init];
	
	//Grab the simple information
	address.firstName = (__bridge NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty);
	if ([address.firstName length] == 0) {
		address.firstName = @"---";
	}
	
	address.lastName = (__bridge NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
	if ([[address lastName] length] == 0) {
		address.lastName = @"---";
	}
	
	//Grab the address information
	ABMultiValueRef addressMultiValue = ABRecordCopyValue(record, kABPersonAddressProperty);
	CFArrayRef allAddresses = ABMultiValueCopyArrayOfAllValues(addressMultiValue);
	if (allAddresses && CFArrayGetCount(allAddresses) > 0) {
		CFDictionaryRef firstAddress = CFArrayGetValueAtIndex(allAddresses, 0);
		
		//NOTE: We do not receive an address1 line right now via this partial address, as Apple deemds it unimportant to calculate the shipping rates. We get the actual address later on in a later step.
		address.address1 = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressStreetKey);
		if (address.address1 == nil) {
			address.address1 = @"---";
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
	CFSafeRelease(phoneMultiValue);
	CFSafeRelease(allPhoneNumbers);
	
	return address;
}

@end

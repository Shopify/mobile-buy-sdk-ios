//
//  BUYApplePayAdditions.m
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

@import AddressBook;
@import PassKit;
#import "BUYLineItem.h"
#import "BUYGiftCard.h"
#import "BUYApplePayAdditions.h"
#import "BUYDiscount.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSDate+BUYAdditions.h"

#define CFSafeRelease(obj) if (obj) { CFRelease(obj); }

@implementation BUYCheckout (ApplePay)

- (nonnull NSArray<PKPaymentSummaryItem *> *)buy_summaryItemsWithShopName:(nullable NSString *)shopName {
	
	BOOL hasDiscount = [self.discount.amount compare:[NSDecimalNumber zero]] == NSOrderedDescending;
	
	NSMutableArray<PKPaymentSummaryItem *> *summaryItems = [[NSMutableArray alloc] init];
	
	if (hasDiscount || [self.lineItems count] > 1) {
		NSDecimalNumber *lineItemSubtotal = [NSDecimalNumber zero];
		for (BUYLineItem *lineItem in self.lineItems) {
			lineItemSubtotal = [lineItemSubtotal decimalNumberByAdding:lineItem.linePrice];
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
	
	if ([self.giftCards count] > 0) {
		for (BUYGiftCard *giftCard in self.giftCards) {
			NSString *giftCardLabel = [giftCard.lastCharacters length] > 0 ? [NSString stringWithFormat:@"GIFT CARD (•••• %@)", giftCard.lastCharacters] : @"GIFT CARD";
			[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:giftCardLabel amount:giftCard.amountUsed ? [giftCard.amountUsed buy_decimalNumberAsNegative] : [giftCard.balance buy_decimalNumberAsNegative]]];
		}
	}
	
	NSString *itemLabel = shopName ?: @"TOTAL";
	[summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:itemLabel amount:self.paymentDue ?: [NSDecimalNumber zero]]];

	return summaryItems;
}

- (nonnull NSArray<PKPaymentSummaryItem *> *)buy_summaryItems
{
	return [self buy_summaryItemsWithShopName:nil];
}

@end

@implementation BUYShippingRate (ApplePay)

+ (nonnull NSArray<PKShippingMethod *> *)buy_convertShippingRatesToShippingMethods:(nonnull NSArray<BUYShippingRate *> *)rates
{
	NSMutableArray<PKShippingMethod *> *shippingMethods = [[NSMutableArray alloc] init];
	for (BUYShippingRate *shippingRate in rates) {
		PKShippingMethod *shippingMethod = [[PKShippingMethod alloc] init];
		shippingMethod.label = shippingRate.title;
		shippingMethod.amount = shippingRate.price;
		shippingMethod.identifier = shippingRate.shippingRateIdentifier;
		if ([shippingRate.deliveryRange count]) {
			NSInteger daysInBetweenFirst = 1 + [NSDate daysBetweenDate:[NSDate date] andDate:shippingRate.deliveryRange[0]];
			NSInteger daysInBetweenLast = 1 + [NSDate daysBetweenDate:[NSDate date] andDate:[shippingRate.deliveryRange lastObject]];
			BOOL plural = NO;
			NSString *deliveryDetailDays = @"";
			if (daysInBetweenLast - daysInBetweenFirst == 0) {
				plural = daysInBetweenFirst > 1;
				deliveryDetailDays = [NSString stringWithFormat:@"%lu", (long)daysInBetweenFirst];
			} else {
				plural = YES;
				deliveryDetailDays = [NSString stringWithFormat:@"%ld-%ld", (long)daysInBetweenFirst, (long)daysInBetweenLast];
			}
			shippingMethod.detail = [NSString stringWithFormat:@"%@ day%@", deliveryDetailDays, plural ? @"s" : @""];
		} else {
			shippingMethod.detail = @"";
		}
		[shippingMethods addObject:shippingMethod];
	}
	return shippingMethods;
}

@end

@implementation BUYAddress (ApplePay)

+ (nullable NSString *)buy_emailFromRecord:(nullable ABRecordRef)record
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

- (void)updateWithRecord:(nullable ABRecordRef)record
{
	//Grab the simple information
	self.firstName = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty);
	self.lastName = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
	
	//Grab the address information
	ABMultiValueRef addressMultiValue = ABRecordCopyValue(record, kABPersonAddressProperty);
	CFArrayRef allAddresses = ABMultiValueCopyArrayOfAllValues(addressMultiValue);
	if (allAddresses && CFArrayGetCount(allAddresses) > 0) {
		CFDictionaryRef firstAddress = CFArrayGetValueAtIndex(allAddresses, 0);
		
		//NOTE: We do not receive an address1 line right now via this partial address, as Apple deemds it unimportant to calculate the shipping rates. We get the actual address later on in a later step.
		self.address1 = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressStreetKey);
		self.city = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressCityKey);
		self.province = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressStateKey);
		self.zip = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressZIPKey);
		// The Checkout API accepts country OR ISO country code.
		// We default to the ISO country code because it's more
		// reliable regardless of locale. Fallback to country if
		// we do not receive it (iOS 8 sometimes)
		self.countryCode = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressCountryCodeKey);
		if ([self.countryCode length] == 0) {
			self.country = (__bridge NSString *)CFDictionaryGetValue(firstAddress, kABPersonAddressCountryKey);
		}
	}
	CFSafeRelease(allAddresses);
	CFSafeRelease(addressMultiValue);
	
	//Grab the phone number information
	ABMultiValueRef phoneMultiValue = ABRecordCopyValue(record, kABPersonPhoneProperty);
	CFArrayRef allPhoneNumbers = ABMultiValueCopyArrayOfAllValues(phoneMultiValue);
	if (allPhoneNumbers && CFArrayGetCount(allPhoneNumbers) > 0) {
		self.phone = (__bridge NSString *)CFArrayGetValueAtIndex(allPhoneNumbers, 0);
	}

	CFSafeRelease(phoneMultiValue);
	CFSafeRelease(allPhoneNumbers);
}

- (void)updateWithContact:(nullable PKContact*)contact
{
	self.firstName = contact.name.givenName;
	self.lastName = contact.name.familyName;
	
	if (contact.postalAddress) {
		// break up the address:
		NSArray *addressComponents = [contact.postalAddress.street componentsSeparatedByString:@"\n"];
		self.address1 = addressComponents[0];
		self.address2 = (addressComponents.count > 1) ? addressComponents[1] : nil;
		self.city = contact.postalAddress.city;
		self.province = contact.postalAddress.state;
		self.zip = contact.postalAddress.postalCode;
		// The Checkout API accepts country OR ISO country code.
		// We default to the ISO country code because it's more
		// reliable regardless of locale. Fallback to country if
		// we do not receive it (iOS 8 sometimes)
		self.countryCode = [contact.postalAddress.ISOCountryCode length] ? contact.postalAddress.ISOCountryCode : nil;
		if (self.countryCode == nil) {
			self.country = contact.postalAddress.country;
		}
	}

	self.phone = contact.phoneNumber.stringValue;
}

@end

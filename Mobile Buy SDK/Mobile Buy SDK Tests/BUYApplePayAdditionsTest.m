//
//  BUYApplePayAdditionsTest.m
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
@import UIKit;
@import XCTest;
#import <Buy/Buy.h>
#import "BUYAddress+Additions.h"
#import "BUYCheckout_Private.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSDateFormatter+BUYAdditions.h"

#import "BUYPKContact.h"
#import "BUYNSPersonNameComponents.h"
#import "BUYCNPostalAddress.h"


@interface BUYApplePayAdditionsTest : XCTestCase
@end

@implementation BUYApplePayAdditionsTest {
	BUYCheckout *_checkout;
}

- (void)setUp
{
	_checkout = [[BUYCheckout alloc] initWithCart:nil];
}

#pragma mark - BUYCheckout Apple Pay additions

- (void)testSummaryItemsWithEmptyCheckout
{
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(2, [summaryItems count]);
	
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber zero], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[1] label]);
	XCTAssertEqualObjects([NSDecimalNumber zero], [summaryItems[1] amount]);
}

- (void)testFullSummaryItems
{
	_checkout.subtotalPrice = [NSDecimalNumber one];
	_checkout.shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"price" : @"2.00" }];
	_checkout.totalTax = [NSDecimalNumber decimalNumberWithString:@"1.00"];
	_checkout.paymentDue = [NSDecimalNumber decimalNumberWithString:@"4.00"];
	
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(4, [summaryItems count]);
	
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber one], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"SHIPPING", [summaryItems[1] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"2.00"], [summaryItems[1] amount]);
	XCTAssertEqualObjects(@"TAXES", [summaryItems[2] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"1.00"], [summaryItems[2] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[3] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"4.00"], [summaryItems[3] amount]);
}

- (void)testSummaryItemsWithShippingRate
{
	_checkout.subtotalPrice = [NSDecimalNumber one];
	_checkout.shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"price" : @"2.00" }];
	_checkout.paymentDue = [NSDecimalNumber decimalNumberWithString:@"3.00"];
	
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(3, [summaryItems count]);
	
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber one], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"SHIPPING", [summaryItems[1] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"2.00"], [summaryItems[1] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[2] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"3.00"], [summaryItems[2] amount]);
}

- (void)testSummaryItemsWithFreeShippingAndTaxesShouldNotShowShippingOrTaxes
{
	_checkout.subtotalPrice = [NSDecimalNumber one];
	_checkout.shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"price" : @"0.00" }];
	_checkout.totalTax = [NSDecimalNumber zero];
	_checkout.paymentDue = [NSDecimalNumber decimalNumberWithString:@"3.00"];
	
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(2, [summaryItems count]);
	
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber one], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[1] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"3.00"], [summaryItems[1] amount]);
}

- (void)testSummaryItemsWithZeroDiscount
{
	_checkout.subtotalPrice = [NSDecimalNumber one];
	_checkout.shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"price" : @"0.00" }];
	_checkout.totalTax = [NSDecimalNumber zero];
	_checkout.paymentDue = [NSDecimalNumber decimalNumberWithString:@"3.00"];
	BUYDiscount *discount = [[BUYDiscount alloc] init];
	discount.code = @"BANANA";
	discount.amount = [NSDecimalNumber zero];
	discount.applicable = YES;
	_checkout.discount = discount;
	
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(2, [summaryItems count]);
	
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber one], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[1] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"3.00"], [summaryItems[1] amount]);
}

- (void)testSummaryItemsWithNonZeroDiscount
{
	_checkout.subtotalPrice = [NSDecimalNumber one];
	_checkout.shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"price" : @"0.00" }];
	_checkout.totalTax = [NSDecimalNumber zero];
	_checkout.paymentDue = [NSDecimalNumber decimalNumberWithString:@"2.00"];
	BUYDiscount *discount = [[BUYDiscount alloc] init];
	discount.code = @"BANANA";
	discount.amount = [NSDecimalNumber one];
	discount.applicable = YES;
	_checkout.discount = discount;
	
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(4, [summaryItems count]);
	XCTAssertEqualObjects(@"CART TOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber zero], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"DISCOUNT (BANANA)", [summaryItems[1] label]);
	XCTAssertEqualObjects([[NSDecimalNumber one] buy_decimalNumberAsNegative], [summaryItems[1] amount]);
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[2] label]);
	XCTAssertEqualObjects([NSDecimalNumber one], [summaryItems[2] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[3] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"2.00"], [summaryItems[3] amount]);
}

- (void)testSummaryItemsWithNonZeroCodelessDiscount
{
	_checkout.subtotalPrice = [NSDecimalNumber one];
	_checkout.shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"price" : @"0.00" }];
	_checkout.totalTax = [NSDecimalNumber zero];
	_checkout.paymentDue = [NSDecimalNumber decimalNumberWithString:@"2.00"];
	BUYDiscount *discount = [[BUYDiscount alloc] init];
	discount.code = @"";
	discount.amount = [NSDecimalNumber one];
	discount.applicable = YES;
	_checkout.discount = discount;
	
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(4, [summaryItems count]);
	XCTAssertEqualObjects(@"CART TOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber zero], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"DISCOUNT", [summaryItems[1] label]);
	XCTAssertEqualObjects([[NSDecimalNumber one] buy_decimalNumberAsNegative], [summaryItems[1] amount]);
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[2] label]);
	XCTAssertEqualObjects([NSDecimalNumber one], [summaryItems[2] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[3] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"2.00"], [summaryItems[3] amount]);
}

- (void)testSummaryItemsWithGiftCard
{
	_checkout.subtotalPrice = [NSDecimalNumber decimalNumberWithString:@"12.00"];
	_checkout.shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"price" : @"0.00" }];
	_checkout.totalTax = [NSDecimalNumber zero];
	_checkout.paymentDue = [NSDecimalNumber decimalNumberWithString:@"2.00"];
	BUYDiscount *discount = [[BUYDiscount alloc] init];
	discount.code = @"";
	discount.amount = [NSDecimalNumber one];
	discount.applicable = YES;
	_checkout.discount = discount;
	
	BUYGiftCard *giftCard = [[BUYGiftCard alloc] initWithDictionary:@{ @"amount_used" : [NSDecimalNumber decimalNumberWithString:@"10.00"], @"balance" : [NSDecimalNumber decimalNumberWithString:@"10.00"], @"last_characters" : @"1234" }];
	_checkout.giftCards = @[giftCard];
	
	NSArray *summaryItems = [_checkout buy_summaryItems];
	XCTAssertEqual(5, [summaryItems count]);
	XCTAssertEqualObjects(@"CART TOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber zero], [summaryItems[0] amount]);
	XCTAssertEqualObjects(@"DISCOUNT", [summaryItems[1] label]);
	XCTAssertEqualObjects([[NSDecimalNumber one] buy_decimalNumberAsNegative], [summaryItems[1] amount]);
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[2] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"12.00"], [summaryItems[2] amount]);
	XCTAssertEqualObjects(@"GIFT CARD (•••• 1234)", [summaryItems[3] label]);
	XCTAssertEqualObjects([[NSDecimalNumber decimalNumberWithString:@"10.00"] buy_decimalNumberAsNegative], [summaryItems[3] amount]);
	XCTAssertEqualObjects(@"TOTAL", [summaryItems[4] label]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"2.00"], [summaryItems[4] amount]);

}

#pragma mark - BUYShippingRate Apple Pay additions

- (void)testConvertShippingRatesToShippingMethods
{
	// Create fake dates from now. We need to remove the hours, minutes and seconds
	// so it's at GMT as this is what Shopify provides
	NSInteger day = 60*60*24;
	NSDate *firstDate = [self dateWithoutTime:[NSDate dateWithTimeIntervalSinceNow:day]];
	NSDate *lastDate = [self dateWithoutTime:[NSDate dateWithTimeIntervalSinceNow:day]];
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForShippingRates];
	
	BUYShippingRate *rate1 = [[BUYShippingRate alloc] initWithDictionary:@{@"price" : @"5.00", @"id" : @"1234", @"title" : @"Banana", @"delivery_range" : @[[dateFormatter stringFromDate:firstDate], [dateFormatter stringFromDate:lastDate]]}];
	
	firstDate = [self dateWithoutTime:[NSDate dateWithTimeIntervalSinceNow:day * 3]];
	lastDate = [self dateWithoutTime:[NSDate dateWithTimeIntervalSinceNow:day * 5]];
	BUYShippingRate *rate2 = [[BUYShippingRate alloc] initWithDictionary:@{@"price" : @"3.00", @"id" : @"5678", @"title" : @"Dinosaur", @"delivery_range" : @[[dateFormatter stringFromDate:firstDate], [dateFormatter stringFromDate:lastDate]]}];
	
	firstDate = [self dateWithoutTime:[NSDate dateWithTimeIntervalSinceNow:day * 10]];
	lastDate = [self dateWithoutTime:[NSDate dateWithTimeIntervalSinceNow:day * 12]];
	BUYShippingRate *rate3 = [[BUYShippingRate alloc] initWithDictionary:@{@"price" : @"19.00", @"id" : @"1357", @"title" : @"Bulldozer", @"delivery_range" : @[[dateFormatter stringFromDate:firstDate], [dateFormatter stringFromDate:lastDate]]}];
	
	NSArray *shippingMethods = [BUYShippingRate buy_convertShippingRatesToShippingMethods:@[rate1, rate2, rate3]];
	XCTAssertEqual(3, [shippingMethods count]);
	
	PKShippingMethod *method1 = shippingMethods[0];
	XCTAssertEqualObjects(@"1234", method1.identifier);
	XCTAssertEqualObjects(@"Banana", method1.label);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5.00"], method1.amount);
	XCTAssertEqualObjects(@"1 day", method1.detail);
	
	PKShippingMethod *method2 = shippingMethods[1];
	XCTAssertEqualObjects(@"5678", method2.identifier);
	XCTAssertEqualObjects(@"Dinosaur", method2.label);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"3.00"], method2.amount);
	XCTAssertEqualObjects(@"3-5 days", method2.detail);
	
	PKShippingMethod *method3 = shippingMethods[2];
	XCTAssertEqualObjects(@"1357", method3.identifier);
	XCTAssertEqualObjects(@"Bulldozer", method3.label);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"19.00"], method3.amount);
	XCTAssertEqualObjects(@"10-12 days", method3.detail);
}

-(NSDate *)dateWithoutTime:(NSDate *)date {
	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
	[dateComponents setHour:00];
	[dateComponents setMinute:00];
	[dateComponents setSecond:00];
	[dateComponents setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

- (void)testConvertShippingRatesToShippingMethodsWithEmptyArray
{
	NSArray *shippingMethods = [BUYShippingRate buy_convertShippingRatesToShippingMethods:@[]];
	XCTAssertEqual(0, [shippingMethods count]);
}

#pragma mark - BUYAddress Apple Pay additions

- (void)testEmailFromRecord
{
	ABRecordRef person = ABPersonCreate();
	CFErrorRef error = NULL;
	ABRecordSetValue(person, kABPersonFirstNameProperty, CFSTR("Bob"), &error);
	ABRecordSetValue(person, kABPersonLastNameProperty, CFSTR("Banana"), &error);
	
	ABMutableMultiValueRef emails = ABMultiValueCreateMutable(kABStringPropertyType);
	ABMultiValueAddValueAndLabel(emails, CFSTR("bob@banana.com"), CFSTR("work"), nil);
	ABMultiValueAddValueAndLabel(emails, CFSTR("dino@banana.com"), CFSTR("home"), nil);
	ABRecordSetValue(person, kABPersonEmailProperty, emails, &error);
	CFRelease(emails);
	
	XCTAssertEqualObjects(@"bob@banana.com", [BUYAddress buy_emailFromRecord:person]);
	
	CFRelease(person);
}

- (void)testEmailFromRecordWithoutAnEmail
{
	ABRecordRef person = ABPersonCreate();
	CFErrorRef error = NULL;
	ABRecordSetValue(person, kABPersonFirstNameProperty, CFSTR("Bob"), &error);
	ABRecordSetValue(person, kABPersonLastNameProperty, CFSTR("Banana"), &error);
	
	XCTAssertNil([BUYAddress buy_emailFromRecord:person]);
	
	CFRelease(person);
}

- (void)testAddressFromRecord
{
	BUYAddress *newAddress = [self buyAddressWithTestRecordFullDetails:YES];
	XCTAssertNotNil(newAddress);
	XCTAssertEqualObjects(@"Bob", newAddress.firstName);
	XCTAssertEqualObjects(@"Banana", newAddress.lastName);
	XCTAssertEqualObjects(@"150 Elgin Street", newAddress.address1);
	XCTAssertEqualObjects(@"Ottawa", newAddress.city);
	XCTAssertEqualObjects(@"Ontario", newAddress.province);
	XCTAssertEqualObjects(@"K1N5T5", newAddress.zip);
	XCTAssertNil(newAddress.country);
	XCTAssertEqualObjects(@"CA", newAddress.countryCode);
	XCTAssertEqualObjects(@"1-888-746-7439", newAddress.phone);
}

- (BUYAddress*)buyAddressWithTestRecordFullDetails:(BOOL)fullDetails
{
	ABRecordRef person = ABPersonCreate();
	CFErrorRef error = NULL;
	if (fullDetails) {
		ABRecordSetValue(person, kABPersonFirstNameProperty, CFSTR("Bob"), &error);
		ABRecordSetValue(person, kABPersonLastNameProperty, CFSTR("Banana"), &error);
	}
	
	ABMutableMultiValueRef addresses = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
	CFMutableDictionaryRef address = CFDictionaryCreateMutable(kCFAllocatorDefault, 10, nil, nil);
	if (fullDetails) {
		CFDictionarySetValue(address, kABPersonAddressStreetKey, CFSTR("150 Elgin Street"));
	}
	CFDictionarySetValue(address, kABPersonAddressCityKey, CFSTR("Ottawa"));
	CFDictionarySetValue(address, kABPersonAddressStateKey, CFSTR("Ontario"));
	CFDictionarySetValue(address, kABPersonAddressZIPKey, CFSTR("K1N5T5"));
	CFDictionarySetValue(address, kABPersonAddressCountryKey, CFSTR("Canada"));
	CFDictionarySetValue(address, kABPersonAddressCountryCodeKey, CFSTR("CA"));
	
	if (fullDetails) {
		ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
		ABMultiValueAddValueAndLabel(phoneNumberMultiValue, @"1-888-746-7439", kABPersonPhoneMobileLabel, NULL);
		ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
	}
	
	ABMultiValueAddValueAndLabel(addresses, address, CFSTR("Shipping"), nil);
	CFRelease(address);
	
	ABRecordSetValue(person, kABPersonAddressProperty, addresses, &error);
	CFRelease(addresses);
	
	BUYAddress *newAddress = [BUYAddress buy_addressFromRecord:person];
	
	CFRelease(person);

	return newAddress;
}

- (void)testAddressFromRecordWithoutNameOrStreetOrPhone
{
	BUYAddress *newAddress = [self buyAddressWithTestRecordFullDetails:NO];
	XCTAssertNotNil(newAddress);
	XCTAssertEqualObjects(BUYPartialAddressPlaceholder, newAddress.address1);
	XCTAssertEqualObjects(@"Ottawa", newAddress.city);
	XCTAssertEqualObjects(@"Ontario", newAddress.province);
	XCTAssertEqualObjects(@"K1N5T5", newAddress.zip);
	XCTAssertNil(newAddress.country);
	XCTAssertEqualObjects(@"CA", newAddress.countryCode);
	XCTAssertEqualObjects(BUYPartialAddressPlaceholder, newAddress.phone);
}

- (void)testAddressFromContact
{
	BUYAddress *newAddress = [self buyAddressWithTestContactFullDetails:YES];
	
	XCTAssertNotNil(newAddress);
	XCTAssertEqualObjects(@"Bob", newAddress.firstName);
	XCTAssertEqualObjects(@"Banana", newAddress.lastName);
	XCTAssertEqualObjects(@"150 Elgin Street", newAddress.address1);
	XCTAssertEqualObjects(@"Ottawa", newAddress.city);
	XCTAssertEqualObjects(@"Ontario", newAddress.province);
	XCTAssertEqualObjects(@"K1N5T5", newAddress.zip);
	XCTAssertNil(newAddress.country);
	XCTAssertEqualObjects(@"CA", newAddress.countryCode);
}

- (BUYAddress*)buyAddressWithTestContactFullDetails:(BOOL)fullDetails
{
	BUYPKContact *contact = [[BUYPKContact alloc ] init];
	BUYCNPostalAddress *postalAddress = [[BUYCNPostalAddress alloc] init];
	
	if (fullDetails) {
		BUYNSPersonNameComponents *personNameComponents = [[BUYNSPersonNameComponents alloc] init];
		[personNameComponents setGivenName:@"Bob"];
		[personNameComponents setFamilyName:@"Banana"];
		[contact setName:personNameComponents];
		CNPhoneNumber *phoneNumber = [CNPhoneNumber phoneNumberWithStringValue:@"1-888-746-7439"];
		[contact setPhoneNumber:phoneNumber];
		[postalAddress setStreet:@"150 Elgin Street"];
	}
	
	[postalAddress setCity:@"Ottawa"];
	[postalAddress setState:@"Ontario"];
	[postalAddress setPostalCode:@"K1N5T5"];
	[postalAddress setCountry:@"Canada"];
	[postalAddress setISOCountryCode:@"CA"];
	[contact setPostalAddress:postalAddress];
	
	return [BUYAddress buy_addressFromContact:contact];
}

- (void)testCompareAddressWithContactWithNameOrStreetOrPhone
{
	BUYAddress *addressFromRecord = [self buyAddressWithTestRecordFullDetails:YES];
	BUYAddress *addressFromContact = [self buyAddressWithTestContactFullDetails:YES];
	[self compareAddressFromRecord:addressFromRecord withAddressFromContact:addressFromContact];
}

- (void)testCompareAddressWithContactWithoutNameOrStreetOrPhone
{
	BUYAddress *addressFromRecord = [self buyAddressWithTestRecordFullDetails:NO];
	BUYAddress *addressFromContact = [self buyAddressWithTestContactFullDetails:NO];
	[self compareAddressFromRecord:addressFromRecord withAddressFromContact:addressFromContact];
}

- (void)compareAddressFromRecord:(BUYAddress*)addressFromRecord withAddressFromContact:(BUYAddress*)addressFromContact {
	XCTAssertNotNil(addressFromRecord);
	XCTAssertNotNil(addressFromContact);
	XCTAssertEqualObjects(addressFromRecord.firstName, addressFromContact.firstName);
	XCTAssertEqualObjects(addressFromRecord.lastName, addressFromContact.lastName);
	XCTAssertEqualObjects(addressFromRecord.address1, addressFromContact.address1);
	XCTAssertEqualObjects(addressFromRecord.address2, addressFromContact.address2);
	XCTAssertEqualObjects(addressFromRecord.city, addressFromContact.city);
	XCTAssertEqualObjects(addressFromRecord.province, addressFromContact.province);
	XCTAssertEqualObjects(addressFromRecord.zip, addressFromContact.zip);
	XCTAssertEqualObjects(addressFromRecord.country, addressFromContact.country);
	XCTAssertEqualObjects(addressFromRecord.phone, addressFromContact.phone);
	XCTAssertEqualObjects(addressFromRecord.countryCode, addressFromContact.countryCode);
}

- (void)testUseShopNameInPaymentSummary
{
	NSString *shopName = @"My Shop";
	
	NSArray *summaryItems = [_checkout buy_summaryItemsWithShopName:shopName];
	XCTAssertEqual(2, [summaryItems count]);
	
	XCTAssertEqualObjects(@"SUBTOTAL", [summaryItems[0] label]);
	XCTAssertEqualObjects([NSDecimalNumber zero], [summaryItems[0] amount]);
	XCTAssertEqualObjects(shopName, [summaryItems[1] label]);
	XCTAssertEqualObjects([NSDecimalNumber zero], [summaryItems[1] amount]);
}

@end

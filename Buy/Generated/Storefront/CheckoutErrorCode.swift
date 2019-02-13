//
//  CheckoutErrorCode.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
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

import Foundation

extension Storefront {
	/// Possible error codes that could be returned by a checkout mutation. 
	public enum CheckoutErrorCode: String {
		/// Checkout is already completed. 
		case alreadyCompleted = "ALREADY_COMPLETED"

		/// Input value is blank. 
		case blank = "BLANK"

		/// Cart does not meet discount requirements notice. 
		case cartDoesNotMeetDiscountRequirementsNotice = "CART_DOES_NOT_MEET_DISCOUNT_REQUIREMENTS_NOTICE"

		/// Customer already used once per customer discount notice. 
		case customerAlreadyUsedOncePerCustomerDiscountNotice = "CUSTOMER_ALREADY_USED_ONCE_PER_CUSTOMER_DISCOUNT_NOTICE"

		/// Discount disabled. 
		case discountDisabled = "DISCOUNT_DISABLED"

		/// Discount expired. 
		case discountExpired = "DISCOUNT_EXPIRED"

		/// Discount limit reached. 
		case discountLimitReached = "DISCOUNT_LIMIT_REACHED"

		/// Discount not found. 
		case discountNotFound = "DISCOUNT_NOT_FOUND"

		/// Checkout is already completed. 
		case empty = "EMPTY"

		/// Gift card has already been applied. 
		case giftCardAlreadyApplied = "GIFT_CARD_ALREADY_APPLIED"

		/// Gift card code is invalid. 
		case giftCardCodeInvalid = "GIFT_CARD_CODE_INVALID"

		/// Gift card currency does not match checkout currency. 
		case giftCardCurrencyMismatch = "GIFT_CARD_CURRENCY_MISMATCH"

		/// Gift card is disabled. 
		case giftCardDisabled = "GIFT_CARD_DISABLED"

		/// Gift card is expired. 
		case giftCardExpired = "GIFT_CARD_EXPIRED"

		/// Gift card was not found. 
		case giftCardNotFound = "GIFT_CARD_NOT_FOUND"

		/// Gift card cannot be applied to a checkout that contains a gift card. 
		case giftCardUnusable = "GIFT_CARD_UNUSABLE"

		/// Input value should be greater than or equal to minimum allowed value. 
		case greaterThanOrEqualTo = "GREATER_THAN_OR_EQUAL_TO"

		/// Input value is invalid. 
		case invalid = "INVALID"

		/// Input Zip is invalid for country and province provided. 
		case invalidForCountryAndProvince = "INVALID_FOR_COUNTRY_AND_PROVINCE"

		/// Invalid province in country. 
		case invalidProvinceInCountry = "INVALID_PROVINCE_IN_COUNTRY"

		/// Invalid region in country. 
		case invalidRegionInCountry = "INVALID_REGION_IN_COUNTRY"

		/// Invalid state in country. 
		case invalidStateInCountry = "INVALID_STATE_IN_COUNTRY"

		/// Input value should be less than maximum allowed value. 
		case lessThan = "LESS_THAN"

		/// Input value should be less or equal to maximum allowed value. 
		case lessThanOrEqualTo = "LESS_THAN_OR_EQUAL_TO"

		/// Line item was not found in checkout. 
		case lineItemNotFound = "LINE_ITEM_NOT_FOUND"

		/// Checkout is locked. 
		case locked = "LOCKED"

		/// Missing payment input. 
		case missingPaymentInput = "MISSING_PAYMENT_INPUT"

		/// Not enough in stock. 
		case notEnoughInStock = "NOT_ENOUGH_IN_STOCK"

		/// Input value is not supported. 
		case notSupported = "NOT_SUPPORTED"

		/// Input value is not present. 
		case present = "PRESENT"

		/// Shipping rate expired. 
		case shippingRateExpired = "SHIPPING_RATE_EXPIRED"

		/// Input value is too long. 
		case tooLong = "TOO_LONG"

		case unknownValue = ""
	}
}

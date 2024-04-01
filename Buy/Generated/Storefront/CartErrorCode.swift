//
//  CartErrorCode.swift
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
	/// Possible error codes that can be returned by `CartUserError`. 
	public enum CartErrorCode: String {
		/// The specified address field contains emojis. 
		case addressFieldContainsEmojis = "ADDRESS_FIELD_CONTAINS_EMOJIS"

		/// The specified address field contains HTML tags. 
		case addressFieldContainsHtmlTags = "ADDRESS_FIELD_CONTAINS_HTML_TAGS"

		/// The specified address field contains a URL. 
		case addressFieldContainsUrl = "ADDRESS_FIELD_CONTAINS_URL"

		/// The specified address field does not match the expected pattern. 
		case addressFieldDoesNotMatchExpectedPattern = "ADDRESS_FIELD_DOES_NOT_MATCH_EXPECTED_PATTERN"

		/// The specified address field is required. 
		case addressFieldIsRequired = "ADDRESS_FIELD_IS_REQUIRED"

		/// The specified address field is too long. 
		case addressFieldIsTooLong = "ADDRESS_FIELD_IS_TOO_LONG"

		/// The input value is invalid. 
		case invalid = "INVALID"

		/// Company location not found or not allowed. 
		case invalidCompanyLocation = "INVALID_COMPANY_LOCATION"

		/// Delivery group was not found in cart. 
		case invalidDeliveryGroup = "INVALID_DELIVERY_GROUP"

		/// Delivery option was not valid. 
		case invalidDeliveryOption = "INVALID_DELIVERY_OPTION"

		/// The quantity must be a multiple of the specified increment. 
		case invalidIncrement = "INVALID_INCREMENT"

		/// Merchandise line was not found in cart. 
		case invalidMerchandiseLine = "INVALID_MERCHANDISE_LINE"

		/// The metafields were not valid. 
		case invalidMetafields = "INVALID_METAFIELDS"

		/// The payment wasn't valid. 
		case invalidPayment = "INVALID_PAYMENT"

		/// Cannot update payment on an empty cart 
		case invalidPaymentEmptyCart = "INVALID_PAYMENT_EMPTY_CART"

		/// The given zip code is invalid for the provided country. 
		case invalidZipCodeForCountry = "INVALID_ZIP_CODE_FOR_COUNTRY"

		/// The given zip code is invalid for the provided province. 
		case invalidZipCodeForProvince = "INVALID_ZIP_CODE_FOR_PROVINCE"

		/// The input value should be less than the maximum value allowed. 
		case lessThan = "LESS_THAN"

		/// The quantity must be below the specified maximum for the item. 
		case maximumExceeded = "MAXIMUM_EXCEEDED"

		/// The quantity must be above the specified minimum for the item. 
		case minimumNotMet = "MINIMUM_NOT_MET"

		/// The customer access token is required when setting a company location. 
		case missingCustomerAccessToken = "MISSING_CUSTOMER_ACCESS_TOKEN"

		/// Missing discount code. 
		case missingDiscountCode = "MISSING_DISCOUNT_CODE"

		/// Missing note. 
		case missingNote = "MISSING_NOTE"

		/// The payment method is not supported. 
		case paymentMethodNotSupported = "PAYMENT_METHOD_NOT_SUPPORTED"

		/// The given province cannot be found. 
		case provinceNotFound = "PROVINCE_NOT_FOUND"

		/// A general error occurred during address validation. 
		case unspecifiedAddressError = "UNSPECIFIED_ADDRESS_ERROR"

		/// Validation failed. 
		case validationCustom = "VALIDATION_CUSTOM"

		/// The given zip code is unsupported. 
		case zipCodeNotSupported = "ZIP_CODE_NOT_SUPPORTED"

		case unknownValue = ""
	}
}

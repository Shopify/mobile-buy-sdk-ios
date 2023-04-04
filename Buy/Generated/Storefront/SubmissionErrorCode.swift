//
//  SubmissionErrorCode.swift
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
	/// The code of the error that occurred during cart submit for completion. 
	public enum SubmissionErrorCode: String {
		case buyerIdentityEmailIsInvalid = "BUYER_IDENTITY_EMAIL_IS_INVALID"

		case buyerIdentityEmailRequired = "BUYER_IDENTITY_EMAIL_REQUIRED"

		case buyerIdentityPhoneIsInvalid = "BUYER_IDENTITY_PHONE_IS_INVALID"

		case deliveryAddress1Invalid = "DELIVERY_ADDRESS1_INVALID"

		case deliveryAddress1Required = "DELIVERY_ADDRESS1_REQUIRED"

		case deliveryAddress1TooLong = "DELIVERY_ADDRESS1_TOO_LONG"

		case deliveryAddress2Invalid = "DELIVERY_ADDRESS2_INVALID"

		case deliveryAddress2Required = "DELIVERY_ADDRESS2_REQUIRED"

		case deliveryAddress2TooLong = "DELIVERY_ADDRESS2_TOO_LONG"

		case deliveryAddressRequired = "DELIVERY_ADDRESS_REQUIRED"

		case deliveryCityInvalid = "DELIVERY_CITY_INVALID"

		case deliveryCityRequired = "DELIVERY_CITY_REQUIRED"

		case deliveryCityTooLong = "DELIVERY_CITY_TOO_LONG"

		case deliveryCompanyInvalid = "DELIVERY_COMPANY_INVALID"

		case deliveryCompanyRequired = "DELIVERY_COMPANY_REQUIRED"

		case deliveryCompanyTooLong = "DELIVERY_COMPANY_TOO_LONG"

		case deliveryCountryRequired = "DELIVERY_COUNTRY_REQUIRED"

		case deliveryFirstNameInvalid = "DELIVERY_FIRST_NAME_INVALID"

		case deliveryFirstNameRequired = "DELIVERY_FIRST_NAME_REQUIRED"

		case deliveryFirstNameTooLong = "DELIVERY_FIRST_NAME_TOO_LONG"

		case deliveryInvalidPostalCodeForCountry = "DELIVERY_INVALID_POSTAL_CODE_FOR_COUNTRY"

		case deliveryInvalidPostalCodeForZone = "DELIVERY_INVALID_POSTAL_CODE_FOR_ZONE"

		case deliveryLastNameInvalid = "DELIVERY_LAST_NAME_INVALID"

		case deliveryLastNameRequired = "DELIVERY_LAST_NAME_REQUIRED"

		case deliveryLastNameTooLong = "DELIVERY_LAST_NAME_TOO_LONG"

		case deliveryNoDeliveryAvailable = "DELIVERY_NO_DELIVERY_AVAILABLE"

		case deliveryNoDeliveryAvailableForMerchandiseLine = "DELIVERY_NO_DELIVERY_AVAILABLE_FOR_MERCHANDISE_LINE"

		case deliveryOptionsPhoneNumberInvalid = "DELIVERY_OPTIONS_PHONE_NUMBER_INVALID"

		case deliveryOptionsPhoneNumberRequired = "DELIVERY_OPTIONS_PHONE_NUMBER_REQUIRED"

		case deliveryPhoneNumberInvalid = "DELIVERY_PHONE_NUMBER_INVALID"

		case deliveryPhoneNumberRequired = "DELIVERY_PHONE_NUMBER_REQUIRED"

		case deliveryPostalCodeInvalid = "DELIVERY_POSTAL_CODE_INVALID"

		case deliveryPostalCodeRequired = "DELIVERY_POSTAL_CODE_REQUIRED"

		case deliveryZoneNotFound = "DELIVERY_ZONE_NOT_FOUND"

		case deliveryZoneRequiredForCountry = "DELIVERY_ZONE_REQUIRED_FOR_COUNTRY"

		case error = "ERROR"

		case merchandiseLineLimitReached = "MERCHANDISE_LINE_LIMIT_REACHED"

		case merchandiseNotApplicable = "MERCHANDISE_NOT_APPLICABLE"

		case merchandiseNotEnoughStockAvailable = "MERCHANDISE_NOT_ENOUGH_STOCK_AVAILABLE"

		case merchandiseOutOfStock = "MERCHANDISE_OUT_OF_STOCK"

		case merchandiseProductNotPublished = "MERCHANDISE_PRODUCT_NOT_PUBLISHED"

		case noDeliveryGroupSelected = "NO_DELIVERY_GROUP_SELECTED"

		case paymentsAddress1Invalid = "PAYMENTS_ADDRESS1_INVALID"

		case paymentsAddress1Required = "PAYMENTS_ADDRESS1_REQUIRED"

		case paymentsAddress1TooLong = "PAYMENTS_ADDRESS1_TOO_LONG"

		case paymentsAddress2Invalid = "PAYMENTS_ADDRESS2_INVALID"

		case paymentsAddress2Required = "PAYMENTS_ADDRESS2_REQUIRED"

		case paymentsAddress2TooLong = "PAYMENTS_ADDRESS2_TOO_LONG"

		case paymentsBillingAddressZoneNotFound = "PAYMENTS_BILLING_ADDRESS_ZONE_NOT_FOUND"

		case paymentsBillingAddressZoneRequiredForCountry = "PAYMENTS_BILLING_ADDRESS_ZONE_REQUIRED_FOR_COUNTRY"

		case paymentsCityInvalid = "PAYMENTS_CITY_INVALID"

		case paymentsCityRequired = "PAYMENTS_CITY_REQUIRED"

		case paymentsCityTooLong = "PAYMENTS_CITY_TOO_LONG"

		case paymentsCompanyInvalid = "PAYMENTS_COMPANY_INVALID"

		case paymentsCompanyRequired = "PAYMENTS_COMPANY_REQUIRED"

		case paymentsCompanyTooLong = "PAYMENTS_COMPANY_TOO_LONG"

		case paymentsCountryRequired = "PAYMENTS_COUNTRY_REQUIRED"

		case paymentsCreditCardBaseExpired = "PAYMENTS_CREDIT_CARD_BASE_EXPIRED"

		case paymentsCreditCardBaseGatewayNotSupported = "PAYMENTS_CREDIT_CARD_BASE_GATEWAY_NOT_SUPPORTED"

		case paymentsCreditCardBaseInvalidStartDateOrIssueNumberForDebit = "PAYMENTS_CREDIT_CARD_BASE_INVALID_START_DATE_OR_ISSUE_NUMBER_FOR_DEBIT"

		case paymentsCreditCardBrandNotSupported = "PAYMENTS_CREDIT_CARD_BRAND_NOT_SUPPORTED"

		case paymentsCreditCardFirstNameBlank = "PAYMENTS_CREDIT_CARD_FIRST_NAME_BLANK"

		case paymentsCreditCardGeneric = "PAYMENTS_CREDIT_CARD_GENERIC"

		case paymentsCreditCardLastNameBlank = "PAYMENTS_CREDIT_CARD_LAST_NAME_BLANK"

		case paymentsCreditCardMonthInclusion = "PAYMENTS_CREDIT_CARD_MONTH_INCLUSION"

		case paymentsCreditCardNameInvalid = "PAYMENTS_CREDIT_CARD_NAME_INVALID"

		case paymentsCreditCardNumberInvalid = "PAYMENTS_CREDIT_CARD_NUMBER_INVALID"

		case paymentsCreditCardNumberInvalidFormat = "PAYMENTS_CREDIT_CARD_NUMBER_INVALID_FORMAT"

		case paymentsCreditCardSessionId = "PAYMENTS_CREDIT_CARD_SESSION_ID"

		case paymentsCreditCardVerificationValueBlank = "PAYMENTS_CREDIT_CARD_VERIFICATION_VALUE_BLANK"

		case paymentsCreditCardVerificationValueInvalidForCardType = "PAYMENTS_CREDIT_CARD_VERIFICATION_VALUE_INVALID_FOR_CARD_TYPE"

		case paymentsCreditCardYearExpired = "PAYMENTS_CREDIT_CARD_YEAR_EXPIRED"

		case paymentsCreditCardYearInvalidExpiryYear = "PAYMENTS_CREDIT_CARD_YEAR_INVALID_EXPIRY_YEAR"

		case paymentsFirstNameInvalid = "PAYMENTS_FIRST_NAME_INVALID"

		case paymentsFirstNameRequired = "PAYMENTS_FIRST_NAME_REQUIRED"

		case paymentsFirstNameTooLong = "PAYMENTS_FIRST_NAME_TOO_LONG"

		case paymentsInvalidPostalCodeForCountry = "PAYMENTS_INVALID_POSTAL_CODE_FOR_COUNTRY"

		case paymentsInvalidPostalCodeForZone = "PAYMENTS_INVALID_POSTAL_CODE_FOR_ZONE"

		case paymentsLastNameInvalid = "PAYMENTS_LAST_NAME_INVALID"

		case paymentsLastNameRequired = "PAYMENTS_LAST_NAME_REQUIRED"

		case paymentsLastNameTooLong = "PAYMENTS_LAST_NAME_TOO_LONG"

		case paymentsMethodRequired = "PAYMENTS_METHOD_REQUIRED"

		case paymentsMethodUnavailable = "PAYMENTS_METHOD_UNAVAILABLE"

		case paymentsPhoneNumberInvalid = "PAYMENTS_PHONE_NUMBER_INVALID"

		case paymentsPhoneNumberRequired = "PAYMENTS_PHONE_NUMBER_REQUIRED"

		case paymentsPostalCodeInvalid = "PAYMENTS_POSTAL_CODE_INVALID"

		case paymentsPostalCodeRequired = "PAYMENTS_POSTAL_CODE_REQUIRED"

		case paymentsShopifyPaymentsRequired = "PAYMENTS_SHOPIFY_PAYMENTS_REQUIRED"

		case paymentsUnacceptablePaymentAmount = "PAYMENTS_UNACCEPTABLE_PAYMENT_AMOUNT"

		case paymentsWalletContentMissing = "PAYMENTS_WALLET_CONTENT_MISSING"

		case taxesDeliveryGroupIdNotFound = "TAXES_DELIVERY_GROUP_ID_NOT_FOUND"

		case taxesLineIdNotFound = "TAXES_LINE_ID_NOT_FOUND"

		case taxesMustBeDefined = "TAXES_MUST_BE_DEFINED"

		case unknownValue = ""
	}
}

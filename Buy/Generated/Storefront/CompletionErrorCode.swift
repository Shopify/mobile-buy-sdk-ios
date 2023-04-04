//
//  CompletionErrorCode.swift
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
	/// The code of the error that occurred during a cart completion attempt. 
	public enum CompletionErrorCode: String {
		case error = "ERROR"

		case inventoryReservationError = "INVENTORY_RESERVATION_ERROR"

		case paymentAmountTooSmall = "PAYMENT_AMOUNT_TOO_SMALL"

		case paymentCallIssuer = "PAYMENT_CALL_ISSUER"

		case paymentCardDeclined = "PAYMENT_CARD_DECLINED"

		case paymentError = "PAYMENT_ERROR"

		case paymentGatewayNotEnabledError = "PAYMENT_GATEWAY_NOT_ENABLED_ERROR"

		case paymentInsufficientFunds = "PAYMENT_INSUFFICIENT_FUNDS"

		case paymentInvalidBillingAddress = "PAYMENT_INVALID_BILLING_ADDRESS"

		case paymentInvalidCreditCard = "PAYMENT_INVALID_CREDIT_CARD"

		case paymentInvalidCurrency = "PAYMENT_INVALID_CURRENCY"

		case paymentInvalidPaymentMethod = "PAYMENT_INVALID_PAYMENT_METHOD"

		case paymentTransientError = "PAYMENT_TRANSIENT_ERROR"

		case unknownValue = ""
	}
}

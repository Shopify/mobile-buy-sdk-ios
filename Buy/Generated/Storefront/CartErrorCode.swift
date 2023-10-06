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
		/// The input value is invalid. 
		case invalid = "INVALID"

		/// Delivery group was not found in cart. 
		case invalidDeliveryGroup = "INVALID_DELIVERY_GROUP"

		/// Delivery option was not valid. 
		case invalidDeliveryOption = "INVALID_DELIVERY_OPTION"

		/// Merchandise line was not found in cart. 
		case invalidMerchandiseLine = "INVALID_MERCHANDISE_LINE"

		/// The metafields were not valid. 
		case invalidMetafields = "INVALID_METAFIELDS"

		/// The payment wasn't valid. 
		case invalidPayment = "INVALID_PAYMENT"

		/// Cannot update payment on an empty cart 
		case invalidPaymentEmptyCart = "INVALID_PAYMENT_EMPTY_CART"

		/// The input value should be less than the maximum value allowed. 
		case lessThan = "LESS_THAN"

		/// Missing discount code. 
		case missingDiscountCode = "MISSING_DISCOUNT_CODE"

		/// Missing note. 
		case missingNote = "MISSING_NOTE"

		/// The payment method is not supported. 
		case paymentMethodNotSupported = "PAYMENT_METHOD_NOT_SUPPORTED"

		/// Validation failed. 
		case validationCustom = "VALIDATION_CUSTOM"

		case unknownValue = ""
	}
}

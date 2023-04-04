//
//  CartDirectPaymentMethodInput.swift
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
	/// The input fields for submitting direct payment method information for 
	/// checkout. 
	open class CartDirectPaymentMethodInput {
		/// The customer's billing address. 
		open var billingAddress: MailingAddressInput

		/// The session ID for the direct payment method used to create the payment. 
		open var sessionId: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - sessionId: The session ID for the direct payment method used to create the payment.
		///
		public static func create(billingAddress: MailingAddressInput, sessionId: String) -> CartDirectPaymentMethodInput {
			return CartDirectPaymentMethodInput(billingAddress: billingAddress, sessionId: sessionId)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - sessionId: The session ID for the direct payment method used to create the payment.
		///
		public init(billingAddress: MailingAddressInput, sessionId: String) {
			self.billingAddress = billingAddress
			self.sessionId = sessionId
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("sessionId:\(GraphQL.quoteString(input: sessionId))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

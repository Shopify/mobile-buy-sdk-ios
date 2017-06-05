//
//  TokenizedPaymentInput.swift
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
	/// Specifies the fields required to complete a checkout with a tokenized 
	/// payment. 
	open class TokenizedPaymentInput {
		/// The amount of the payment. 
		open var amount: Decimal

		/// A unique client generated key used to avoid duplicate charges. When a 
		/// duplicate payment is found, the original is returned instead of creating a 
		/// new one. 
		open var idempotencyKey: String

		/// The billing address for the payment. 
		open var billingAddress: MailingAddressInput

		/// The type of payment token. 
		open var type: String

		/// A simple string or JSON containing the required payment data for the 
		/// tokenized payment. 
		open var paymentData: String

		/// Executes the payment in test mode if possible. Defaults to `false`. 
		open var test: Bool?

		/// Public Hash Key used for AndroidPay payments only. 
		open var identifier: String?

		/// Creates the input object.
		///
		/// - parameters:
		///     - amount: The amount of the payment.
		///     - idempotencyKey: A unique client generated key used to avoid duplicate charges. When a duplicate payment is found, the original is returned instead of creating a new one.
		///     - billingAddress: The billing address for the payment.
		///     - type: The type of payment token.
		///     - paymentData: A simple string or JSON containing the required payment data for the tokenized payment.
		///     - test: Executes the payment in test mode if possible. Defaults to `false`.
		///     - identifier: Public Hash Key used for AndroidPay payments only.
		///
		public init(amount: Decimal, idempotencyKey: String, billingAddress: MailingAddressInput, type: String, paymentData: String, test: Bool? = nil, identifier: String? = nil) {
			self.amount = amount
			self.idempotencyKey = idempotencyKey
			self.billingAddress = billingAddress
			self.type = type
			self.paymentData = paymentData
			self.test = test
			self.identifier = identifier
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("amount:\(GraphQL.quoteString(input: "\(String(describing: amount))"))")

			fields.append("idempotencyKey:\(GraphQL.quoteString(input: idempotencyKey))")

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("type:\(GraphQL.quoteString(input: type))")

			fields.append("paymentData:\(GraphQL.quoteString(input: paymentData))")

			if let test = test {
				fields.append("test:\(test)")
			}

			if let identifier = identifier {
				fields.append("identifier:\(GraphQL.quoteString(input: identifier))")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

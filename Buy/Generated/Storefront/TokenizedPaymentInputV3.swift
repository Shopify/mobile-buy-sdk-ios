//
//  TokenizedPaymentInputV3.swift
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
	open class TokenizedPaymentInputV3 {
		/// The amount and currency of the payment. 
		open var paymentAmount: MoneyInput

		/// A unique client generated key used to avoid duplicate charges. When a 
		/// duplicate payment is found, the original is returned instead of creating a 
		/// new one. 
		open var idempotencyKey: String

		/// The billing address for the payment. 
		open var billingAddress: MailingAddressInput

		/// A simple string or JSON containing the required payment data for the 
		/// tokenized payment. 
		open var paymentData: String

		/// Whether to execute the payment in test mode, if possible. Test mode is not 
		/// supported in production stores. Defaults to `false`. 
		open var test: Input<Bool>

		/// Public Hash Key used for AndroidPay payments only. 
		open var identifier: Input<String>

		/// The type of payment token. 
		open var type: PaymentTokenType

		/// Creates the input object.
		///
		/// - parameters:
		///     - paymentAmount: The amount and currency of the payment.
		///     - idempotencyKey: A unique client generated key used to avoid duplicate charges. When a duplicate payment is found, the original is returned instead of creating a new one.
		///     - billingAddress: The billing address for the payment.
		///     - paymentData: A simple string or JSON containing the required payment data for the tokenized payment.
		///     - test: Whether to execute the payment in test mode, if possible. Test mode is not supported in production stores. Defaults to `false`.
		///     - identifier: Public Hash Key used for AndroidPay payments only.
		///     - type: The type of payment token.
		///
		public static func create(paymentAmount: MoneyInput, idempotencyKey: String, billingAddress: MailingAddressInput, paymentData: String, type: PaymentTokenType, test: Input<Bool> = .undefined, identifier: Input<String> = .undefined) -> TokenizedPaymentInputV3 {
			return TokenizedPaymentInputV3(paymentAmount: paymentAmount, idempotencyKey: idempotencyKey, billingAddress: billingAddress, paymentData: paymentData, type: type, test: test, identifier: identifier)
		}

		private init(paymentAmount: MoneyInput, idempotencyKey: String, billingAddress: MailingAddressInput, paymentData: String, type: PaymentTokenType, test: Input<Bool> = .undefined, identifier: Input<String> = .undefined) {
			self.paymentAmount = paymentAmount
			self.idempotencyKey = idempotencyKey
			self.billingAddress = billingAddress
			self.paymentData = paymentData
			self.test = test
			self.identifier = identifier
			self.type = type
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - paymentAmount: The amount and currency of the payment.
		///     - idempotencyKey: A unique client generated key used to avoid duplicate charges. When a duplicate payment is found, the original is returned instead of creating a new one.
		///     - billingAddress: The billing address for the payment.
		///     - paymentData: A simple string or JSON containing the required payment data for the tokenized payment.
		///     - test: Whether to execute the payment in test mode, if possible. Test mode is not supported in production stores. Defaults to `false`.
		///     - identifier: Public Hash Key used for AndroidPay payments only.
		///     - type: The type of payment token.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(paymentAmount: MoneyInput, idempotencyKey: String, billingAddress: MailingAddressInput, paymentData: String, type: PaymentTokenType, test: Bool? = nil, identifier: String? = nil) {
			self.init(paymentAmount: paymentAmount, idempotencyKey: idempotencyKey, billingAddress: billingAddress, paymentData: paymentData, type: type, test: test.orUndefined, identifier: identifier.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("paymentAmount:\(paymentAmount.serialize())")

			fields.append("idempotencyKey:\(GraphQL.quoteString(input: idempotencyKey))")

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("paymentData:\(GraphQL.quoteString(input: paymentData))")

			switch test {
				case .value(let test): 
				guard let test = test else {
					fields.append("test:null")
					break
				}
				fields.append("test:\(test)")
				case .undefined: break
			}

			switch identifier {
				case .value(let identifier): 
				guard let identifier = identifier else {
					fields.append("identifier:null")
					break
				}
				fields.append("identifier:\(GraphQL.quoteString(input: identifier))")
				case .undefined: break
			}

			fields.append("type:\(type.rawValue)")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

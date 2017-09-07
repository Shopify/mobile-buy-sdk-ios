//
//  CreditCardPaymentInput.swift
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
	/// Specifies the fields required to complete a checkout with a Shopify vaulted 
	/// credit card payment. 
	open class CreditCardPaymentInput {
		/// The amount of the payment. 
		open var amount: Decimal

		/// A unique client generated key used to avoid duplicate charges. When a 
		/// duplicate payment is found, the original is returned instead of creating a 
		/// new one. 
		open var idempotencyKey: String

		/// The billing address for the payment. 
		open var billingAddress: MailingAddressInput

		/// The ID returned by Shopify's Card Vault. 
		open var vaultId: String

		/// Executes the payment in test mode if possible. Defaults to `false`. 
		open var test: InputValue<Bool>

		/// Creates the input object.
		///
		/// - parameters:
		///     - amount: The amount of the payment.
		///     - idempotencyKey: A unique client generated key used to avoid duplicate charges. When a duplicate payment is found, the original is returned instead of creating a new one.
		///     - billingAddress: The billing address for the payment.
		///     - vaultId: The ID returned by Shopify's Card Vault.
		///     - test: Executes the payment in test mode if possible. Defaults to `false`.
		///
		public init(amount: Decimal, idempotencyKey: String, billingAddress: MailingAddressInput, vaultId: String, test: InputValue<Bool> = .undefined) {
			self.amount = amount
			self.idempotencyKey = idempotencyKey
			self.billingAddress = billingAddress
			self.vaultId = vaultId
			self.test = test
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("amount:\(GraphQL.quoteString(input: "\(String(describing: amount))"))")

			fields.append("idempotencyKey:\(GraphQL.quoteString(input: idempotencyKey))")

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("vaultId:\(GraphQL.quoteString(input: vaultId))")

			switch test {
				case .some(let test): fields.append("test:\(test)")
				case .null: fields.append("test:null")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

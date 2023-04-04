//
//  ApplePayWalletContentInput.swift
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
	/// The input fields for submitting Apple Pay payment method information for 
	/// checkout. 
	open class ApplePayWalletContentInput {
		/// The customer's billing address. 
		open var billingAddress: MailingAddressInput

		/// The data for the Apple Pay wallet. 
		open var data: String

		/// The header data for the Apple Pay wallet. 
		open var header: ApplePayWalletHeaderInput

		/// The last digits of the card used to create the payment. 
		open var lastDigits: Input<String>

		/// The signature for the Apple Pay wallet. 
		open var signature: String

		/// The version for the Apple Pay wallet. 
		open var version: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - data: The data for the Apple Pay wallet.
		///     - header: The header data for the Apple Pay wallet.
		///     - lastDigits: The last digits of the card used to create the payment.
		///     - signature: The signature for the Apple Pay wallet.
		///     - version: The version for the Apple Pay wallet.
		///
		public static func create(billingAddress: MailingAddressInput, data: String, header: ApplePayWalletHeaderInput, signature: String, version: String, lastDigits: Input<String> = .undefined) -> ApplePayWalletContentInput {
			return ApplePayWalletContentInput(billingAddress: billingAddress, data: data, header: header, signature: signature, version: version, lastDigits: lastDigits)
		}

		private init(billingAddress: MailingAddressInput, data: String, header: ApplePayWalletHeaderInput, signature: String, version: String, lastDigits: Input<String> = .undefined) {
			self.billingAddress = billingAddress
			self.data = data
			self.header = header
			self.lastDigits = lastDigits
			self.signature = signature
			self.version = version
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - data: The data for the Apple Pay wallet.
		///     - header: The header data for the Apple Pay wallet.
		///     - lastDigits: The last digits of the card used to create the payment.
		///     - signature: The signature for the Apple Pay wallet.
		///     - version: The version for the Apple Pay wallet.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(billingAddress: MailingAddressInput, data: String, header: ApplePayWalletHeaderInput, signature: String, version: String, lastDigits: String? = nil) {
			self.init(billingAddress: billingAddress, data: data, header: header, signature: signature, version: version, lastDigits: lastDigits.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("data:\(GraphQL.quoteString(input: data))")

			fields.append("header:\(header.serialize())")

			switch lastDigits {
				case .value(let lastDigits): 
				guard let lastDigits = lastDigits else {
					fields.append("lastDigits:null")
					break
				}
				fields.append("lastDigits:\(GraphQL.quoteString(input: lastDigits))")
				case .undefined: break
			}

			fields.append("signature:\(GraphQL.quoteString(input: signature))")

			fields.append("version:\(GraphQL.quoteString(input: version))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

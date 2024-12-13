//
//  ShopPayWalletContentInput.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// The input fields for submitting Shop Pay payment method information for 
	/// checkout. 
	open class ShopPayWalletContentInput {
		/// The customer's billing address. 
		open var billingAddress: MailingAddressInput

		/// Session token for transaction. 
		open var sessionToken: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - sessionToken: Session token for transaction.
		///
		public static func create(billingAddress: MailingAddressInput, sessionToken: String) -> ShopPayWalletContentInput {
			return ShopPayWalletContentInput(billingAddress: billingAddress, sessionToken: sessionToken)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - sessionToken: Session token for transaction.
		///
		public init(billingAddress: MailingAddressInput, sessionToken: String) {
			self.billingAddress = billingAddress
			self.sessionToken = sessionToken
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("billingAddress:\(billingAddress.serialize())")

			fields.append("sessionToken:\(GraphQL.quoteString(input: sessionToken))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

//
//  CustomerActivateInput.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// The input fields to activate a customer. 
	open class CustomerActivateInput {
		/// The activation token required to activate the customer. 
		open var activationToken: String

		/// New password that will be set during activation. 
		open var password: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - activationToken: The activation token required to activate the customer.
		///     - password: New password that will be set during activation.
		///
		public static func create(activationToken: String, password: String) -> CustomerActivateInput {
			return CustomerActivateInput(activationToken: activationToken, password: password)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - activationToken: The activation token required to activate the customer.
		///     - password: New password that will be set during activation.
		///
		public init(activationToken: String, password: String) {
			self.activationToken = activationToken
			self.password = password
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("activationToken:\(GraphQL.quoteString(input: activationToken))")

			fields.append("password:\(GraphQL.quoteString(input: password))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

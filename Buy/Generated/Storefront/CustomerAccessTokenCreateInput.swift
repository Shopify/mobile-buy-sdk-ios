//
//  CustomerAccessTokenCreateInput.swift
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
	/// Specifies the input fields required to create a customer access token. 
	open class CustomerAccessTokenCreateInput {
		/// The email associated to the customer. 
		open var email: String

		/// The login password to be used by the customer. 
		open var password: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email associated to the customer.
		///     - password: The login password to be used by the customer.
		///
		public init(email: String, password: String) {
			self.email = email
			self.password = password
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("email:\(GraphQL.quoteString(input: email))")

			fields.append("password:\(GraphQL.quoteString(input: password))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

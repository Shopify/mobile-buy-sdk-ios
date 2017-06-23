//
//  CustomerUpdateInput.swift
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
	/// Specifies the fields required to update the Customer information. 
	open class CustomerUpdateInput {
		/// The customer’s first name. 
		open var firstName: String?

		/// The customer’s last name. 
		open var lastName: String?

		/// The customer’s email. 
		open var email: String?

		/// The customer’s phone number. 
		open var phone: String?

		/// The login password used by the customer. 
		open var password: String?

		/// Indicates whether the customer has consented to be sent marketing material 
		/// via email. 
		open var acceptsMarketing: Bool?

		/// Creates the input object.
		///
		/// - parameters:
		///     - firstName: The customer’s first name.
		///     - lastName: The customer’s last name.
		///     - email: The customer’s email.
		///     - phone: The customer’s phone number.
		///     - password: The login password used by the customer.
		///     - acceptsMarketing: Indicates whether the customer has consented to be sent marketing material via email.
		///
		public init(firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, password: String? = nil, acceptsMarketing: Bool? = nil) {
			self.firstName = firstName
			self.lastName = lastName
			self.email = email
			self.phone = phone
			self.password = password
			self.acceptsMarketing = acceptsMarketing
		}

		internal func serialize() -> String {
			var fields: [String] = []

			if let firstName = firstName {
				fields.append("firstName:\(GraphQL.quoteString(input: firstName))")
			}

			if let lastName = lastName {
				fields.append("lastName:\(GraphQL.quoteString(input: lastName))")
			}

			if let email = email {
				fields.append("email:\(GraphQL.quoteString(input: email))")
			}

			if let phone = phone {
				fields.append("phone:\(GraphQL.quoteString(input: phone))")
			}

			if let password = password {
				fields.append("password:\(GraphQL.quoteString(input: password))")
			}

			if let acceptsMarketing = acceptsMarketing {
				fields.append("acceptsMarketing:\(acceptsMarketing)")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

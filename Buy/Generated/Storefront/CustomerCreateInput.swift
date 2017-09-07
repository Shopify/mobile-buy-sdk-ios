//
//  CustomerCreateInput.swift
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
	/// Specifies the fields required to create a new Customer. 
	open class CustomerCreateInput {
		/// The customer’s first name. 
		open var firstName: InputValue<String>

		/// The customer’s last name. 
		open var lastName: InputValue<String>

		/// The customer’s email. 
		open var email: String

		/// The customer’s phone number. 
		open var phone: InputValue<String>

		/// The login password used by the customer. 
		open var password: String

		/// Indicates whether the customer has consented to be sent marketing material 
		/// via email. 
		open var acceptsMarketing: InputValue<Bool>

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
		public init(email: String, password: String, firstName: InputValue<String> = .undefined, lastName: InputValue<String> = .undefined, phone: InputValue<String> = .undefined, acceptsMarketing: InputValue<Bool> = .undefined) {
			self.firstName = firstName
			self.lastName = lastName
			self.email = email
			self.phone = phone
			self.password = password
			self.acceptsMarketing = acceptsMarketing
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch firstName {
				case .some(let firstName): fields.append("firstName:\(GraphQL.quoteString(input: firstName))")
				case .null: fields.append("firstName:null")
				case .undefined: break
			}

			switch lastName {
				case .some(let lastName): fields.append("lastName:\(GraphQL.quoteString(input: lastName))")
				case .null: fields.append("lastName:null")
				case .undefined: break
			}

			fields.append("email:\(GraphQL.quoteString(input: email))")

			switch phone {
				case .some(let phone): fields.append("phone:\(GraphQL.quoteString(input: phone))")
				case .null: fields.append("phone:null")
				case .undefined: break
			}

			fields.append("password:\(GraphQL.quoteString(input: password))")

			switch acceptsMarketing {
				case .some(let acceptsMarketing): fields.append("acceptsMarketing:\(acceptsMarketing)")
				case .null: fields.append("acceptsMarketing:null")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

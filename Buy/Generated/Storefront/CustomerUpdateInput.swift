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
		open var firstName: Input<String>

		/// The customer’s last name. 
		open var lastName: Input<String>

		/// The customer’s email. 
		open var email: Input<String>

		/// A unique phone number for the customer. Formatted using E.164 standard. For 
		/// example, _+16135551111_. To remove the phone number, specify `null`. 
		open var phone: Input<String>

		/// The login password used by the customer. 
		open var password: Input<String>

		/// Indicates whether the customer has consented to be sent marketing material 
		/// via email. 
		open var acceptsMarketing: Input<Bool>

		/// Creates the input object.
		///
		/// - parameters:
		///     - firstName: The customer’s first name.
		///     - lastName: The customer’s last name.
		///     - email: The customer’s email.
		///     - phone: A unique phone number for the customer.  Formatted using E.164 standard. For example, _+16135551111_. To remove the phone number, specify `null`. 
		///     - password: The login password used by the customer.
		///     - acceptsMarketing: Indicates whether the customer has consented to be sent marketing material via email.
		///
		public static func create(firstName: Input<String> = .undefined, lastName: Input<String> = .undefined, email: Input<String> = .undefined, phone: Input<String> = .undefined, password: Input<String> = .undefined, acceptsMarketing: Input<Bool> = .undefined) -> CustomerUpdateInput {
			return CustomerUpdateInput(firstName: firstName, lastName: lastName, email: email, phone: phone, password: password, acceptsMarketing: acceptsMarketing)
		}

		private init(firstName: Input<String> = .undefined, lastName: Input<String> = .undefined, email: Input<String> = .undefined, phone: Input<String> = .undefined, password: Input<String> = .undefined, acceptsMarketing: Input<Bool> = .undefined) {
			self.firstName = firstName
			self.lastName = lastName
			self.email = email
			self.phone = phone
			self.password = password
			self.acceptsMarketing = acceptsMarketing
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - firstName: The customer’s first name.
		///     - lastName: The customer’s last name.
		///     - email: The customer’s email.
		///     - phone: A unique phone number for the customer.  Formatted using E.164 standard. For example, _+16135551111_. To remove the phone number, specify `null`. 
		///     - password: The login password used by the customer.
		///     - acceptsMarketing: Indicates whether the customer has consented to be sent marketing material via email.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(firstName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, password: String? = nil, acceptsMarketing: Bool? = nil) {
			self.init(firstName: firstName.orUndefined, lastName: lastName.orUndefined, email: email.orUndefined, phone: phone.orUndefined, password: password.orUndefined, acceptsMarketing: acceptsMarketing.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch firstName {
				case .value(let firstName): 
				guard let firstName = firstName else {
					fields.append("firstName:null")
					break
				}
				fields.append("firstName:\(GraphQL.quoteString(input: firstName))")
				case .undefined: break
			}

			switch lastName {
				case .value(let lastName): 
				guard let lastName = lastName else {
					fields.append("lastName:null")
					break
				}
				fields.append("lastName:\(GraphQL.quoteString(input: lastName))")
				case .undefined: break
			}

			switch email {
				case .value(let email): 
				guard let email = email else {
					fields.append("email:null")
					break
				}
				fields.append("email:\(GraphQL.quoteString(input: email))")
				case .undefined: break
			}

			switch phone {
				case .value(let phone): 
				guard let phone = phone else {
					fields.append("phone:null")
					break
				}
				fields.append("phone:\(GraphQL.quoteString(input: phone))")
				case .undefined: break
			}

			switch password {
				case .value(let password): 
				guard let password = password else {
					fields.append("password:null")
					break
				}
				fields.append("password:\(GraphQL.quoteString(input: password))")
				case .undefined: break
			}

			switch acceptsMarketing {
				case .value(let acceptsMarketing): 
				guard let acceptsMarketing = acceptsMarketing else {
					fields.append("acceptsMarketing:null")
					break
				}
				fields.append("acceptsMarketing:\(acceptsMarketing)")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

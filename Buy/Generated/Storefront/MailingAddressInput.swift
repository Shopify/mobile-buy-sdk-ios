//
//  MailingAddressInput.swift
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
	/// Specifies the fields accepted to create or update a mailing address. 
	open class MailingAddressInput {
		open var address1: String?

		open var address2: String?

		open var city: String?

		open var company: String?

		open var country: String?

		open var firstName: String?

		open var lastName: String?

		open var phone: String?

		open var province: String?

		open var zip: String?

		/// Creates the input object.
		///
		/// - parameters:
		///     - address1: No description
		///     - address2: No description
		///     - city: No description
		///     - company: No description
		///     - country: No description
		///     - firstName: No description
		///     - lastName: No description
		///     - phone: No description
		///     - province: No description
		///     - zip: No description
		///
		public init(address1: String? = nil, address2: String? = nil, city: String? = nil, company: String? = nil, country: String? = nil, firstName: String? = nil, lastName: String? = nil, phone: String? = nil, province: String? = nil, zip: String? = nil) {
			self.address1 = address1
			self.address2 = address2
			self.city = city
			self.company = company
			self.country = country
			self.firstName = firstName
			self.lastName = lastName
			self.phone = phone
			self.province = province
			self.zip = zip
		}

		internal func serialize() -> String {
			var fields: [String] = []

			if let address1 = address1 {
				fields.append("address1:\(GraphQL.quoteString(input: address1))")
			}

			if let address2 = address2 {
				fields.append("address2:\(GraphQL.quoteString(input: address2))")
			}

			if let city = city {
				fields.append("city:\(GraphQL.quoteString(input: city))")
			}

			if let company = company {
				fields.append("company:\(GraphQL.quoteString(input: company))")
			}

			if let country = country {
				fields.append("country:\(GraphQL.quoteString(input: country))")
			}

			if let firstName = firstName {
				fields.append("firstName:\(GraphQL.quoteString(input: firstName))")
			}

			if let lastName = lastName {
				fields.append("lastName:\(GraphQL.quoteString(input: lastName))")
			}

			if let phone = phone {
				fields.append("phone:\(GraphQL.quoteString(input: phone))")
			}

			if let province = province {
				fields.append("province:\(GraphQL.quoteString(input: province))")
			}

			if let zip = zip {
				fields.append("zip:\(GraphQL.quoteString(input: zip))")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

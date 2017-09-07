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
		open var address1: InputValue<String>

		open var address2: InputValue<String>

		open var city: InputValue<String>

		open var company: InputValue<String>

		open var country: InputValue<String>

		open var firstName: InputValue<String>

		open var lastName: InputValue<String>

		open var phone: InputValue<String>

		open var province: InputValue<String>

		open var zip: InputValue<String>

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
		public init(address1: InputValue<String> = .undefined, address2: InputValue<String> = .undefined, city: InputValue<String> = .undefined, company: InputValue<String> = .undefined, country: InputValue<String> = .undefined, firstName: InputValue<String> = .undefined, lastName: InputValue<String> = .undefined, phone: InputValue<String> = .undefined, province: InputValue<String> = .undefined, zip: InputValue<String> = .undefined) {
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

			switch address1 {
				case .some(let address1): fields.append("address1:\(GraphQL.quoteString(input: address1))")
				case .null: fields.append("address1:null")
				case .undefined: break
			}

			switch address2 {
				case .some(let address2): fields.append("address2:\(GraphQL.quoteString(input: address2))")
				case .null: fields.append("address2:null")
				case .undefined: break
			}

			switch city {
				case .some(let city): fields.append("city:\(GraphQL.quoteString(input: city))")
				case .null: fields.append("city:null")
				case .undefined: break
			}

			switch company {
				case .some(let company): fields.append("company:\(GraphQL.quoteString(input: company))")
				case .null: fields.append("company:null")
				case .undefined: break
			}

			switch country {
				case .some(let country): fields.append("country:\(GraphQL.quoteString(input: country))")
				case .null: fields.append("country:null")
				case .undefined: break
			}

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

			switch phone {
				case .some(let phone): fields.append("phone:\(GraphQL.quoteString(input: phone))")
				case .null: fields.append("phone:null")
				case .undefined: break
			}

			switch province {
				case .some(let province): fields.append("province:\(GraphQL.quoteString(input: province))")
				case .null: fields.append("province:null")
				case .undefined: break
			}

			switch zip {
				case .some(let zip): fields.append("zip:\(GraphQL.quoteString(input: zip))")
				case .null: fields.append("zip:null")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

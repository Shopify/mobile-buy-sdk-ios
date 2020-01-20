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
		/// The first line of the address. Typically the street address or PO Box 
		/// number. 
		open var address1: Input<String>

		/// The second line of the address. Typically the number of the apartment, 
		/// suite, or unit. 
		open var address2: Input<String>

		/// The name of the city, district, village, or town. 
		open var city: Input<String>

		/// The name of the customer's company or organization. 
		open var company: Input<String>

		/// The name of the country. 
		open var country: Input<String>

		/// The first name of the customer. 
		open var firstName: Input<String>

		/// The last name of the customer. 
		open var lastName: Input<String>

		/// A unique phone number for the customer. Formatted using E.164 standard. For 
		/// example, _+16135551111_. 
		open var phone: Input<String>

		/// The region of the address, such as the province, state, or district. 
		open var province: Input<String>

		/// The zip or postal code of the address. 
		open var zip: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - address1: The first line of the address. Typically the street address or PO Box number. 
		///     - address2: The second line of the address. Typically the number of the apartment, suite, or unit. 
		///     - city: The name of the city, district, village, or town. 
		///     - company: The name of the customer's company or organization. 
		///     - country: The name of the country.
		///     - firstName: The first name of the customer.
		///     - lastName: The last name of the customer.
		///     - phone: A unique phone number for the customer.  Formatted using E.164 standard. For example, _+16135551111_. 
		///     - province: The region of the address, such as the province, state, or district.
		///     - zip: The zip or postal code of the address.
		///
		public static func create(address1: Input<String> = .undefined, address2: Input<String> = .undefined, city: Input<String> = .undefined, company: Input<String> = .undefined, country: Input<String> = .undefined, firstName: Input<String> = .undefined, lastName: Input<String> = .undefined, phone: Input<String> = .undefined, province: Input<String> = .undefined, zip: Input<String> = .undefined) -> MailingAddressInput {
			return MailingAddressInput(address1: address1, address2: address2, city: city, company: company, country: country, firstName: firstName, lastName: lastName, phone: phone, province: province, zip: zip)
		}

		private init(address1: Input<String> = .undefined, address2: Input<String> = .undefined, city: Input<String> = .undefined, company: Input<String> = .undefined, country: Input<String> = .undefined, firstName: Input<String> = .undefined, lastName: Input<String> = .undefined, phone: Input<String> = .undefined, province: Input<String> = .undefined, zip: Input<String> = .undefined) {
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

		/// Creates the input object.
		///
		/// - parameters:
		///     - address1: The first line of the address. Typically the street address or PO Box number. 
		///     - address2: The second line of the address. Typically the number of the apartment, suite, or unit. 
		///     - city: The name of the city, district, village, or town. 
		///     - company: The name of the customer's company or organization. 
		///     - country: The name of the country.
		///     - firstName: The first name of the customer.
		///     - lastName: The last name of the customer.
		///     - phone: A unique phone number for the customer.  Formatted using E.164 standard. For example, _+16135551111_. 
		///     - province: The region of the address, such as the province, state, or district.
		///     - zip: The zip or postal code of the address.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(address1: String? = nil, address2: String? = nil, city: String? = nil, company: String? = nil, country: String? = nil, firstName: String? = nil, lastName: String? = nil, phone: String? = nil, province: String? = nil, zip: String? = nil) {
			self.init(address1: address1.orUndefined, address2: address2.orUndefined, city: city.orUndefined, company: company.orUndefined, country: country.orUndefined, firstName: firstName.orUndefined, lastName: lastName.orUndefined, phone: phone.orUndefined, province: province.orUndefined, zip: zip.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch address1 {
				case .value(let address1): 
				guard let address1 = address1 else {
					fields.append("address1:null")
					break
				}
				fields.append("address1:\(GraphQL.quoteString(input: address1))")
				case .undefined: break
			}

			switch address2 {
				case .value(let address2): 
				guard let address2 = address2 else {
					fields.append("address2:null")
					break
				}
				fields.append("address2:\(GraphQL.quoteString(input: address2))")
				case .undefined: break
			}

			switch city {
				case .value(let city): 
				guard let city = city else {
					fields.append("city:null")
					break
				}
				fields.append("city:\(GraphQL.quoteString(input: city))")
				case .undefined: break
			}

			switch company {
				case .value(let company): 
				guard let company = company else {
					fields.append("company:null")
					break
				}
				fields.append("company:\(GraphQL.quoteString(input: company))")
				case .undefined: break
			}

			switch country {
				case .value(let country): 
				guard let country = country else {
					fields.append("country:null")
					break
				}
				fields.append("country:\(GraphQL.quoteString(input: country))")
				case .undefined: break
			}

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

			switch phone {
				case .value(let phone): 
				guard let phone = phone else {
					fields.append("phone:null")
					break
				}
				fields.append("phone:\(GraphQL.quoteString(input: phone))")
				case .undefined: break
			}

			switch province {
				case .value(let province): 
				guard let province = province else {
					fields.append("province:null")
					break
				}
				fields.append("province:\(GraphQL.quoteString(input: province))")
				case .undefined: break
			}

			switch zip {
				case .value(let zip): 
				guard let zip = zip else {
					fields.append("zip:null")
					break
				}
				fields.append("zip:\(GraphQL.quoteString(input: zip))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

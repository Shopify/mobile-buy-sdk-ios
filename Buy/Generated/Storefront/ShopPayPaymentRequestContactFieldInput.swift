//
//  ShopPayPaymentRequestContactFieldInput.swift
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
	/// The input fields to create a contact field. This input type has been 
	/// depreciated now that shipping_address is pulled from the payment_method. 
	open class ShopPayPaymentRequestContactFieldInput {
		/// The country of the contact field. 
		open var countryCode: Input<String>

		/// The postal code of the contact field. 
		open var postalCode: Input<String>

		/// The province of the contact field. 
		open var provinceCode: Input<String>

		/// The city of the contact field. 
		open var city: Input<String>

		/// The first name of the contact field. 
		open var firstName: Input<String>

		/// The first name of the contact field. 
		open var lastName: Input<String>

		/// The first address line of the contact field. 
		open var address1: Input<String>

		/// The second address line of the contact field. 
		open var address2: Input<String>

		/// The phone number of the contact field. 
		open var phone: Input<String>

		/// The email of the contact field. 
		open var email: Input<String>

		/// The company name of the contact field. 
		open var companyName: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - countryCode: The country of the contact field.
		///     - postalCode: The postal code of the contact field.
		///     - provinceCode: The province of the contact field.
		///     - city: The city of the contact field.
		///     - firstName: The first name of the contact field.
		///     - lastName: The first name of the contact field.
		///     - address1: The first address line of the contact field.
		///     - address2: The second address line of the contact field.
		///     - phone: The phone number of the contact field.
		///     - email: The email of the contact field.
		///     - companyName: The company name of the contact field.
		///
		public static func create(countryCode: Input<String> = .undefined, postalCode: Input<String> = .undefined, provinceCode: Input<String> = .undefined, city: Input<String> = .undefined, firstName: Input<String> = .undefined, lastName: Input<String> = .undefined, address1: Input<String> = .undefined, address2: Input<String> = .undefined, phone: Input<String> = .undefined, email: Input<String> = .undefined, companyName: Input<String> = .undefined) -> ShopPayPaymentRequestContactFieldInput {
			return ShopPayPaymentRequestContactFieldInput(countryCode: countryCode, postalCode: postalCode, provinceCode: provinceCode, city: city, firstName: firstName, lastName: lastName, address1: address1, address2: address2, phone: phone, email: email, companyName: companyName)
		}

		private init(countryCode: Input<String> = .undefined, postalCode: Input<String> = .undefined, provinceCode: Input<String> = .undefined, city: Input<String> = .undefined, firstName: Input<String> = .undefined, lastName: Input<String> = .undefined, address1: Input<String> = .undefined, address2: Input<String> = .undefined, phone: Input<String> = .undefined, email: Input<String> = .undefined, companyName: Input<String> = .undefined) {
			self.countryCode = countryCode
			self.postalCode = postalCode
			self.provinceCode = provinceCode
			self.city = city
			self.firstName = firstName
			self.lastName = lastName
			self.address1 = address1
			self.address2 = address2
			self.phone = phone
			self.email = email
			self.companyName = companyName
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - countryCode: The country of the contact field.
		///     - postalCode: The postal code of the contact field.
		///     - provinceCode: The province of the contact field.
		///     - city: The city of the contact field.
		///     - firstName: The first name of the contact field.
		///     - lastName: The first name of the contact field.
		///     - address1: The first address line of the contact field.
		///     - address2: The second address line of the contact field.
		///     - phone: The phone number of the contact field.
		///     - email: The email of the contact field.
		///     - companyName: The company name of the contact field.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(countryCode: String? = nil, postalCode: String? = nil, provinceCode: String? = nil, city: String? = nil, firstName: String? = nil, lastName: String? = nil, address1: String? = nil, address2: String? = nil, phone: String? = nil, email: String? = nil, companyName: String? = nil) {
			self.init(countryCode: countryCode.orUndefined, postalCode: postalCode.orUndefined, provinceCode: provinceCode.orUndefined, city: city.orUndefined, firstName: firstName.orUndefined, lastName: lastName.orUndefined, address1: address1.orUndefined, address2: address2.orUndefined, phone: phone.orUndefined, email: email.orUndefined, companyName: companyName.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch countryCode {
				case .value(let countryCode):
				guard let countryCode = countryCode else {
					fields.append("countryCode:null")
					break
				}
				fields.append("countryCode:\(GraphQL.quoteString(input: countryCode))")
				case .undefined: break
			}

			switch postalCode {
				case .value(let postalCode):
				guard let postalCode = postalCode else {
					fields.append("postalCode:null")
					break
				}
				fields.append("postalCode:\(GraphQL.quoteString(input: postalCode))")
				case .undefined: break
			}

			switch provinceCode {
				case .value(let provinceCode):
				guard let provinceCode = provinceCode else {
					fields.append("provinceCode:null")
					break
				}
				fields.append("provinceCode:\(GraphQL.quoteString(input: provinceCode))")
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

			switch phone {
				case .value(let phone):
				guard let phone = phone else {
					fields.append("phone:null")
					break
				}
				fields.append("phone:\(GraphQL.quoteString(input: phone))")
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

			switch companyName {
				case .value(let companyName):
				guard let companyName = companyName else {
					fields.append("companyName:null")
					break
				}
				fields.append("companyName:\(GraphQL.quoteString(input: companyName))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

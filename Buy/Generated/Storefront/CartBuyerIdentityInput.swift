//
//  CartBuyerIdentityInput.swift
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
	/// Specifies the input fields to update the buyer information associated with 
	/// a cart. Buyer identity is used to determine [international 
	/// pricing](https://shopify.dev/api/examples/international-pricing#create-a-checkout) 
	/// and should match the customer's shipping address. 
	open class CartBuyerIdentityInput {
		/// The email address of the buyer that is interacting with the cart. 
		open var email: Input<String>

		/// The phone number of the buyer that is interacting with the cart. 
		open var phone: Input<String>

		/// The country where the buyer is located. 
		open var countryCode: Input<CountryCode>

		/// The access token used to identify the customer associated with the cart. 
		open var customerAccessToken: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email address of the buyer that is interacting with the cart.
		///     - phone: The phone number of the buyer that is interacting with the cart.
		///     - countryCode: The country where the buyer is located.
		///     - customerAccessToken: The access token used to identify the customer associated with the cart.
		///
		public static func create(email: Input<String> = .undefined, phone: Input<String> = .undefined, countryCode: Input<CountryCode> = .undefined, customerAccessToken: Input<String> = .undefined) -> CartBuyerIdentityInput {
			return CartBuyerIdentityInput(email: email, phone: phone, countryCode: countryCode, customerAccessToken: customerAccessToken)
		}

		private init(email: Input<String> = .undefined, phone: Input<String> = .undefined, countryCode: Input<CountryCode> = .undefined, customerAccessToken: Input<String> = .undefined) {
			self.email = email
			self.phone = phone
			self.countryCode = countryCode
			self.customerAccessToken = customerAccessToken
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email address of the buyer that is interacting with the cart.
		///     - phone: The phone number of the buyer that is interacting with the cart.
		///     - countryCode: The country where the buyer is located.
		///     - customerAccessToken: The access token used to identify the customer associated with the cart.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(email: String? = nil, phone: String? = nil, countryCode: CountryCode? = nil, customerAccessToken: String? = nil) {
			self.init(email: email.orUndefined, phone: phone.orUndefined, countryCode: countryCode.orUndefined, customerAccessToken: customerAccessToken.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

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

			switch countryCode {
				case .value(let countryCode): 
				guard let countryCode = countryCode else {
					fields.append("countryCode:null")
					break
				}
				fields.append("countryCode:\(countryCode.rawValue)")
				case .undefined: break
			}

			switch customerAccessToken {
				case .value(let customerAccessToken): 
				guard let customerAccessToken = customerAccessToken else {
					fields.append("customerAccessToken:null")
					break
				}
				fields.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

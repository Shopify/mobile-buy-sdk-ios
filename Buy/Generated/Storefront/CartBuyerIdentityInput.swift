//
//  CartBuyerIdentityInput.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing) 
	/// and should match the customer's shipping address. 
	open class CartBuyerIdentityInput {
		/// The email address of the buyer that is interacting with the cart. 
		open var email: Input<String>

		/// The phone number of the buyer that is interacting with the cart. 
		open var phone: Input<String>

		/// The company location of the buyer that is interacting with the cart. 
		open var companyLocationId: Input<GraphQL.ID>

		/// The country where the buyer is located. 
		open var countryCode: Input<CountryCode>

		/// The access token used to identify the customer associated with the cart. 
		open var customerAccessToken: Input<String>

		/// An ordered set of delivery addresses tied to the buyer that is interacting 
		/// with the cart. The rank of the preferences is determined by the order of 
		/// the addresses in the array. Preferences can be used to populate relevant 
		/// fields in the checkout flow. The input must not contain more than `250` 
		/// values. 
		open var deliveryAddressPreferences: Input<[DeliveryAddressInput]>

		/// A set of preferences tied to the buyer interacting with the cart. 
		/// Preferences are used to prefill fields in at checkout to streamline 
		/// information collection. Preferences are not synced back to the cart if they 
		/// are overwritten. 
		open var preferences: Input<CartPreferencesInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email address of the buyer that is interacting with the cart.
		///     - phone: The phone number of the buyer that is interacting with the cart.
		///     - companyLocationId: The company location of the buyer that is interacting with the cart.
		///     - countryCode: The country where the buyer is located.
		///     - customerAccessToken: The access token used to identify the customer associated with the cart.
		///     - deliveryAddressPreferences: An ordered set of delivery addresses tied to the buyer that is interacting with the cart. The rank of the preferences is determined by the order of the addresses in the array. Preferences can be used to populate relevant fields in the checkout flow.  The input must not contain more than `250` values.
		///     - preferences: A set of preferences tied to the buyer interacting with the cart. Preferences are used to prefill fields in at checkout to streamline information collection.  Preferences are not synced back to the cart if they are overwritten. 
		///
		public static func create(email: Input<String> = .undefined, phone: Input<String> = .undefined, companyLocationId: Input<GraphQL.ID> = .undefined, countryCode: Input<CountryCode> = .undefined, customerAccessToken: Input<String> = .undefined, deliveryAddressPreferences: Input<[DeliveryAddressInput]> = .undefined, preferences: Input<CartPreferencesInput> = .undefined) -> CartBuyerIdentityInput {
			return CartBuyerIdentityInput(email: email, phone: phone, companyLocationId: companyLocationId, countryCode: countryCode, customerAccessToken: customerAccessToken, deliveryAddressPreferences: deliveryAddressPreferences, preferences: preferences)
		}

		private init(email: Input<String> = .undefined, phone: Input<String> = .undefined, companyLocationId: Input<GraphQL.ID> = .undefined, countryCode: Input<CountryCode> = .undefined, customerAccessToken: Input<String> = .undefined, deliveryAddressPreferences: Input<[DeliveryAddressInput]> = .undefined, preferences: Input<CartPreferencesInput> = .undefined) {
			self.email = email
			self.phone = phone
			self.companyLocationId = companyLocationId
			self.countryCode = countryCode
			self.customerAccessToken = customerAccessToken
			self.deliveryAddressPreferences = deliveryAddressPreferences
			self.preferences = preferences
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email address of the buyer that is interacting with the cart.
		///     - phone: The phone number of the buyer that is interacting with the cart.
		///     - companyLocationId: The company location of the buyer that is interacting with the cart.
		///     - countryCode: The country where the buyer is located.
		///     - customerAccessToken: The access token used to identify the customer associated with the cart.
		///     - deliveryAddressPreferences: An ordered set of delivery addresses tied to the buyer that is interacting with the cart. The rank of the preferences is determined by the order of the addresses in the array. Preferences can be used to populate relevant fields in the checkout flow.  The input must not contain more than `250` values.
		///     - preferences: A set of preferences tied to the buyer interacting with the cart. Preferences are used to prefill fields in at checkout to streamline information collection.  Preferences are not synced back to the cart if they are overwritten. 
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(email: String? = nil, phone: String? = nil, companyLocationId: GraphQL.ID? = nil, countryCode: CountryCode? = nil, customerAccessToken: String? = nil, deliveryAddressPreferences: [DeliveryAddressInput]? = nil, preferences: CartPreferencesInput? = nil) {
			self.init(email: email.orUndefined, phone: phone.orUndefined, companyLocationId: companyLocationId.orUndefined, countryCode: countryCode.orUndefined, customerAccessToken: customerAccessToken.orUndefined, deliveryAddressPreferences: deliveryAddressPreferences.orUndefined, preferences: preferences.orUndefined)
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

			switch companyLocationId {
				case .value(let companyLocationId):
				guard let companyLocationId = companyLocationId else {
					fields.append("companyLocationId:null")
					break
				}
				fields.append("companyLocationId:\(GraphQL.quoteString(input: "\(companyLocationId.rawValue)"))")
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

			switch deliveryAddressPreferences {
				case .value(let deliveryAddressPreferences):
				guard let deliveryAddressPreferences = deliveryAddressPreferences else {
					fields.append("deliveryAddressPreferences:null")
					break
				}
				fields.append("deliveryAddressPreferences:[\(deliveryAddressPreferences.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch preferences {
				case .value(let preferences):
				guard let preferences = preferences else {
					fields.append("preferences:null")
					break
				}
				fields.append("preferences:\(preferences.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

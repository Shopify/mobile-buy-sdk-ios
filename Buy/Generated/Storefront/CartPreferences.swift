//
//  CartPreferences.swift
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
	/// A set of preferences tied to the buyer interacting with the cart. 
	/// Preferences are used to prefill fields in at checkout to streamline 
	/// information collection. Preferences are not synced back to the cart if they 
	/// are overwritten. 
	open class CartPreferencesQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartPreferences

		/// Delivery preferences can be used to prefill the delivery section in at 
		/// checkout. 
		@discardableResult
		open func delivery(alias: String? = nil, _ subfields: (CartDeliveryPreferenceQuery) -> Void) -> CartPreferencesQuery {
			let subquery = CartDeliveryPreferenceQuery()
			subfields(subquery)

			addField(field: "delivery", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Wallet preferences are used to populate relevant payment fields in the 
		/// checkout flow. Accepted value: `["shop_pay"]`. 
		@discardableResult
		open func wallet(alias: String? = nil) -> CartPreferencesQuery {
			addField(field: "wallet", aliasSuffix: alias)
			return self
		}
	}

	/// A set of preferences tied to the buyer interacting with the cart. 
	/// Preferences are used to prefill fields in at checkout to streamline 
	/// information collection. Preferences are not synced back to the cart if they 
	/// are overwritten. 
	open class CartPreferences: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartPreferencesQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "delivery":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartPreferences.self, field: fieldName, value: fieldValue)
				}
				return try CartDeliveryPreference(fields: value)

				case "wallet":
				if value is NSNull { return nil }
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: CartPreferences.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				default:
				throw SchemaViolationError(type: CartPreferences.self, field: fieldName, value: fieldValue)
			}
		}

		/// Delivery preferences can be used to prefill the delivery section in at 
		/// checkout. 
		open var delivery: Storefront.CartDeliveryPreference? {
			return internalGetDelivery()
		}

		func internalGetDelivery(alias: String? = nil) -> Storefront.CartDeliveryPreference? {
			return field(field: "delivery", aliasSuffix: alias) as! Storefront.CartDeliveryPreference?
		}

		/// Wallet preferences are used to populate relevant payment fields in the 
		/// checkout flow. Accepted value: `["shop_pay"]`. 
		open var wallet: [String]? {
			return internalGetWallet()
		}

		func internalGetWallet(alias: String? = nil) -> [String]? {
			return field(field: "wallet", aliasSuffix: alias) as! [String]?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "delivery":
					if let value = internalGetDelivery() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

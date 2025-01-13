//
//  CartDeliveryPreference.swift
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
	open class CartDeliveryPreferenceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartDeliveryPreference

		/// Preferred location used to find the closest pick up point based on 
		/// coordinates. 
		@discardableResult
		open func coordinates(alias: String? = nil, _ subfields: (CartDeliveryCoordinatesPreferenceQuery) -> Void) -> CartDeliveryPreferenceQuery {
			let subquery = CartDeliveryCoordinatesPreferenceQuery()
			subfields(subquery)

			addField(field: "coordinates", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The preferred delivery methods such as shipping, local pickup or through 
		/// pickup points. 
		@discardableResult
		open func deliveryMethod(alias: String? = nil) -> CartDeliveryPreferenceQuery {
			addField(field: "deliveryMethod", aliasSuffix: alias)
			return self
		}

		/// The pickup handle prefills checkout fields with the location for either 
		/// local pickup or pickup points delivery methods. It accepts both location ID 
		/// for local pickup and external IDs for pickup points. 
		@discardableResult
		open func pickupHandle(alias: String? = nil) -> CartDeliveryPreferenceQuery {
			addField(field: "pickupHandle", aliasSuffix: alias)
			return self
		}
	}

	/// A set of preferences tied to the buyer interacting with the cart. 
	/// Preferences are used to prefill fields in at checkout to streamline 
	/// information collection. Preferences are not synced back to the cart if they 
	/// are overwritten. 
	open class CartDeliveryPreference: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartDeliveryPreferenceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "coordinates":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartDeliveryPreference.self, field: fieldName, value: fieldValue)
				}
				return try CartDeliveryCoordinatesPreference(fields: value)

				case "deliveryMethod":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: CartDeliveryPreference.self, field: fieldName, value: fieldValue)
				}
				return value.map { return PreferenceDeliveryMethodType(rawValue: $0) ?? .unknownValue }

				case "pickupHandle":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: CartDeliveryPreference.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				default:
				throw SchemaViolationError(type: CartDeliveryPreference.self, field: fieldName, value: fieldValue)
			}
		}

		/// Preferred location used to find the closest pick up point based on 
		/// coordinates. 
		open var coordinates: Storefront.CartDeliveryCoordinatesPreference? {
			return internalGetCoordinates()
		}

		func internalGetCoordinates(alias: String? = nil) -> Storefront.CartDeliveryCoordinatesPreference? {
			return field(field: "coordinates", aliasSuffix: alias) as! Storefront.CartDeliveryCoordinatesPreference?
		}

		/// The preferred delivery methods such as shipping, local pickup or through 
		/// pickup points. 
		open var deliveryMethod: [Storefront.PreferenceDeliveryMethodType] {
			return internalGetDeliveryMethod()
		}

		func internalGetDeliveryMethod(alias: String? = nil) -> [Storefront.PreferenceDeliveryMethodType] {
			return field(field: "deliveryMethod", aliasSuffix: alias) as! [Storefront.PreferenceDeliveryMethodType]
		}

		/// The pickup handle prefills checkout fields with the location for either 
		/// local pickup or pickup points delivery methods. It accepts both location ID 
		/// for local pickup and external IDs for pickup points. 
		open var pickupHandle: [String] {
			return internalGetPickupHandle()
		}

		func internalGetPickupHandle(alias: String? = nil) -> [String] {
			return field(field: "pickupHandle", aliasSuffix: alias) as! [String]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "coordinates":
					if let value = internalGetCoordinates() {
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

//
//  CartDeliveryCoordinatesPreference.swift
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
	/// Preferred location used to find the closest pick up point based on 
	/// coordinates. 
	open class CartDeliveryCoordinatesPreferenceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartDeliveryCoordinatesPreference

		/// The two-letter code for the country of the preferred location. For example, 
		/// US. 
		@discardableResult
		open func countryCode(alias: String? = nil) -> CartDeliveryCoordinatesPreferenceQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// The geographic latitude for a given location. Coordinates are required in 
		/// order to set pickUpHandle for pickup points. 
		@discardableResult
		open func latitude(alias: String? = nil) -> CartDeliveryCoordinatesPreferenceQuery {
			addField(field: "latitude", aliasSuffix: alias)
			return self
		}

		/// The geographic longitude for a given location. Coordinates are required in 
		/// order to set pickUpHandle for pickup points. 
		@discardableResult
		open func longitude(alias: String? = nil) -> CartDeliveryCoordinatesPreferenceQuery {
			addField(field: "longitude", aliasSuffix: alias)
			return self
		}
	}

	/// Preferred location used to find the closest pick up point based on 
	/// coordinates. 
	open class CartDeliveryCoordinatesPreference: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartDeliveryCoordinatesPreferenceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "countryCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartDeliveryCoordinatesPreference.self, field: fieldName, value: fieldValue)
				}
				return CountryCode(rawValue: value) ?? .unknownValue

				case "latitude":
				guard let value = value as? Double else {
					throw SchemaViolationError(type: CartDeliveryCoordinatesPreference.self, field: fieldName, value: fieldValue)
				}
				return value

				case "longitude":
				guard let value = value as? Double else {
					throw SchemaViolationError(type: CartDeliveryCoordinatesPreference.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartDeliveryCoordinatesPreference.self, field: fieldName, value: fieldValue)
			}
		}

		/// The two-letter code for the country of the preferred location. For example, 
		/// US. 
		open var countryCode: Storefront.CountryCode {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> Storefront.CountryCode {
			return field(field: "countryCode", aliasSuffix: alias) as! Storefront.CountryCode
		}

		/// The geographic latitude for a given location. Coordinates are required in 
		/// order to set pickUpHandle for pickup points. 
		open var latitude: Double {
			return internalGetLatitude()
		}

		func internalGetLatitude(alias: String? = nil) -> Double {
			return field(field: "latitude", aliasSuffix: alias) as! Double
		}

		/// The geographic longitude for a given location. Coordinates are required in 
		/// order to set pickUpHandle for pickup points. 
		open var longitude: Double {
			return internalGetLongitude()
		}

		func internalGetLongitude(alias: String? = nil) -> Double {
			return field(field: "longitude", aliasSuffix: alias) as! Double
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

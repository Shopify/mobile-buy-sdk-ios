//
//  StoreAvailability.swift
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
	/// Describes the availability of a product variant at a particular location. 
	open class StoreAvailabilityQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = StoreAvailability

		/// Whether or not this product variant is in-stock at this location. 
		@discardableResult
		open func available(alias: String? = nil) -> StoreAvailabilityQuery {
			addField(field: "available", aliasSuffix: alias)
			return self
		}

		/// The location where this product variant is stocked at. 
		@discardableResult
		open func location(alias: String? = nil, _ subfields: (LocationQuery) -> Void) -> StoreAvailabilityQuery {
			let subquery = LocationQuery()
			subfields(subquery)

			addField(field: "location", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Returns the estimated amount of time it takes for pickup to be ready 
		/// (Example: Usually ready in 24 hours). 
		@discardableResult
		open func pickUpTime(alias: String? = nil) -> StoreAvailabilityQuery {
			addField(field: "pickUpTime", aliasSuffix: alias)
			return self
		}
	}

	/// Describes the availability of a product variant at a particular location. 
	open class StoreAvailability: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = StoreAvailabilityQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "available":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: StoreAvailability.self, field: fieldName, value: fieldValue)
				}
				return value

				case "location":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: StoreAvailability.self, field: fieldName, value: fieldValue)
				}
				return try Location(fields: value)

				case "pickUpTime":
				guard let value = value as? String else {
					throw SchemaViolationError(type: StoreAvailability.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: StoreAvailability.self, field: fieldName, value: fieldValue)
			}
		}

		/// Whether or not this product variant is in-stock at this location. 
		open var available: Bool {
			return internalGetAvailable()
		}

		func internalGetAvailable(alias: String? = nil) -> Bool {
			return field(field: "available", aliasSuffix: alias) as! Bool
		}

		/// The location where this product variant is stocked at. 
		open var location: Storefront.Location {
			return internalGetLocation()
		}

		func internalGetLocation(alias: String? = nil) -> Storefront.Location {
			return field(field: "location", aliasSuffix: alias) as! Storefront.Location
		}

		/// Returns the estimated amount of time it takes for pickup to be ready 
		/// (Example: Usually ready in 24 hours). 
		open var pickUpTime: String {
			return internalGetPickUpTime()
		}

		func internalGetPickUpTime(alias: String? = nil) -> String {
			return field(field: "pickUpTime", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "location":
					response.append(internalGetLocation())
					response.append(contentsOf: internalGetLocation().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

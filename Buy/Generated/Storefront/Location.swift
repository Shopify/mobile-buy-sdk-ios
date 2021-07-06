//
//  Location.swift
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
	/// Represents a location where product inventory is held. 
	open class LocationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Location

		/// The address of the location. 
		@discardableResult
		open func address(alias: String? = nil, _ subfields: (LocationAddressQuery) -> Void) -> LocationQuery {
			let subquery = LocationAddressQuery()
			subfields(subquery)

			addField(field: "address", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> LocationQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The name of the location. 
		@discardableResult
		open func name(alias: String? = nil) -> LocationQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a location where product inventory is held. 
	open class Location: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = LocationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "address":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Location.self, field: fieldName, value: fieldValue)
				}
				return try LocationAddress(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Location.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Location.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Location.self, field: fieldName, value: fieldValue)
			}
		}

		/// The address of the location. 
		open var address: Storefront.LocationAddress {
			return internalGetAddress()
		}

		func internalGetAddress(alias: String? = nil) -> Storefront.LocationAddress {
			return field(field: "address", aliasSuffix: alias) as! Storefront.LocationAddress
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The name of the location. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "address":
					response.append(internalGetAddress())
					response.append(contentsOf: internalGetAddress().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

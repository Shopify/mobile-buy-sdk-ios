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

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> LocationQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// Returns a metafield found by namespace and key. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> LocationQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> LocationQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
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
	open class Location: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MetafieldParentResource, Node {
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

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Location.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Location.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Location.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

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

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// Returns a metafield found by namespace and key. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		open var metafields: [Storefront.Metafield?] {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> [Storefront.Metafield?] {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield?] {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield?]
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

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					internalGetMetafields().forEach {
						if let value = $0 {
							response.append(value)
							response.append(contentsOf: value.childResponseObjectMap())
						}
					}

					default:
					break
				}
			}
			return response
		}
	}
}

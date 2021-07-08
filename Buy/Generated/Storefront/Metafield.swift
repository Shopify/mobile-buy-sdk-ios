//
//  Metafield.swift
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
	/// Metafields represent custom metadata attached to a resource. Metafields can 
	/// be sorted into namespaces and are comprised of keys, values, and value 
	/// types. 
	open class MetafieldQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Metafield

		/// The date and time when the storefront metafield was created. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> MetafieldQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// The description of a metafield. 
		@discardableResult
		open func description(alias: String? = nil) -> MetafieldQuery {
			addField(field: "description", aliasSuffix: alias)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> MetafieldQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The key name for a metafield. 
		@discardableResult
		open func key(alias: String? = nil) -> MetafieldQuery {
			addField(field: "key", aliasSuffix: alias)
			return self
		}

		/// The namespace for a metafield. 
		@discardableResult
		open func namespace(alias: String? = nil) -> MetafieldQuery {
			addField(field: "namespace", aliasSuffix: alias)
			return self
		}

		/// The parent object that the metafield belongs to. 
		@discardableResult
		open func parentResource(alias: String? = nil, _ subfields: (MetafieldParentResourceQuery) -> Void) -> MetafieldQuery {
			let subquery = MetafieldParentResourceQuery()
			subfields(subquery)

			addField(field: "parentResource", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The type name of the metafield. 
		@discardableResult
		open func type(alias: String? = nil) -> MetafieldQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The date and time when the storefront metafield was updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> MetafieldQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}

		/// The value of a metafield. 
		@discardableResult
		open func value(alias: String? = nil) -> MetafieldQuery {
			addField(field: "value", aliasSuffix: alias)
			return self
		}

		/// Represents the metafield value type. 
		@available(*, deprecated, message:"`valueType` is deprecated and replaced by `type` in API version 2021-07.")
		@discardableResult
		open func valueType(alias: String? = nil) -> MetafieldQuery {
			addField(field: "valueType", aliasSuffix: alias)
			return self
		}
	}

	/// Metafields represent custom metadata attached to a resource. Metafields can 
	/// be sorted into namespaces and are comprised of keys, values, and value 
	/// types. 
	open class Metafield: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = MetafieldQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "description":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "key":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return value

				case "namespace":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return value

				case "parentResource":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return try UnknownMetafieldParentResource.create(fields: value)

				case "type":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "value":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return value

				case "valueType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return MetafieldValueType(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
			}
		}

		/// The date and time when the storefront metafield was created. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// The description of a metafield. 
		open var description: String? {
			return internalGetDescription()
		}

		func internalGetDescription(alias: String? = nil) -> String? {
			return field(field: "description", aliasSuffix: alias) as! String?
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The key name for a metafield. 
		open var key: String {
			return internalGetKey()
		}

		func internalGetKey(alias: String? = nil) -> String {
			return field(field: "key", aliasSuffix: alias) as! String
		}

		/// The namespace for a metafield. 
		open var namespace: String {
			return internalGetNamespace()
		}

		func internalGetNamespace(alias: String? = nil) -> String {
			return field(field: "namespace", aliasSuffix: alias) as! String
		}

		/// The parent object that the metafield belongs to. 
		open var parentResource: MetafieldParentResource {
			return internalGetParentResource()
		}

		func internalGetParentResource(alias: String? = nil) -> MetafieldParentResource {
			return field(field: "parentResource", aliasSuffix: alias) as! MetafieldParentResource
		}

		/// The type name of the metafield. 
		open var type: String {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> String {
			return field(field: "type", aliasSuffix: alias) as! String
		}

		/// The date and time when the storefront metafield was updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		/// The value of a metafield. 
		open var value: String {
			return internalGetValue()
		}

		func internalGetValue(alias: String? = nil) -> String {
			return field(field: "value", aliasSuffix: alias) as! String
		}

		/// Represents the metafield value type. 
		@available(*, deprecated, message:"`valueType` is deprecated and replaced by `type` in API version 2021-07.")
		open var valueType: Storefront.MetafieldValueType {
			return internalGetValueType()
		}

		func internalGetValueType(alias: String? = nil) -> Storefront.MetafieldValueType {
			return field(field: "valueType", aliasSuffix: alias) as! Storefront.MetafieldValueType
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

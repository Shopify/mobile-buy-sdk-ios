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

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> MetafieldQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The unique identifier for the metafield within its namespace. 
		@discardableResult
		open func key(alias: String? = nil) -> MetafieldQuery {
			addField(field: "key", aliasSuffix: alias)
			return self
		}

		/// The container for a group of metafields that the metafield is associated 
		/// with. 
		@discardableResult
		open func namespace(alias: String? = nil) -> MetafieldQuery {
			addField(field: "namespace", aliasSuffix: alias)
			return self
		}

		/// The type of resource that the metafield is attached to. 
		@discardableResult
		open func parentResource(alias: String? = nil, _ subfields: (MetafieldParentResourceQuery) -> Void) -> MetafieldQuery {
			let subquery = MetafieldParentResourceQuery()
			subfields(subquery)

			addField(field: "parentResource", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Returns a reference object if the metafield's type is a resource reference. 
		@discardableResult
		open func reference(alias: String? = nil, _ subfields: (MetafieldReferenceQuery) -> Void) -> MetafieldQuery {
			let subquery = MetafieldReferenceQuery()
			subfields(subquery)

			addField(field: "reference", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of reference objects if the metafield's type is a resource reference 
		/// list. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///
		@discardableResult
		open func references(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, _ subfields: (MetafieldReferenceConnectionQuery) -> Void) -> MetafieldQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldReferenceConnectionQuery()
			subfields(subquery)

			addField(field: "references", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The type name of the metafield. Refer to the list of [supported 
		/// types](https://shopify.dev/apps/metafields/definitions/types). 
		@discardableResult
		open func type(alias: String? = nil) -> MetafieldQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The date and time when the metafield was last updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> MetafieldQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}

		/// The data stored in the metafield. Always stored as a string, regardless of 
		/// the metafield's type. 
		@discardableResult
		open func value(alias: String? = nil) -> MetafieldQuery {
			addField(field: "value", aliasSuffix: alias)
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

				case "reference":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return try UnknownMetafieldReference.create(fields: value)

				case "references":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Metafield.self, field: fieldName, value: fieldValue)
				}
				return try MetafieldReferenceConnection(fields: value)

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

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The unique identifier for the metafield within its namespace. 
		open var key: String {
			return internalGetKey()
		}

		func internalGetKey(alias: String? = nil) -> String {
			return field(field: "key", aliasSuffix: alias) as! String
		}

		/// The container for a group of metafields that the metafield is associated 
		/// with. 
		open var namespace: String {
			return internalGetNamespace()
		}

		func internalGetNamespace(alias: String? = nil) -> String {
			return field(field: "namespace", aliasSuffix: alias) as! String
		}

		/// The type of resource that the metafield is attached to. 
		open var parentResource: MetafieldParentResource {
			return internalGetParentResource()
		}

		func internalGetParentResource(alias: String? = nil) -> MetafieldParentResource {
			return field(field: "parentResource", aliasSuffix: alias) as! MetafieldParentResource
		}

		/// Returns a reference object if the metafield's type is a resource reference. 
		open var reference: MetafieldReference? {
			return internalGetReference()
		}

		func internalGetReference(alias: String? = nil) -> MetafieldReference? {
			return field(field: "reference", aliasSuffix: alias) as! MetafieldReference?
		}

		/// A list of reference objects if the metafield's type is a resource reference 
		/// list. 
		open var references: Storefront.MetafieldReferenceConnection? {
			return internalGetReferences()
		}

		open func aliasedReferences(alias: String) -> Storefront.MetafieldReferenceConnection? {
			return internalGetReferences(alias: alias)
		}

		func internalGetReferences(alias: String? = nil) -> Storefront.MetafieldReferenceConnection? {
			return field(field: "references", aliasSuffix: alias) as! Storefront.MetafieldReferenceConnection?
		}

		/// The type name of the metafield. Refer to the list of [supported 
		/// types](https://shopify.dev/apps/metafields/definitions/types). 
		open var type: String {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> String {
			return field(field: "type", aliasSuffix: alias) as! String
		}

		/// The date and time when the metafield was last updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		/// The data stored in the metafield. Always stored as a string, regardless of 
		/// the metafield's type. 
		open var value: String {
			return internalGetValue()
		}

		func internalGetValue(alias: String? = nil) -> String {
			return field(field: "value", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "parentResource":
					response.append((internalGetParentResource() as! GraphQL.AbstractResponse))
					response.append(contentsOf: (internalGetParentResource() as! GraphQL.AbstractResponse).childResponseObjectMap())

					case "reference":
					if let value = internalGetReference() {
						response.append((value as! GraphQL.AbstractResponse))
						response.append(contentsOf: (value as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

					case "references":
					if let value = internalGetReferences() {
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

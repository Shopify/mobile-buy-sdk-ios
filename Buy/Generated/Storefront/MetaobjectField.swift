//
//  MetaobjectField.swift
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
	/// Provides the value of a Metaobject field. 
	open class MetaobjectFieldQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MetaobjectField

		/// The field key. 
		@discardableResult
		open func key(alias: String? = nil) -> MetaobjectFieldQuery {
			addField(field: "key", aliasSuffix: alias)
			return self
		}

		/// A referenced object if the field type is a resource reference. 
		@discardableResult
		open func reference(alias: String? = nil, _ subfields: (MetafieldReferenceQuery) -> Void) -> MetaobjectFieldQuery {
			let subquery = MetafieldReferenceQuery()
			subfields(subquery)

			addField(field: "reference", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of referenced objects if the field type is a resource reference 
		/// list. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///
		@discardableResult
		open func references(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, _ subfields: (MetafieldReferenceConnectionQuery) -> Void) -> MetaobjectFieldQuery {
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

		/// The type name of the field. See the list of [supported 
		/// types](https://shopify.dev/apps/metafields/definitions/types). 
		@discardableResult
		open func type(alias: String? = nil) -> MetaobjectFieldQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The field value. 
		@discardableResult
		open func value(alias: String? = nil) -> MetaobjectFieldQuery {
			addField(field: "value", aliasSuffix: alias)
			return self
		}
	}

	/// Provides the value of a Metaobject field. 
	open class MetaobjectField: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = MetaobjectFieldQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "key":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MetaobjectField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "reference":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MetaobjectField.self, field: fieldName, value: fieldValue)
				}
				return try UnknownMetafieldReference.create(fields: value)

				case "references":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MetaobjectField.self, field: fieldName, value: fieldValue)
				}
				return try MetafieldReferenceConnection(fields: value)

				case "type":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MetaobjectField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "value":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MetaobjectField.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: MetaobjectField.self, field: fieldName, value: fieldValue)
			}
		}

		/// The field key. 
		open var key: String {
			return internalGetKey()
		}

		func internalGetKey(alias: String? = nil) -> String {
			return field(field: "key", aliasSuffix: alias) as! String
		}

		/// A referenced object if the field type is a resource reference. 
		open var reference: MetafieldReference? {
			return internalGetReference()
		}

		func internalGetReference(alias: String? = nil) -> MetafieldReference? {
			return field(field: "reference", aliasSuffix: alias) as! MetafieldReference?
		}

		/// A list of referenced objects if the field type is a resource reference 
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

		/// The type name of the field. See the list of [supported 
		/// types](https://shopify.dev/apps/metafields/definitions/types). 
		open var type: String {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> String {
			return field(field: "type", aliasSuffix: alias) as! String
		}

		/// The field value. 
		open var value: String? {
			return internalGetValue()
		}

		func internalGetValue(alias: String? = nil) -> String? {
			return field(field: "value", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
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

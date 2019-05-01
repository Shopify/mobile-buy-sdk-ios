//
//  HasMetafields.swift
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

/// Represents information about the metafields associated to the specified 
/// resource. 
public protocol HasMetafields {
	var metafield: Storefront.Metafield? { get }

	var metafields: Storefront.MetafieldConnection { get }
}

extension Storefront {
	/// Represents information about the metafields associated to the specified 
	/// resource. 
	open class HasMetafieldsQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = HasMetafields

		/// The metafield associated with the resource. 
		///
		/// - parameters:
		///     - namespace: Container for a set of metafields (maximum of 20 characters).
		///     - key: Identifier for the metafield (maximum of 30 characters).
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String, key: String, _ subfields: (MetafieldQuery) -> Void) -> HasMetafieldsQuery {
			var args: [String] = []

			args.append("namespace:\(GraphQL.quoteString(input: namespace))")

			args.append("key:\(GraphQL.quoteString(input: key))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A paginated list of metafields associated with the resource. 
		///
		/// - parameters:
		///     - namespace: Container for a set of metafields (maximum of 20 characters).
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func metafields(alias: String? = nil, namespace: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (MetafieldConnectionQuery) -> Void) -> HasMetafieldsQuery {
			var args: [String] = []

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

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

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldConnectionQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onProductVariant(subfields: (ProductVariantQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductVariant", subfields: subquery)
			return self
		}
	}

	/// Represents information about the metafields associated to the specified 
	/// resource. 
	open class UnknownHasMetafields: GraphQL.AbstractResponse, GraphQLObject, HasMetafields {
		public typealias Query = HasMetafieldsQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: UnknownHasMetafields.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: UnknownHasMetafields.self, field: fieldName, value: fieldValue)
				}
				return try MetafieldConnection(fields: value)

				default:
				throw SchemaViolationError(type: UnknownHasMetafields.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> HasMetafields {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownHasMetafields.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Product": return try Product.init(fields: fields)

				case "ProductVariant": return try ProductVariant.init(fields: fields)

				default:
				return try UnknownHasMetafields.init(fields: fields)
			}
		}

		/// The metafield associated with the resource. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// A paginated list of metafields associated with the resource. 
		open var metafields: Storefront.MetafieldConnection {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> Storefront.MetafieldConnection {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> Storefront.MetafieldConnection {
			return field(field: "metafields", aliasSuffix: alias) as! Storefront.MetafieldConnection
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					response.append(internalGetMetafields())
					response.append(contentsOf: internalGetMetafields().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

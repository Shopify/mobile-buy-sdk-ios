//
//  QueryRoot.swift
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
	/// The schema’s entry-point for queries. This acts as the public, top-level 
	/// API from which all queries must start. 
	open class QueryRootQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = QueryRoot

		///
		/// - parameters:
		///     - customerAccessToken: The customer access token
		///
		@discardableResult
		open func customer(alias: String? = nil, customerAccessToken: String, _ subfields: (CustomerQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		///
		/// - parameters:
		///     - id: No description
		///
		@discardableResult
		open func node(alias: String? = nil, id: GraphQL.ID, _ subfields: (NodeQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = NodeQuery()
			subfields(subquery)

			addField(field: "node", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func shop(alias: String? = nil, _ subfields: (ShopQuery) -> Void) -> QueryRootQuery {
			let subquery = ShopQuery()
			subfields(subquery)

			addField(field: "shop", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The schema’s entry-point for queries. This acts as the public, top-level 
	/// API from which all queries must start. 
	open class QueryRoot: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = QueryRootQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "node":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try UnknownNode.create(fields: value)

				case "shop":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Shop(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		open func aliasedCustomer(alias: String) -> Storefront.Customer? {
			return internalGetCustomer(alias: alias)
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.Customer?
		}

		open var node: Node? {
			return internalGetNode()
		}

		open func aliasedNode(alias: String) -> Node? {
			return internalGetNode(alias: alias)
		}

		func internalGetNode(alias: String? = nil) -> Node? {
			return field(field: "node", aliasSuffix: alias) as! Node?
		}

		open var shop: Storefront.Shop {
			return internalGetShop()
		}

		func internalGetShop(alias: String? = nil) -> Storefront.Shop {
			return field(field: "shop", aliasSuffix: alias) as! Storefront.Shop
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "node":
					if let value = internalGetNode() {
						response.append((value as! GraphQL.AbstractResponse))
						response.append(contentsOf: (value as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

					case "shop":
					response.append(internalGetShop())
					response.append(contentsOf: internalGetShop().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

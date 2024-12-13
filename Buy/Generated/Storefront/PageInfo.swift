//
//  PageInfo.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// Returns information about pagination in a connection, in accordance with 
	/// the [Relay 
	/// specification](https://relay.dev/graphql/connections.htm#sec-undefined.PageInfo). 
	/// For more information, please read our [GraphQL Pagination Usage 
	/// Guide](https://shopify.dev/api/usage/pagination-graphql). 
	open class PageInfoQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PageInfo

		/// The cursor corresponding to the last node in edges. 
		@discardableResult
		open func endCursor(alias: String? = nil) -> PageInfoQuery {
			addField(field: "endCursor", aliasSuffix: alias)
			return self
		}

		/// Whether there are more pages to fetch following the current page. 
		@discardableResult
		open func hasNextPage(alias: String? = nil) -> PageInfoQuery {
			addField(field: "hasNextPage", aliasSuffix: alias)
			return self
		}

		/// Whether there are any pages prior to the current page. 
		@discardableResult
		open func hasPreviousPage(alias: String? = nil) -> PageInfoQuery {
			addField(field: "hasPreviousPage", aliasSuffix: alias)
			return self
		}

		/// The cursor corresponding to the first node in edges. 
		@discardableResult
		open func startCursor(alias: String? = nil) -> PageInfoQuery {
			addField(field: "startCursor", aliasSuffix: alias)
			return self
		}
	}

	/// Returns information about pagination in a connection, in accordance with 
	/// the [Relay 
	/// specification](https://relay.dev/graphql/connections.htm#sec-undefined.PageInfo). 
	/// For more information, please read our [GraphQL Pagination Usage 
	/// Guide](https://shopify.dev/api/usage/pagination-graphql). 
	open class PageInfo: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = PageInfoQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "endCursor":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: PageInfo.self, field: fieldName, value: fieldValue)
				}
				return value

				case "hasNextPage":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: PageInfo.self, field: fieldName, value: fieldValue)
				}
				return value

				case "hasPreviousPage":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: PageInfo.self, field: fieldName, value: fieldValue)
				}
				return value

				case "startCursor":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: PageInfo.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: PageInfo.self, field: fieldName, value: fieldValue)
			}
		}

		/// The cursor corresponding to the last node in edges. 
		open var endCursor: String? {
			return internalGetEndCursor()
		}

		func internalGetEndCursor(alias: String? = nil) -> String? {
			return field(field: "endCursor", aliasSuffix: alias) as! String?
		}

		/// Whether there are more pages to fetch following the current page. 
		open var hasNextPage: Bool {
			return internalGetHasNextPage()
		}

		func internalGetHasNextPage(alias: String? = nil) -> Bool {
			return field(field: "hasNextPage", aliasSuffix: alias) as! Bool
		}

		/// Whether there are any pages prior to the current page. 
		open var hasPreviousPage: Bool {
			return internalGetHasPreviousPage()
		}

		func internalGetHasPreviousPage(alias: String? = nil) -> Bool {
			return field(field: "hasPreviousPage", aliasSuffix: alias) as! Bool
		}

		/// The cursor corresponding to the first node in edges. 
		open var startCursor: String? {
			return internalGetStartCursor()
		}

		func internalGetStartCursor(alias: String? = nil) -> String? {
			return field(field: "startCursor", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

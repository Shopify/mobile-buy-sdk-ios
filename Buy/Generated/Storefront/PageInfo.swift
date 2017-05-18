//
//  PageInfo.swift
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
	/// Information about pagination in a connection. 
	open class PageInfoQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PageInfo

		/// Indicates if there are more pages to fetch. 
		@discardableResult
		open func hasNextPage(alias: String? = nil) -> PageInfoQuery {
			addField(field: "hasNextPage", aliasSuffix: alias)
			return self
		}

		/// Indicates if there are any pages prior to the current page. 
		@discardableResult
		open func hasPreviousPage(alias: String? = nil) -> PageInfoQuery {
			addField(field: "hasPreviousPage", aliasSuffix: alias)
			return self
		}
	}

	/// Information about pagination in a connection. 
	open class PageInfo: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = PageInfoQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "hasNextPage":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "hasPreviousPage":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// Indicates if there are more pages to fetch. 
		open var hasNextPage: Bool {
			return internalGetHasNextPage()
		}

		func internalGetHasNextPage(alias: String? = nil) -> Bool {
			return field(field: "hasNextPage", aliasSuffix: alias) as! Bool
		}

		/// Indicates if there are any pages prior to the current page. 
		open var hasPreviousPage: Bool {
			return internalGetHasPreviousPage()
		}

		func internalGetHasPreviousPage(alias: String? = nil) -> Bool {
			return field(field: "hasPreviousPage", aliasSuffix: alias) as! Bool
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

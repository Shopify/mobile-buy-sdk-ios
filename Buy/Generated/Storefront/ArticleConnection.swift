//
//  ArticleConnection.swift
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
	open class ArticleConnectionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ArticleConnection

		/// A list of edges. 
		@discardableResult
		open func edges(alias: String? = nil, _ subfields: (ArticleEdgeQuery) -> Void) -> ArticleConnectionQuery {
			let subquery = ArticleEdgeQuery()
			subfields(subquery)

			addField(field: "edges", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Information to aid in pagination. 
		@discardableResult
		open func pageInfo(alias: String? = nil, _ subfields: (PageInfoQuery) -> Void) -> ArticleConnectionQuery {
			let subquery = PageInfoQuery()
			subfields(subquery)

			addField(field: "pageInfo", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	open class ArticleConnection: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ArticleConnectionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "edges":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try ArticleEdge(fields: $0) }

				case "pageInfo":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try PageInfo(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// A list of edges. 
		open var edges: [Storefront.ArticleEdge] {
			return internalGetEdges()
		}

		func internalGetEdges(alias: String? = nil) -> [Storefront.ArticleEdge] {
			return field(field: "edges", aliasSuffix: alias) as! [Storefront.ArticleEdge]
		}

		/// Information to aid in pagination. 
		open var pageInfo: Storefront.PageInfo {
			return internalGetPageInfo()
		}

		func internalGetPageInfo(alias: String? = nil) -> Storefront.PageInfo {
			return field(field: "pageInfo", aliasSuffix: alias) as! Storefront.PageInfo
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "edges":
					internalGetEdges().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "pageInfo":
					response.append(internalGetPageInfo())
					response.append(contentsOf: internalGetPageInfo().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

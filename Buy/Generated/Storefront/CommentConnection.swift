//
//  CommentConnection.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// An auto-generated type for paginating through multiple Comments. 
	open class CommentConnectionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CommentConnection

		/// A list of edges. 
		@discardableResult
		open func edges(alias: String? = nil, _ subfields: (CommentEdgeQuery) -> Void) -> CommentConnectionQuery {
			let subquery = CommentEdgeQuery()
			subfields(subquery)

			addField(field: "edges", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of the nodes contained in CommentEdge. 
		@discardableResult
		open func nodes(alias: String? = nil, _ subfields: (CommentQuery) -> Void) -> CommentConnectionQuery {
			let subquery = CommentQuery()
			subfields(subquery)

			addField(field: "nodes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Information to aid in pagination. 
		@discardableResult
		open func pageInfo(alias: String? = nil, _ subfields: (PageInfoQuery) -> Void) -> CommentConnectionQuery {
			let subquery = PageInfoQuery()
			subfields(subquery)

			addField(field: "pageInfo", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// An auto-generated type for paginating through multiple Comments. 
	open class CommentConnection: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CommentConnectionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "edges":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CommentConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CommentEdge(fields: $0) }

				case "nodes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CommentConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Comment(fields: $0) }

				case "pageInfo":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CommentConnection.self, field: fieldName, value: fieldValue)
				}
				return try PageInfo(fields: value)

				default:
				throw SchemaViolationError(type: CommentConnection.self, field: fieldName, value: fieldValue)
			}
		}

		/// A list of edges. 
		open var edges: [Storefront.CommentEdge] {
			return internalGetEdges()
		}

		func internalGetEdges(alias: String? = nil) -> [Storefront.CommentEdge] {
			return field(field: "edges", aliasSuffix: alias) as! [Storefront.CommentEdge]
		}

		/// A list of the nodes contained in CommentEdge. 
		open var nodes: [Storefront.Comment] {
			return internalGetNodes()
		}

		func internalGetNodes(alias: String? = nil) -> [Storefront.Comment] {
			return field(field: "nodes", aliasSuffix: alias) as! [Storefront.Comment]
		}

		/// Information to aid in pagination. 
		open var pageInfo: Storefront.PageInfo {
			return internalGetPageInfo()
		}

		func internalGetPageInfo(alias: String? = nil) -> Storefront.PageInfo {
			return field(field: "pageInfo", aliasSuffix: alias) as! Storefront.PageInfo
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "edges":
					internalGetEdges().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "nodes":
					internalGetNodes().forEach {
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

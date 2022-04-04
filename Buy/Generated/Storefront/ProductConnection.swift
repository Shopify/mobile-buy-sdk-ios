//
//  ProductConnection.swift
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
	/// An auto-generated type for paginating through multiple Products. 
	open class ProductConnectionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ProductConnection

		/// A list of edges. 
		@discardableResult
		open func edges(alias: String? = nil, _ subfields: (ProductEdgeQuery) -> Void) -> ProductConnectionQuery {
			let subquery = ProductEdgeQuery()
			subfields(subquery)

			addField(field: "edges", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of available filters. 
		@discardableResult
		open func filters(alias: String? = nil, _ subfields: (FilterQuery) -> Void) -> ProductConnectionQuery {
			let subquery = FilterQuery()
			subfields(subquery)

			addField(field: "filters", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of the nodes contained in ProductEdge. 
		@discardableResult
		open func nodes(alias: String? = nil, _ subfields: (ProductQuery) -> Void) -> ProductConnectionQuery {
			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "nodes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Information to aid in pagination. 
		@discardableResult
		open func pageInfo(alias: String? = nil, _ subfields: (PageInfoQuery) -> Void) -> ProductConnectionQuery {
			let subquery = PageInfoQuery()
			subfields(subquery)

			addField(field: "pageInfo", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// An auto-generated type for paginating through multiple Products. 
	open class ProductConnection: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ProductConnectionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "edges":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ProductConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ProductEdge(fields: $0) }

				case "filters":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ProductConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Filter(fields: $0) }

				case "nodes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ProductConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Product(fields: $0) }

				case "pageInfo":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductConnection.self, field: fieldName, value: fieldValue)
				}
				return try PageInfo(fields: value)

				default:
				throw SchemaViolationError(type: ProductConnection.self, field: fieldName, value: fieldValue)
			}
		}

		/// A list of edges. 
		open var edges: [Storefront.ProductEdge] {
			return internalGetEdges()
		}

		func internalGetEdges(alias: String? = nil) -> [Storefront.ProductEdge] {
			return field(field: "edges", aliasSuffix: alias) as! [Storefront.ProductEdge]
		}

		/// A list of available filters. 
		open var filters: [Storefront.Filter] {
			return internalGetFilters()
		}

		func internalGetFilters(alias: String? = nil) -> [Storefront.Filter] {
			return field(field: "filters", aliasSuffix: alias) as! [Storefront.Filter]
		}

		/// A list of the nodes contained in ProductEdge. 
		open var nodes: [Storefront.Product] {
			return internalGetNodes()
		}

		func internalGetNodes(alias: String? = nil) -> [Storefront.Product] {
			return field(field: "nodes", aliasSuffix: alias) as! [Storefront.Product]
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

					case "filters":
					internalGetFilters().forEach {
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

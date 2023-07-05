//
//  SearchResultItemConnection.swift
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
	/// An auto-generated type for paginating through multiple SearchResultItems. 
	open class SearchResultItemConnectionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SearchResultItemConnection

		/// A list of edges. 
		@discardableResult
		open func edges(alias: String? = nil, _ subfields: (SearchResultItemEdgeQuery) -> Void) -> SearchResultItemConnectionQuery {
			let subquery = SearchResultItemEdgeQuery()
			subfields(subquery)

			addField(field: "edges", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of the nodes contained in SearchResultItemEdge. 
		@discardableResult
		open func nodes(alias: String? = nil, _ subfields: (SearchResultItemQuery) -> Void) -> SearchResultItemConnectionQuery {
			let subquery = SearchResultItemQuery()
			subfields(subquery)

			addField(field: "nodes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Information to aid in pagination. 
		@discardableResult
		open func pageInfo(alias: String? = nil, _ subfields: (PageInfoQuery) -> Void) -> SearchResultItemConnectionQuery {
			let subquery = PageInfoQuery()
			subfields(subquery)

			addField(field: "pageInfo", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of available filters. 
		@discardableResult
		open func productFilters(alias: String? = nil, _ subfields: (FilterQuery) -> Void) -> SearchResultItemConnectionQuery {
			let subquery = FilterQuery()
			subfields(subquery)

			addField(field: "productFilters", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total number of results. 
		@discardableResult
		open func totalCount(alias: String? = nil) -> SearchResultItemConnectionQuery {
			addField(field: "totalCount", aliasSuffix: alias)
			return self
		}
	}

	/// An auto-generated type for paginating through multiple SearchResultItems. 
	open class SearchResultItemConnection: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SearchResultItemConnectionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "edges":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SearchResultItemConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SearchResultItemEdge(fields: $0) }

				case "nodes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SearchResultItemConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UnknownSearchResultItem.create(fields: $0) }

				case "pageInfo":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SearchResultItemConnection.self, field: fieldName, value: fieldValue)
				}
				return try PageInfo(fields: value)

				case "productFilters":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SearchResultItemConnection.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Filter(fields: $0) }

				case "totalCount":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: SearchResultItemConnection.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: SearchResultItemConnection.self, field: fieldName, value: fieldValue)
			}
		}

		/// A list of edges. 
		open var edges: [Storefront.SearchResultItemEdge] {
			return internalGetEdges()
		}

		func internalGetEdges(alias: String? = nil) -> [Storefront.SearchResultItemEdge] {
			return field(field: "edges", aliasSuffix: alias) as! [Storefront.SearchResultItemEdge]
		}

		/// A list of the nodes contained in SearchResultItemEdge. 
		open var nodes: [SearchResultItem] {
			return internalGetNodes()
		}

		func internalGetNodes(alias: String? = nil) -> [SearchResultItem] {
			return field(field: "nodes", aliasSuffix: alias) as! [SearchResultItem]
		}

		/// Information to aid in pagination. 
		open var pageInfo: Storefront.PageInfo {
			return internalGetPageInfo()
		}

		func internalGetPageInfo(alias: String? = nil) -> Storefront.PageInfo {
			return field(field: "pageInfo", aliasSuffix: alias) as! Storefront.PageInfo
		}

		/// A list of available filters. 
		open var productFilters: [Storefront.Filter] {
			return internalGetProductFilters()
		}

		func internalGetProductFilters(alias: String? = nil) -> [Storefront.Filter] {
			return field(field: "productFilters", aliasSuffix: alias) as! [Storefront.Filter]
		}

		/// The total number of results. 
		open var totalCount: Int32 {
			return internalGetTotalCount()
		}

		func internalGetTotalCount(alias: String? = nil) -> Int32 {
			return field(field: "totalCount", aliasSuffix: alias) as! Int32
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

					case "nodes":
					internalGetNodes().forEach {
						response.append(($0 as! GraphQL.AbstractResponse))
						response.append(contentsOf: ($0 as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

					case "pageInfo":
					response.append(internalGetPageInfo())
					response.append(contentsOf: internalGetPageInfo().childResponseObjectMap())

					case "productFilters":
					internalGetProductFilters().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

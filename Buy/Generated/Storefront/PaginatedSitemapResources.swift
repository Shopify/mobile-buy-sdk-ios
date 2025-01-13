//
//  PaginatedSitemapResources.swift
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
	/// Type for paginating through multiple sitemap's resources. 
	open class PaginatedSitemapResourcesQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PaginatedSitemapResources

		/// Whether there are more pages to fetch following the current page. 
		@discardableResult
		open func hasNextPage(alias: String? = nil) -> PaginatedSitemapResourcesQuery {
			addField(field: "hasNextPage", aliasSuffix: alias)
			return self
		}

		/// List of sitemap resources for the current page. Note: The number of items 
		/// varies between 0 and 250 per page. 
		@discardableResult
		open func items(alias: String? = nil, _ subfields: (SitemapResourceInterfaceQuery) -> Void) -> PaginatedSitemapResourcesQuery {
			let subquery = SitemapResourceInterfaceQuery()
			subfields(subquery)

			addField(field: "items", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Type for paginating through multiple sitemap's resources. 
	open class PaginatedSitemapResources: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = PaginatedSitemapResourcesQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "hasNextPage":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: PaginatedSitemapResources.self, field: fieldName, value: fieldValue)
				}
				return value

				case "items":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: PaginatedSitemapResources.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UnknownSitemapResourceInterface.create(fields: $0) }

				default:
				throw SchemaViolationError(type: PaginatedSitemapResources.self, field: fieldName, value: fieldValue)
			}
		}

		/// Whether there are more pages to fetch following the current page. 
		open var hasNextPage: Bool {
			return internalGetHasNextPage()
		}

		func internalGetHasNextPage(alias: String? = nil) -> Bool {
			return field(field: "hasNextPage", aliasSuffix: alias) as! Bool
		}

		/// List of sitemap resources for the current page. Note: The number of items 
		/// varies between 0 and 250 per page. 
		open var items: [SitemapResourceInterface] {
			return internalGetItems()
		}

		func internalGetItems(alias: String? = nil) -> [SitemapResourceInterface] {
			return field(field: "items", aliasSuffix: alias) as! [SitemapResourceInterface]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

//
//  Sitemap.swift
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
	/// Contains all fields required to generate sitemaps. 
	open class SitemapQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Sitemap

		/// The number of sitemap's pages for a given type. 
		@discardableResult
		open func pagesCount(alias: String? = nil, _ subfields: (CountQuery) -> Void) -> SitemapQuery {
			let subquery = CountQuery()
			subfields(subquery)

			addField(field: "pagesCount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of sitemap's resources for a given type. Important Notes: - The 
		/// number of items per page varies from 0 to 250. - Empty pages (0 items) may 
		/// occur and do not necessarily indicate the end of results. - Always check 
		/// `hasNextPage` to determine if more pages are available. 
		///
		/// - parameters:
		///     - page: The page number to fetch.
		///
		@discardableResult
		open func resources(alias: String? = nil, page: Int32, _ subfields: (PaginatedSitemapResourcesQuery) -> Void) -> SitemapQuery {
			var args: [String] = []

			args.append("page:\(page)")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = PaginatedSitemapResourcesQuery()
			subfields(subquery)

			addField(field: "resources", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}
	}

	/// Contains all fields required to generate sitemaps. 
	open class Sitemap: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SitemapQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "pagesCount":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Sitemap.self, field: fieldName, value: fieldValue)
				}
				return try Count(fields: value)

				case "resources":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Sitemap.self, field: fieldName, value: fieldValue)
				}
				return try PaginatedSitemapResources(fields: value)

				default:
				throw SchemaViolationError(type: Sitemap.self, field: fieldName, value: fieldValue)
			}
		}

		/// The number of sitemap's pages for a given type. 
		open var pagesCount: Storefront.Count? {
			return internalGetPagesCount()
		}

		func internalGetPagesCount(alias: String? = nil) -> Storefront.Count? {
			return field(field: "pagesCount", aliasSuffix: alias) as! Storefront.Count?
		}

		/// A list of sitemap's resources for a given type. Important Notes: - The 
		/// number of items per page varies from 0 to 250. - Empty pages (0 items) may 
		/// occur and do not necessarily indicate the end of results. - Always check 
		/// `hasNextPage` to determine if more pages are available. 
		open var resources: Storefront.PaginatedSitemapResources? {
			return internalGetResources()
		}

		open func aliasedResources(alias: String) -> Storefront.PaginatedSitemapResources? {
			return internalGetResources(alias: alias)
		}

		func internalGetResources(alias: String? = nil) -> Storefront.PaginatedSitemapResources? {
			return field(field: "resources", aliasSuffix: alias) as! Storefront.PaginatedSitemapResources?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "pagesCount":
					if let value = internalGetPagesCount() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "resources":
					if let value = internalGetResources() {
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

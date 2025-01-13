//
//  SitemapResource.swift
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
	/// Represents a sitemap resource that is not a metaobject. 
	open class SitemapResourceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SitemapResource

		/// Resource's handle. 
		@discardableResult
		open func handle(alias: String? = nil) -> SitemapResourceQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// Resource's image. 
		@discardableResult
		open func image(alias: String? = nil, _ subfields: (SitemapImageQuery) -> Void) -> SitemapResourceQuery {
			let subquery = SitemapImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Resource's title. 
		@discardableResult
		open func title(alias: String? = nil) -> SitemapResourceQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The date and time when the resource was updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> SitemapResourceQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a sitemap resource that is not a metaobject. 
	open class SitemapResource: GraphQL.AbstractResponse, GraphQLObject, SitemapResourceInterface {
		public typealias Query = SitemapResourceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapResource.self, field: fieldName, value: fieldValue)
				}
				return value

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SitemapResource.self, field: fieldName, value: fieldValue)
				}
				return try SitemapImage(fields: value)

				case "title":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapResource.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapResource.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: SitemapResource.self, field: fieldName, value: fieldValue)
			}
		}

		/// Resource's handle. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// Resource's image. 
		open var image: Storefront.SitemapImage? {
			return internalGetImage()
		}

		func internalGetImage(alias: String? = nil) -> Storefront.SitemapImage? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.SitemapImage?
		}

		/// Resource's title. 
		open var title: String? {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String? {
			return field(field: "title", aliasSuffix: alias) as! String?
		}

		/// The date and time when the resource was updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "image":
					if let value = internalGetImage() {
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

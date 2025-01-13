//
//  SitemapResourceInterface.swift
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

/// Represents the common fields for all sitemap resource types. 
public protocol SitemapResourceInterface {
	var handle: String { get }

	var updatedAt: Date { get }
}

extension Storefront {
	/// Represents the common fields for all sitemap resource types. 
	open class SitemapResourceInterfaceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SitemapResourceInterface

		/// Resource's handle. 
		@discardableResult
		open func handle(alias: String? = nil) -> SitemapResourceInterfaceQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// The date and time when the resource was updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> SitemapResourceInterfaceQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents the common fields for all sitemap resource types. 
		@discardableResult
		open func onSitemapResource(subfields: (SitemapResourceQuery) -> Void) -> SitemapResourceInterfaceQuery {
			let subquery = SitemapResourceQuery()
			subfields(subquery)
			addInlineFragment(on: "SitemapResource", subfields: subquery)
			return self
		}

		/// Represents the common fields for all sitemap resource types. 
		@discardableResult
		open func onSitemapResourceMetaobject(subfields: (SitemapResourceMetaobjectQuery) -> Void) -> SitemapResourceInterfaceQuery {
			let subquery = SitemapResourceMetaobjectQuery()
			subfields(subquery)
			addInlineFragment(on: "SitemapResourceMetaobject", subfields: subquery)
			return self
		}
	}

	/// Represents the common fields for all sitemap resource types. 
	open class UnknownSitemapResourceInterface: GraphQL.AbstractResponse, GraphQLObject, SitemapResourceInterface {
		public typealias Query = SitemapResourceInterfaceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownSitemapResourceInterface.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownSitemapResourceInterface.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: UnknownSitemapResourceInterface.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> SitemapResourceInterface {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownSitemapResourceInterface.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "SitemapResource": return try SitemapResource.init(fields: fields)

				case "SitemapResourceMetaobject": return try SitemapResourceMetaobject.init(fields: fields)

				default:
				return try UnknownSitemapResourceInterface.init(fields: fields)
			}
		}

		/// Resource's handle. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// The date and time when the resource was updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

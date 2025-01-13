//
//  SitemapResourceMetaobject.swift
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
	/// A SitemapResourceMetaobject represents a metaobject with [the `renderable` 
	/// capability](https://shopify.dev/docs/apps/build/custom-data/metaobjects/use-metaobject-capabilities#render-metaobjects-as-web-pages). 
	open class SitemapResourceMetaobjectQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SitemapResourceMetaobject

		/// Resource's handle. 
		@discardableResult
		open func handle(alias: String? = nil) -> SitemapResourceMetaobjectQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// The URL handle for accessing pages of this metaobject type in the Online 
		/// Store. 
		@discardableResult
		open func onlineStoreUrlHandle(alias: String? = nil) -> SitemapResourceMetaobjectQuery {
			addField(field: "onlineStoreUrlHandle", aliasSuffix: alias)
			return self
		}

		/// The type of the metaobject. Defines the namespace of its associated 
		/// metafields. 
		@discardableResult
		open func type(alias: String? = nil) -> SitemapResourceMetaobjectQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The date and time when the resource was updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> SitemapResourceMetaobjectQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// A SitemapResourceMetaobject represents a metaobject with [the `renderable` 
	/// capability](https://shopify.dev/docs/apps/build/custom-data/metaobjects/use-metaobject-capabilities#render-metaobjects-as-web-pages). 
	open class SitemapResourceMetaobject: GraphQL.AbstractResponse, GraphQLObject, SitemapResourceInterface {
		public typealias Query = SitemapResourceMetaobjectQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapResourceMetaobject.self, field: fieldName, value: fieldValue)
				}
				return value

				case "onlineStoreUrlHandle":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapResourceMetaobject.self, field: fieldName, value: fieldValue)
				}
				return value

				case "type":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapResourceMetaobject.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapResourceMetaobject.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: SitemapResourceMetaobject.self, field: fieldName, value: fieldValue)
			}
		}

		/// Resource's handle. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// The URL handle for accessing pages of this metaobject type in the Online 
		/// Store. 
		open var onlineStoreUrlHandle: String? {
			return internalGetOnlineStoreUrlHandle()
		}

		func internalGetOnlineStoreUrlHandle(alias: String? = nil) -> String? {
			return field(field: "onlineStoreUrlHandle", aliasSuffix: alias) as! String?
		}

		/// The type of the metaobject. Defines the namespace of its associated 
		/// metafields. 
		open var type: String {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> String {
			return field(field: "type", aliasSuffix: alias) as! String
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

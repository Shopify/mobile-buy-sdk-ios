//
//  SitemapImage.swift
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
	/// Represents a sitemap's image. 
	open class SitemapImageQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SitemapImage

		/// Image's alt text. 
		@discardableResult
		open func alt(alias: String? = nil) -> SitemapImageQuery {
			addField(field: "alt", aliasSuffix: alias)
			return self
		}

		/// Path to the image. 
		@discardableResult
		open func filepath(alias: String? = nil) -> SitemapImageQuery {
			addField(field: "filepath", aliasSuffix: alias)
			return self
		}

		/// The date and time when the image was updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> SitemapImageQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a sitemap's image. 
	open class SitemapImage: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SitemapImageQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "alt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapImage.self, field: fieldName, value: fieldValue)
				}
				return value

				case "filepath":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapImage.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SitemapImage.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: SitemapImage.self, field: fieldName, value: fieldValue)
			}
		}

		/// Image's alt text. 
		open var alt: String? {
			return internalGetAlt()
		}

		func internalGetAlt(alias: String? = nil) -> String? {
			return field(field: "alt", aliasSuffix: alias) as! String?
		}

		/// Path to the image. 
		open var filepath: String? {
			return internalGetFilepath()
		}

		func internalGetFilepath(alias: String? = nil) -> String? {
			return field(field: "filepath", aliasSuffix: alias) as! String?
		}

		/// The date and time when the image was updated. 
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

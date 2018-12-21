//
//  Page.swift
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
	/// Shopify merchants can create pages to hold static HTML content. Each Page 
	/// object represents a custom page on the online store. 
	open class PageQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Page

		/// The description of the page, complete with HTML formatting. 
		@discardableResult
		open func body(alias: String? = nil) -> PageQuery {
			addField(field: "body", aliasSuffix: alias)
			return self
		}

		/// Summary of the page body. 
		@discardableResult
		open func bodySummary(alias: String? = nil) -> PageQuery {
			addField(field: "bodySummary", aliasSuffix: alias)
			return self
		}

		/// The timestamp of the page creation. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> PageQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// A human-friendly unique string for the page automatically generated from 
		/// its title. 
		@discardableResult
		open func handle(alias: String? = nil) -> PageQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> PageQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The title of the page. 
		@discardableResult
		open func title(alias: String? = nil) -> PageQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The timestamp of the latest page update. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> PageQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}

		/// The url pointing to the page accessible from the web. 
		@discardableResult
		open func url(alias: String? = nil) -> PageQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// Shopify merchants can create pages to hold static HTML content. Each Page 
	/// object represents a custom page on the online store. 
	open class Page: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = PageQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "body":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return value

				case "bodySummary":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return value

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
			}
		}

		/// The description of the page, complete with HTML formatting. 
		open var body: String {
			return internalGetBody()
		}

		func internalGetBody(alias: String? = nil) -> String {
			return field(field: "body", aliasSuffix: alias) as! String
		}

		/// Summary of the page body. 
		open var bodySummary: String {
			return internalGetBodySummary()
		}

		func internalGetBodySummary(alias: String? = nil) -> String {
			return field(field: "bodySummary", aliasSuffix: alias) as! String
		}

		/// The timestamp of the page creation. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// A human-friendly unique string for the page automatically generated from 
		/// its title. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The title of the page. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The timestamp of the latest page update. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		/// The url pointing to the page accessible from the web. 
		open var url: URL {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> URL {
			return field(field: "url", aliasSuffix: alias) as! URL
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

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

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> PageQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// Returns a metafield found by namespace and key. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> PageQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> PageQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The URL used for viewing the resource on the shop's Online Store. Returns 
		/// `null` if the resource is currently not published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onlineStoreUrl(alias: String? = nil) -> PageQuery {
			addField(field: "onlineStoreUrl", aliasSuffix: alias)
			return self
		}

		/// The page's SEO information. 
		@discardableResult
		open func seo(alias: String? = nil, _ subfields: (SEOQuery) -> Void) -> PageQuery {
			let subquery = SEOQuery()
			subfields(subquery)

			addField(field: "seo", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The title of the page. 
		@discardableResult
		open func title(alias: String? = nil) -> PageQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// A URL parameters to be added to a page URL when it is linked from a GraphQL 
		/// result. This allows for tracking the origin of the traffic. 
		@discardableResult
		open func trackingParameters(alias: String? = nil) -> PageQuery {
			addField(field: "trackingParameters", aliasSuffix: alias)
			return self
		}

		/// The timestamp of the latest page update. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> PageQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// Shopify merchants can create pages to hold static HTML content. Each Page 
	/// object represents a custom page on the online store. 
	open class Page: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MenuItemResource, MetafieldParentResource, MetafieldReference, Node, OnlineStorePublishable, SearchResultItem, Trackable {
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

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "onlineStoreUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "seo":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return try SEO(fields: value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return value

				case "trackingParameters":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Page.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

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

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// Returns a metafield found by namespace and key. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		open var metafields: [Storefront.Metafield?] {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> [Storefront.Metafield?] {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield?] {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield?]
		}

		/// The URL used for viewing the resource on the shop's Online Store. Returns 
		/// `null` if the resource is currently not published to the Online Store sales 
		/// channel. 
		open var onlineStoreUrl: URL? {
			return internalGetOnlineStoreUrl()
		}

		func internalGetOnlineStoreUrl(alias: String? = nil) -> URL? {
			return field(field: "onlineStoreUrl", aliasSuffix: alias) as! URL?
		}

		/// The page's SEO information. 
		open var seo: Storefront.SEO? {
			return internalGetSeo()
		}

		func internalGetSeo(alias: String? = nil) -> Storefront.SEO? {
			return field(field: "seo", aliasSuffix: alias) as! Storefront.SEO?
		}

		/// The title of the page. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// A URL parameters to be added to a page URL when it is linked from a GraphQL 
		/// result. This allows for tracking the origin of the traffic. 
		open var trackingParameters: String? {
			return internalGetTrackingParameters()
		}

		func internalGetTrackingParameters(alias: String? = nil) -> String? {
			return field(field: "trackingParameters", aliasSuffix: alias) as! String?
		}

		/// The timestamp of the latest page update. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					internalGetMetafields().forEach {
						if let value = $0 {
							response.append(value)
							response.append(contentsOf: value.childResponseObjectMap())
						}
					}

					case "seo":
					if let value = internalGetSeo() {
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

//
//  Article.swift
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
	/// An article in an online store blog. 
	open class ArticleQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Article

		/// The article's author. 
		@available(*, deprecated, message: "Use `authorV2` instead.")
		@discardableResult
		open func author(alias: String? = nil, _ subfields: (ArticleAuthorQuery) -> Void) -> ArticleQuery {
			let subquery = ArticleAuthorQuery()
			subfields(subquery)

			addField(field: "author", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The article's author. 
		@discardableResult
		open func authorV2(alias: String? = nil, _ subfields: (ArticleAuthorQuery) -> Void) -> ArticleQuery {
			let subquery = ArticleAuthorQuery()
			subfields(subquery)

			addField(field: "authorV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The blog that the article belongs to. 
		@discardableResult
		open func blog(alias: String? = nil, _ subfields: (BlogQuery) -> Void) -> ArticleQuery {
			let subquery = BlogQuery()
			subfields(subquery)

			addField(field: "blog", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// List of comments posted on the article. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func comments(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (CommentConnectionQuery) -> Void) -> ArticleQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CommentConnectionQuery()
			subfields(subquery)

			addField(field: "comments", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Stripped content of the article, single line with HTML tags removed. 
		///
		/// - parameters:
		///     - truncateAt: Truncates a string after the given length.
		///
		@discardableResult
		open func content(alias: String? = nil, truncateAt: Int32? = nil) -> ArticleQuery {
			var args: [String] = []

			if let truncateAt = truncateAt {
				args.append("truncateAt:\(truncateAt)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "content", aliasSuffix: alias, args: argsString)
			return self
		}

		/// The content of the article, complete with HTML formatting. 
		@discardableResult
		open func contentHtml(alias: String? = nil) -> ArticleQuery {
			addField(field: "contentHtml", aliasSuffix: alias)
			return self
		}

		/// Stripped excerpt of the article, single line with HTML tags removed. 
		///
		/// - parameters:
		///     - truncateAt: Truncates a string after the given length.
		///
		@discardableResult
		open func excerpt(alias: String? = nil, truncateAt: Int32? = nil) -> ArticleQuery {
			var args: [String] = []

			if let truncateAt = truncateAt {
				args.append("truncateAt:\(truncateAt)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "excerpt", aliasSuffix: alias, args: argsString)
			return self
		}

		/// The excerpt of the article, complete with HTML formatting. 
		@discardableResult
		open func excerptHtml(alias: String? = nil) -> ArticleQuery {
			addField(field: "excerptHtml", aliasSuffix: alias)
			return self
		}

		/// A human-friendly unique string for the Article automatically generated from 
		/// its title. 
		@discardableResult
		open func handle(alias: String? = nil) -> ArticleQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ArticleQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The image associated with the article. 
		@discardableResult
		open func image(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> ArticleQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A [custom field](https://shopify.dev/docs/apps/build/custom-data), 
		/// including its `namespace` and `key`, that's associated with a Shopify 
		/// resource for the purposes of adding and storing additional information. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> ArticleQuery {
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

		/// A list of [custom fields](/docs/apps/build/custom-data) that a merchant 
		/// associates with a Shopify resource. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> ArticleQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map { "\($0.serialize())" }.joined(separator: ","))]")

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
		open func onlineStoreUrl(alias: String? = nil) -> ArticleQuery {
			addField(field: "onlineStoreUrl", aliasSuffix: alias)
			return self
		}

		/// The date and time when the article was published. 
		@discardableResult
		open func publishedAt(alias: String? = nil) -> ArticleQuery {
			addField(field: "publishedAt", aliasSuffix: alias)
			return self
		}

		/// The article’s SEO information. 
		@discardableResult
		open func seo(alias: String? = nil, _ subfields: (SEOQuery) -> Void) -> ArticleQuery {
			let subquery = SEOQuery()
			subfields(subquery)

			addField(field: "seo", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A categorization that a article can be tagged with. 
		@discardableResult
		open func tags(alias: String? = nil) -> ArticleQuery {
			addField(field: "tags", aliasSuffix: alias)
			return self
		}

		/// The article’s name. 
		@discardableResult
		open func title(alias: String? = nil) -> ArticleQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// URL parameters to be added to a page URL to track the origin of on-site 
		/// search traffic for [analytics 
		/// reporting](https://help.shopify.com/manual/reports-and-analytics/shopify-reports/report-types/default-reports/behaviour-reports). 
		/// Returns a result when accessed through the 
		/// [search](https://shopify.dev/docs/api/storefront/current/queries/search) or 
		/// [predictiveSearch](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch) 
		/// queries, otherwise returns null. 
		@discardableResult
		open func trackingParameters(alias: String? = nil) -> ArticleQuery {
			addField(field: "trackingParameters", aliasSuffix: alias)
			return self
		}
	}

	/// An article in an online store blog. 
	open class Article: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MenuItemResource, MetafieldParentResource, Node, OnlineStorePublishable, SearchResultItem, Trackable {
		public typealias Query = ArticleQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "author":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try ArticleAuthor(fields: value)

				case "authorV2":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try ArticleAuthor(fields: value)

				case "blog":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try Blog(fields: value)

				case "comments":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try CommentConnection(fields: value)

				case "content":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value

				case "contentHtml":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value

				case "excerpt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value

				case "excerptHtml":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "onlineStoreUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "publishedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "seo":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return try SEO(fields: value)

				case "tags":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value

				case "trackingParameters":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Article.self, field: fieldName, value: fieldValue)
			}
		}

		/// The article's author. 
		@available(*, deprecated, message: "Use `authorV2` instead.")
		open var author: Storefront.ArticleAuthor {
			return internalGetAuthor()
		}

		func internalGetAuthor(alias: String? = nil) -> Storefront.ArticleAuthor {
			return field(field: "author", aliasSuffix: alias) as! Storefront.ArticleAuthor
		}

		/// The article's author. 
		open var authorV2: Storefront.ArticleAuthor? {
			return internalGetAuthorV2()
		}

		func internalGetAuthorV2(alias: String? = nil) -> Storefront.ArticleAuthor? {
			return field(field: "authorV2", aliasSuffix: alias) as! Storefront.ArticleAuthor?
		}

		/// The blog that the article belongs to. 
		open var blog: Storefront.Blog {
			return internalGetBlog()
		}

		func internalGetBlog(alias: String? = nil) -> Storefront.Blog {
			return field(field: "blog", aliasSuffix: alias) as! Storefront.Blog
		}

		/// List of comments posted on the article. 
		open var comments: Storefront.CommentConnection {
			return internalGetComments()
		}

		open func aliasedComments(alias: String) -> Storefront.CommentConnection {
			return internalGetComments(alias: alias)
		}

		func internalGetComments(alias: String? = nil) -> Storefront.CommentConnection {
			return field(field: "comments", aliasSuffix: alias) as! Storefront.CommentConnection
		}

		/// Stripped content of the article, single line with HTML tags removed. 
		open var content: String {
			return internalGetContent()
		}

		open func aliasedContent(alias: String) -> String {
			return internalGetContent(alias: alias)
		}

		func internalGetContent(alias: String? = nil) -> String {
			return field(field: "content", aliasSuffix: alias) as! String
		}

		/// The content of the article, complete with HTML formatting. 
		open var contentHtml: String {
			return internalGetContentHtml()
		}

		func internalGetContentHtml(alias: String? = nil) -> String {
			return field(field: "contentHtml", aliasSuffix: alias) as! String
		}

		/// Stripped excerpt of the article, single line with HTML tags removed. 
		open var excerpt: String? {
			return internalGetExcerpt()
		}

		open func aliasedExcerpt(alias: String) -> String? {
			return internalGetExcerpt(alias: alias)
		}

		func internalGetExcerpt(alias: String? = nil) -> String? {
			return field(field: "excerpt", aliasSuffix: alias) as! String?
		}

		/// The excerpt of the article, complete with HTML formatting. 
		open var excerptHtml: String? {
			return internalGetExcerptHtml()
		}

		func internalGetExcerptHtml(alias: String? = nil) -> String? {
			return field(field: "excerptHtml", aliasSuffix: alias) as! String?
		}

		/// A human-friendly unique string for the Article automatically generated from 
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

		/// The image associated with the article. 
		open var image: Storefront.Image? {
			return internalGetImage()
		}

		func internalGetImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.Image?
		}

		/// A [custom field](https://shopify.dev/docs/apps/build/custom-data), 
		/// including its `namespace` and `key`, that's associated with a Shopify 
		/// resource for the purposes of adding and storing additional information. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// A list of [custom fields](/docs/apps/build/custom-data) that a merchant 
		/// associates with a Shopify resource. 
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

		/// The date and time when the article was published. 
		open var publishedAt: Date {
			return internalGetPublishedAt()
		}

		func internalGetPublishedAt(alias: String? = nil) -> Date {
			return field(field: "publishedAt", aliasSuffix: alias) as! Date
		}

		/// The article’s SEO information. 
		open var seo: Storefront.SEO? {
			return internalGetSeo()
		}

		func internalGetSeo(alias: String? = nil) -> Storefront.SEO? {
			return field(field: "seo", aliasSuffix: alias) as! Storefront.SEO?
		}

		/// A categorization that a article can be tagged with. 
		open var tags: [String] {
			return internalGetTags()
		}

		func internalGetTags(alias: String? = nil) -> [String] {
			return field(field: "tags", aliasSuffix: alias) as! [String]
		}

		/// The article’s name. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// URL parameters to be added to a page URL to track the origin of on-site 
		/// search traffic for [analytics 
		/// reporting](https://help.shopify.com/manual/reports-and-analytics/shopify-reports/report-types/default-reports/behaviour-reports). 
		/// Returns a result when accessed through the 
		/// [search](https://shopify.dev/docs/api/storefront/current/queries/search) or 
		/// [predictiveSearch](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch) 
		/// queries, otherwise returns null. 
		open var trackingParameters: String? {
			return internalGetTrackingParameters()
		}

		func internalGetTrackingParameters(alias: String? = nil) -> String? {
			return field(field: "trackingParameters", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "author":
					response.append(internalGetAuthor())
					response.append(contentsOf: internalGetAuthor().childResponseObjectMap())

					case "authorV2":
					if let value = internalGetAuthorV2() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "blog":
					response.append(internalGetBlog())
					response.append(contentsOf: internalGetBlog().childResponseObjectMap())

					case "comments":
					response.append(internalGetComments())
					response.append(contentsOf: internalGetComments().childResponseObjectMap())

					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

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

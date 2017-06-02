//
//  Article.swift
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
	open class ArticleQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Article

		/// The article's author. 
		@discardableResult
		open func author(alias: String? = nil, _ subfields: (ArticleAuthorQuery) -> Void) -> ArticleQuery {
			let subquery = ArticleAuthorQuery()
			subfields(subquery)

			addField(field: "author", aliasSuffix: alias, subfields: subquery)
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
		///     - first: No description
		///     - after: No description
		///     - reverse: No description
		///
		@discardableResult
		open func comments(alias: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (CommentConnectionQuery) -> Void) -> ArticleQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
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
		///     - truncateAt: Truncates string after the given length.
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
		///     - truncateAt: Truncates string after the given length.
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

		@discardableResult
		open func id(alias: String? = nil) -> ArticleQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The image associated with the article. 
		///
		/// - parameters:
		///     - maxWidth: Image width in pixels between 1 and 2048
		///     - maxHeight: Image height in pixels between 1 and 2048
		///     - crop: If specified, crop the image keeping the specified region
		///     - scale: Image size multiplier retina displays. Must be between 1 and 3
		///
		@discardableResult
		open func image(alias: String? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageQuery) -> Void) -> ArticleQuery {
			var args: [String] = []

			if let maxWidth = maxWidth {
				args.append("maxWidth:\(maxWidth)")
			}

			if let maxHeight = maxHeight {
				args.append("maxHeight:\(maxHeight)")
			}

			if let crop = crop {
				args.append("crop:\(crop.rawValue)")
			}

			if let scale = scale {
				args.append("scale:\(scale)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The date and time when the article was published. 
		@discardableResult
		open func publishedAt(alias: String? = nil) -> ArticleQuery {
			addField(field: "publishedAt", aliasSuffix: alias)
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

		/// The url pointing to the article accessible from the web. 
		@discardableResult
		open func url(alias: String? = nil) -> ArticleQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	open class Article: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = ArticleQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "author":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ArticleAuthor(fields: value)

				case "blog":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Blog(fields: value)

				case "comments":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CommentConnection(fields: value)

				case "content":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "contentHtml":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "excerpt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "excerptHtml":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "publishedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "tags":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The article's author. 
		open var author: Storefront.ArticleAuthor {
			return internalGetAuthor()
		}

		func internalGetAuthor(alias: String? = nil) -> Storefront.ArticleAuthor {
			return field(field: "author", aliasSuffix: alias) as! Storefront.ArticleAuthor
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

		open func aliasedImage(alias: String) -> Storefront.Image? {
			return internalGetImage(alias: alias)
		}

		func internalGetImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.Image?
		}

		/// The date and time when the article was published. 
		open var publishedAt: Date {
			return internalGetPublishedAt()
		}

		func internalGetPublishedAt(alias: String? = nil) -> Date {
			return field(field: "publishedAt", aliasSuffix: alias) as! Date
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

		/// The url pointing to the article accessible from the web. 
		open var url: URL {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> URL {
			return field(field: "url", aliasSuffix: alias) as! URL
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "author":
					response.append(internalGetAuthor())
					response.append(contentsOf: internalGetAuthor().childResponseObjectMap())

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

					default:
					break
				}
			}
			return response
		}
	}
}

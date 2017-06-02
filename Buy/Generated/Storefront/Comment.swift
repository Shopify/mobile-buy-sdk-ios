//
//  Comment.swift
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
	open class CommentQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Comment

		/// The comment’s author. 
		@discardableResult
		open func author(alias: String? = nil, _ subfields: (CommentAuthorQuery) -> Void) -> CommentQuery {
			let subquery = CommentAuthorQuery()
			subfields(subquery)

			addField(field: "author", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Stripped content of the comment, single line with HTML tags removed. 
		///
		/// - parameters:
		///     - truncateAt: Truncates string after the given length.
		///
		@discardableResult
		open func content(alias: String? = nil, truncateAt: Int32? = nil) -> CommentQuery {
			var args: [String] = []

			if let truncateAt = truncateAt {
				args.append("truncateAt:\(truncateAt)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "content", aliasSuffix: alias, args: argsString)
			return self
		}

		/// The content of the comment, complete with HTML formatting. 
		@discardableResult
		open func contentHtml(alias: String? = nil) -> CommentQuery {
			addField(field: "contentHtml", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func id(alias: String? = nil) -> CommentQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}
	}

	open class Comment: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CommentQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "author":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CommentAuthor(fields: value)

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

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The comment’s author. 
		open var author: Storefront.CommentAuthor {
			return internalGetAuthor()
		}

		func internalGetAuthor(alias: String? = nil) -> Storefront.CommentAuthor {
			return field(field: "author", aliasSuffix: alias) as! Storefront.CommentAuthor
		}

		/// Stripped content of the comment, single line with HTML tags removed. 
		open var content: String {
			return internalGetContent()
		}

		open func aliasedContent(alias: String) -> String {
			return internalGetContent(alias: alias)
		}

		func internalGetContent(alias: String? = nil) -> String {
			return field(field: "content", aliasSuffix: alias) as! String
		}

		/// The content of the comment, complete with HTML formatting. 
		open var contentHtml: String {
			return internalGetContentHtml()
		}

		func internalGetContentHtml(alias: String? = nil) -> String {
			return field(field: "contentHtml", aliasSuffix: alias) as! String
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "author":
					response.append(internalGetAuthor())
					response.append(contentsOf: internalGetAuthor().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

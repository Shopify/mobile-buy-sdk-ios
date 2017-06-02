//
//  ArticleAuthor.swift
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
	open class ArticleAuthorQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ArticleAuthor

		/// The author's bio. 
		@discardableResult
		open func bio(alias: String? = nil) -> ArticleAuthorQuery {
			addField(field: "bio", aliasSuffix: alias)
			return self
		}

		/// The author’s email. 
		@discardableResult
		open func email(alias: String? = nil) -> ArticleAuthorQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		/// The author's first name. 
		@discardableResult
		open func firstName(alias: String? = nil) -> ArticleAuthorQuery {
			addField(field: "firstName", aliasSuffix: alias)
			return self
		}

		/// The author's last name. 
		@discardableResult
		open func lastName(alias: String? = nil) -> ArticleAuthorQuery {
			addField(field: "lastName", aliasSuffix: alias)
			return self
		}

		/// The author's full name 
		@discardableResult
		open func name(alias: String? = nil) -> ArticleAuthorQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}
	}

	open class ArticleAuthor: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ArticleAuthorQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "bio":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "email":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "firstName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "lastName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The author's bio. 
		open var bio: String? {
			return internalGetBio()
		}

		func internalGetBio(alias: String? = nil) -> String? {
			return field(field: "bio", aliasSuffix: alias) as! String?
		}

		/// The author’s email. 
		open var email: String {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String {
			return field(field: "email", aliasSuffix: alias) as! String
		}

		/// The author's first name. 
		open var firstName: String {
			return internalGetFirstName()
		}

		func internalGetFirstName(alias: String? = nil) -> String {
			return field(field: "firstName", aliasSuffix: alias) as! String
		}

		/// The author's last name. 
		open var lastName: String {
			return internalGetLastName()
		}

		func internalGetLastName(alias: String? = nil) -> String {
			return field(field: "lastName", aliasSuffix: alias) as! String
		}

		/// The author's full name 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

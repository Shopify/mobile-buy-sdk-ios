//
//  UrlRedirect.swift
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
	/// A redirect on the online store. 
	open class UrlRedirectQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = UrlRedirect

		/// The ID of the URL redirect. 
		@discardableResult
		open func id(alias: String? = nil) -> UrlRedirectQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The old path to be redirected from. When the user visits this path, they'll 
		/// be redirected to the target location. 
		@discardableResult
		open func path(alias: String? = nil) -> UrlRedirectQuery {
			addField(field: "path", aliasSuffix: alias)
			return self
		}

		/// The target location where the user will be redirected to. 
		@discardableResult
		open func target(alias: String? = nil) -> UrlRedirectQuery {
			addField(field: "target", aliasSuffix: alias)
			return self
		}
	}

	/// A redirect on the online store. 
	open class UrlRedirect: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = UrlRedirectQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UrlRedirect.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "path":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UrlRedirect.self, field: fieldName, value: fieldValue)
				}
				return value

				case "target":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UrlRedirect.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: UrlRedirect.self, field: fieldName, value: fieldValue)
			}
		}

		/// The ID of the URL redirect. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The old path to be redirected from. When the user visits this path, they'll 
		/// be redirected to the target location. 
		open var path: String {
			return internalGetPath()
		}

		func internalGetPath(alias: String? = nil) -> String {
			return field(field: "path", aliasSuffix: alias) as! String
		}

		/// The target location where the user will be redirected to. 
		open var target: String {
			return internalGetTarget()
		}

		func internalGetTarget(alias: String? = nil) -> String {
			return field(field: "target", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

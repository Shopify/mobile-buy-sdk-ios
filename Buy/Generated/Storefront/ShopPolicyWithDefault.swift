//
//  ShopPolicyWithDefault.swift
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
	/// A policy for the store that comes with a default value, such as a 
	/// subscription policy. If the merchant hasn't configured a policy for their 
	/// store, then the policy will return the default value. Otherwise, the policy 
	/// will return the merchant-configured value. 
	open class ShopPolicyWithDefaultQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPolicyWithDefault

		/// The text of the policy. Maximum size: 64KB. 
		@discardableResult
		open func body(alias: String? = nil) -> ShopPolicyWithDefaultQuery {
			addField(field: "body", aliasSuffix: alias)
			return self
		}

		/// The handle of the policy. 
		@discardableResult
		open func handle(alias: String? = nil) -> ShopPolicyWithDefaultQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// The unique ID of the policy. A default policy doesn't have an ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ShopPolicyWithDefaultQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The title of the policy. 
		@discardableResult
		open func title(alias: String? = nil) -> ShopPolicyWithDefaultQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// Public URL to the policy. 
		@discardableResult
		open func url(alias: String? = nil) -> ShopPolicyWithDefaultQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// A policy for the store that comes with a default value, such as a 
	/// subscription policy. If the merchant hasn't configured a policy for their 
	/// store, then the policy will return the default value. Otherwise, the policy 
	/// will return the merchant-configured value. 
	open class ShopPolicyWithDefault: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPolicyWithDefaultQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "body":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPolicyWithDefault.self, field: fieldName, value: fieldValue)
				}
				return value

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPolicyWithDefault.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPolicyWithDefault.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPolicyWithDefault.self, field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPolicyWithDefault.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: ShopPolicyWithDefault.self, field: fieldName, value: fieldValue)
			}
		}

		/// The text of the policy. Maximum size: 64KB. 
		open var body: String {
			return internalGetBody()
		}

		func internalGetBody(alias: String? = nil) -> String {
			return field(field: "body", aliasSuffix: alias) as! String
		}

		/// The handle of the policy. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// The unique ID of the policy. A default policy doesn't have an ID. 
		open var id: GraphQL.ID? {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID? {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID?
		}

		/// The title of the policy. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// Public URL to the policy. 
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

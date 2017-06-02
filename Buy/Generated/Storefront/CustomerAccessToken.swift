//
//  CustomerAccessToken.swift
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
	/// A CustomerAccessToken represents the unique token required to make 
	/// modifications to the customer object. 
	open class CustomerAccessTokenQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CustomerAccessToken

		/// The customer’s access token. 
		@discardableResult
		open func accessToken(alias: String? = nil) -> CustomerAccessTokenQuery {
			addField(field: "accessToken", aliasSuffix: alias)
			return self
		}

		/// The date and time when the customer access token expires. 
		@discardableResult
		open func expiresAt(alias: String? = nil) -> CustomerAccessTokenQuery {
			addField(field: "expiresAt", aliasSuffix: alias)
			return self
		}
	}

	/// A CustomerAccessToken represents the unique token required to make 
	/// modifications to the customer object. 
	open class CustomerAccessToken: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CustomerAccessTokenQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "accessToken":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "expiresAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The customer’s access token. 
		open var accessToken: String {
			return internalGetAccessToken()
		}

		func internalGetAccessToken(alias: String? = nil) -> String {
			return field(field: "accessToken", aliasSuffix: alias) as! String
		}

		/// The date and time when the customer access token expires. 
		open var expiresAt: Date {
			return internalGetExpiresAt()
		}

		func internalGetExpiresAt(alias: String? = nil) -> Date {
			return field(field: "expiresAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

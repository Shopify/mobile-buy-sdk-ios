//
//  CartCompletionSuccess.swift
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
	/// A successful completion to checkout a cart and a created order. 
	open class CartCompletionSuccessQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCompletionSuccess

		/// The date and time when the job completed. 
		@discardableResult
		open func completedAt(alias: String? = nil) -> CartCompletionSuccessQuery {
			addField(field: "completedAt", aliasSuffix: alias)
			return self
		}

		/// The ID of the cart completion attempt. 
		@discardableResult
		open func id(alias: String? = nil) -> CartCompletionSuccessQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The ID of the order that's created in Shopify. 
		@discardableResult
		open func orderId(alias: String? = nil) -> CartCompletionSuccessQuery {
			addField(field: "orderId", aliasSuffix: alias)
			return self
		}

		/// The URL of the order confirmation in Shopify. 
		@discardableResult
		open func orderUrl(alias: String? = nil) -> CartCompletionSuccessQuery {
			addField(field: "orderUrl", aliasSuffix: alias)
			return self
		}
	}

	/// A successful completion to checkout a cart and a created order. 
	open class CartCompletionSuccess: GraphQL.AbstractResponse, GraphQLObject, CartCompletionAttemptResult {
		public typealias Query = CartCompletionSuccessQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "completedAt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCompletionSuccess.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCompletionSuccess.self, field: fieldName, value: fieldValue)
				}
				return value

				case "orderId":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCompletionSuccess.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "orderUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCompletionSuccess.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: CartCompletionSuccess.self, field: fieldName, value: fieldValue)
			}
		}

		/// The date and time when the job completed. 
		open var completedAt: Date? {
			return internalGetCompletedAt()
		}

		func internalGetCompletedAt(alias: String? = nil) -> Date? {
			return field(field: "completedAt", aliasSuffix: alias) as! Date?
		}

		/// The ID of the cart completion attempt. 
		open var id: String {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> String {
			return field(field: "id", aliasSuffix: alias) as! String
		}

		/// The ID of the order that's created in Shopify. 
		open var orderId: GraphQL.ID {
			return internalGetOrderId()
		}

		func internalGetOrderId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "orderId", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The URL of the order confirmation in Shopify. 
		open var orderUrl: URL {
			return internalGetOrderUrl()
		}

		func internalGetOrderUrl(alias: String? = nil) -> URL {
			return field(field: "orderUrl", aliasSuffix: alias) as! URL
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

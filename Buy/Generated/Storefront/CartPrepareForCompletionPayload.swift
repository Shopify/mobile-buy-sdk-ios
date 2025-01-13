//
//  CartPrepareForCompletionPayload.swift
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
	/// Return type for `cartPrepareForCompletion` mutation. 
	open class CartPrepareForCompletionPayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartPrepareForCompletionPayload

		/// The result of cart preparation for completion. 
		@discardableResult
		open func result(alias: String? = nil, _ subfields: (CartPrepareForCompletionResultQuery) -> Void) -> CartPrepareForCompletionPayloadQuery {
			let subquery = CartPrepareForCompletionResultQuery()
			subfields(subquery)

			addField(field: "result", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The list of errors that occurred from executing the mutation. 
		@discardableResult
		open func userErrors(alias: String? = nil, _ subfields: (CartUserErrorQuery) -> Void) -> CartPrepareForCompletionPayloadQuery {
			let subquery = CartUserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Return type for `cartPrepareForCompletion` mutation. 
	open class CartPrepareForCompletionPayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartPrepareForCompletionPayloadQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "result":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartPrepareForCompletionPayload.self, field: fieldName, value: fieldValue)
				}
				return try UnknownCartPrepareForCompletionResult.create(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartPrepareForCompletionPayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CartUserError(fields: $0) }

				default:
				throw SchemaViolationError(type: CartPrepareForCompletionPayload.self, field: fieldName, value: fieldValue)
			}
		}

		/// The result of cart preparation for completion. 
		open var result: CartPrepareForCompletionResult? {
			return internalGetResult()
		}

		func internalGetResult(alias: String? = nil) -> CartPrepareForCompletionResult? {
			return field(field: "result", aliasSuffix: alias) as! CartPrepareForCompletionResult?
		}

		/// The list of errors that occurred from executing the mutation. 
		open var userErrors: [Storefront.CartUserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(alias: String? = nil) -> [Storefront.CartUserError] {
			return field(field: "userErrors", aliasSuffix: alias) as! [Storefront.CartUserError]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

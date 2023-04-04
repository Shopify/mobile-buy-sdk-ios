//
//  CartCompletionFailed.swift
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
	/// A failed completion to checkout a cart. 
	open class CartCompletionFailedQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCompletionFailed

		/// The errors that caused the checkout to fail. 
		@discardableResult
		open func errors(alias: String? = nil, _ subfields: (CompletionErrorQuery) -> Void) -> CartCompletionFailedQuery {
			let subquery = CompletionErrorQuery()
			subfields(subquery)

			addField(field: "errors", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The ID of the cart completion attempt. 
		@discardableResult
		open func id(alias: String? = nil) -> CartCompletionFailedQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}
	}

	/// A failed completion to checkout a cart. 
	open class CartCompletionFailed: GraphQL.AbstractResponse, GraphQLObject, CartCompletionAttemptResult {
		public typealias Query = CartCompletionFailedQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "errors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartCompletionFailed.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CompletionError(fields: $0) }

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCompletionFailed.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartCompletionFailed.self, field: fieldName, value: fieldValue)
			}
		}

		/// The errors that caused the checkout to fail. 
		open var errors: [Storefront.CompletionError] {
			return internalGetErrors()
		}

		func internalGetErrors(alias: String? = nil) -> [Storefront.CompletionError] {
			return field(field: "errors", aliasSuffix: alias) as! [Storefront.CompletionError]
		}

		/// The ID of the cart completion attempt. 
		open var id: String {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> String {
			return field(field: "id", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

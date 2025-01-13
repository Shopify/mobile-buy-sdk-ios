//
//  CartPrepareForCompletionResult.swift
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

/// The result of cart preparation. 
public protocol CartPrepareForCompletionResult {
}

extension Storefront {
	/// The result of cart preparation. 
	open class CartPrepareForCompletionResultQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartPrepareForCompletionResult

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// The result of cart preparation. 
		@discardableResult
		open func onCartStatusNotReady(subfields: (CartStatusNotReadyQuery) -> Void) -> CartPrepareForCompletionResultQuery {
			let subquery = CartStatusNotReadyQuery()
			subfields(subquery)
			addInlineFragment(on: "CartStatusNotReady", subfields: subquery)
			return self
		}

		/// The result of cart preparation. 
		@discardableResult
		open func onCartStatusReady(subfields: (CartStatusReadyQuery) -> Void) -> CartPrepareForCompletionResultQuery {
			let subquery = CartStatusReadyQuery()
			subfields(subquery)
			addInlineFragment(on: "CartStatusReady", subfields: subquery)
			return self
		}

		/// The result of cart preparation. 
		@discardableResult
		open func onCartThrottled(subfields: (CartThrottledQuery) -> Void) -> CartPrepareForCompletionResultQuery {
			let subquery = CartThrottledQuery()
			subfields(subquery)
			addInlineFragment(on: "CartThrottled", subfields: subquery)
			return self
		}
	}

	/// The result of cart preparation. 
	open class UnknownCartPrepareForCompletionResult: GraphQL.AbstractResponse, GraphQLObject, CartPrepareForCompletionResult {
		public typealias Query = CartPrepareForCompletionResultQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownCartPrepareForCompletionResult.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> CartPrepareForCompletionResult {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownCartPrepareForCompletionResult.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "CartStatusNotReady": return try CartStatusNotReady.init(fields: fields)

				case "CartStatusReady": return try CartStatusReady.init(fields: fields)

				case "CartThrottled": return try CartThrottled.init(fields: fields)

				default:
				return try UnknownCartPrepareForCompletionResult.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

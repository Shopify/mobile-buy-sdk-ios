//
//  CartCompletionAttemptResult.swift
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

/// The result of a cart completion attempt. 
public protocol CartCompletionAttemptResult {
}

extension Storefront {
	/// The result of a cart completion attempt. 
	open class CartCompletionAttemptResultQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCompletionAttemptResult

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// The result of a cart completion attempt. 
		@discardableResult
		open func onCartCompletionActionRequired(subfields: (CartCompletionActionRequiredQuery) -> Void) -> CartCompletionAttemptResultQuery {
			let subquery = CartCompletionActionRequiredQuery()
			subfields(subquery)
			addInlineFragment(on: "CartCompletionActionRequired", subfields: subquery)
			return self
		}

		/// The result of a cart completion attempt. 
		@discardableResult
		open func onCartCompletionFailed(subfields: (CartCompletionFailedQuery) -> Void) -> CartCompletionAttemptResultQuery {
			let subquery = CartCompletionFailedQuery()
			subfields(subquery)
			addInlineFragment(on: "CartCompletionFailed", subfields: subquery)
			return self
		}

		/// The result of a cart completion attempt. 
		@discardableResult
		open func onCartCompletionProcessing(subfields: (CartCompletionProcessingQuery) -> Void) -> CartCompletionAttemptResultQuery {
			let subquery = CartCompletionProcessingQuery()
			subfields(subquery)
			addInlineFragment(on: "CartCompletionProcessing", subfields: subquery)
			return self
		}

		/// The result of a cart completion attempt. 
		@discardableResult
		open func onCartCompletionSuccess(subfields: (CartCompletionSuccessQuery) -> Void) -> CartCompletionAttemptResultQuery {
			let subquery = CartCompletionSuccessQuery()
			subfields(subquery)
			addInlineFragment(on: "CartCompletionSuccess", subfields: subquery)
			return self
		}
	}

	/// The result of a cart completion attempt. 
	open class UnknownCartCompletionAttemptResult: GraphQL.AbstractResponse, GraphQLObject, CartCompletionAttemptResult {
		public typealias Query = CartCompletionAttemptResultQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownCartCompletionAttemptResult.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> CartCompletionAttemptResult {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownCartCompletionAttemptResult.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "CartCompletionActionRequired": return try CartCompletionActionRequired.init(fields: fields)

				case "CartCompletionFailed": return try CartCompletionFailed.init(fields: fields)

				case "CartCompletionProcessing": return try CartCompletionProcessing.init(fields: fields)

				case "CartCompletionSuccess": return try CartCompletionSuccess.init(fields: fields)

				default:
				return try UnknownCartCompletionAttemptResult.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

//
//  CartSubmitForCompletionResult.swift
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

/// The result of cart submit completion. 
public protocol CartSubmitForCompletionResult {
}

extension Storefront {
	/// The result of cart submit completion. 
	open class CartSubmitForCompletionResultQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartSubmitForCompletionResult

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// The result of cart submit completion. 
		@discardableResult
		open func onSubmitAlreadyAccepted(subfields: (SubmitAlreadyAcceptedQuery) -> Void) -> CartSubmitForCompletionResultQuery {
			let subquery = SubmitAlreadyAcceptedQuery()
			subfields(subquery)
			addInlineFragment(on: "SubmitAlreadyAccepted", subfields: subquery)
			return self
		}

		/// The result of cart submit completion. 
		@discardableResult
		open func onSubmitFailed(subfields: (SubmitFailedQuery) -> Void) -> CartSubmitForCompletionResultQuery {
			let subquery = SubmitFailedQuery()
			subfields(subquery)
			addInlineFragment(on: "SubmitFailed", subfields: subquery)
			return self
		}

		/// The result of cart submit completion. 
		@discardableResult
		open func onSubmitSuccess(subfields: (SubmitSuccessQuery) -> Void) -> CartSubmitForCompletionResultQuery {
			let subquery = SubmitSuccessQuery()
			subfields(subquery)
			addInlineFragment(on: "SubmitSuccess", subfields: subquery)
			return self
		}

		/// The result of cart submit completion. 
		@discardableResult
		open func onSubmitThrottled(subfields: (SubmitThrottledQuery) -> Void) -> CartSubmitForCompletionResultQuery {
			let subquery = SubmitThrottledQuery()
			subfields(subquery)
			addInlineFragment(on: "SubmitThrottled", subfields: subquery)
			return self
		}
	}

	/// The result of cart submit completion. 
	open class UnknownCartSubmitForCompletionResult: GraphQL.AbstractResponse, GraphQLObject, CartSubmitForCompletionResult {
		public typealias Query = CartSubmitForCompletionResultQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownCartSubmitForCompletionResult.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> CartSubmitForCompletionResult {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownCartSubmitForCompletionResult.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "SubmitAlreadyAccepted": return try SubmitAlreadyAccepted.init(fields: fields)

				case "SubmitFailed": return try SubmitFailed.init(fields: fields)

				case "SubmitSuccess": return try SubmitSuccess.init(fields: fields)

				case "SubmitThrottled": return try SubmitThrottled.init(fields: fields)

				default:
				return try UnknownCartSubmitForCompletionResult.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

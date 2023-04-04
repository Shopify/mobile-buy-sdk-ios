//
//  CartCompletionAction.swift
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

/// The completion action to checkout a cart. 
public protocol CartCompletionAction {
}

extension Storefront {
	/// The completion action to checkout a cart. 
	open class CartCompletionActionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCompletionAction

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// The completion action to checkout a cart. 
		@discardableResult
		open func onCompletePaymentChallenge(subfields: (CompletePaymentChallengeQuery) -> Void) -> CartCompletionActionQuery {
			let subquery = CompletePaymentChallengeQuery()
			subfields(subquery)
			addInlineFragment(on: "CompletePaymentChallenge", subfields: subquery)
			return self
		}
	}

	/// The completion action to checkout a cart. 
	open class UnknownCartCompletionAction: GraphQL.AbstractResponse, GraphQLObject, CartCompletionAction {
		public typealias Query = CartCompletionActionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownCartCompletionAction.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> CartCompletionAction {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownCartCompletionAction.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "CompletePaymentChallenge": return try CompletePaymentChallenge.init(fields: fields)

				default:
				return try UnknownCartCompletionAction.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

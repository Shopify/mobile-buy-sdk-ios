//
//  CartCompletionActionRequired.swift
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
	/// The required completion action to checkout a cart. 
	open class CartCompletionActionRequiredQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCompletionActionRequired

		/// The action required to complete the cart completion attempt. 
		@discardableResult
		open func action(alias: String? = nil, _ subfields: (CartCompletionActionQuery) -> Void) -> CartCompletionActionRequiredQuery {
			let subquery = CartCompletionActionQuery()
			subfields(subquery)

			addField(field: "action", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The ID of the cart completion attempt. 
		@discardableResult
		open func id(alias: String? = nil) -> CartCompletionActionRequiredQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}
	}

	/// The required completion action to checkout a cart. 
	open class CartCompletionActionRequired: GraphQL.AbstractResponse, GraphQLObject, CartCompletionAttemptResult {
		public typealias Query = CartCompletionActionRequiredQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "action":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartCompletionActionRequired.self, field: fieldName, value: fieldValue)
				}
				return try UnknownCartCompletionAction.create(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCompletionActionRequired.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartCompletionActionRequired.self, field: fieldName, value: fieldValue)
			}
		}

		/// The action required to complete the cart completion attempt. 
		open var action: CartCompletionAction? {
			return internalGetAction()
		}

		func internalGetAction(alias: String? = nil) -> CartCompletionAction? {
			return field(field: "action", aliasSuffix: alias) as! CartCompletionAction?
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

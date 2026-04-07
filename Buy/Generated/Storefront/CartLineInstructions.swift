//
//  CartLineInstructions.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2026 Shopify Inc. All rights reserved.
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
	/// Represents instructions for a cart line item.
	open class CartLineInstructionsQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartLineInstructions

		/// Whether the line item can be removed from the cart.
		@discardableResult
		open func canRemove(alias: String? = nil) -> CartLineInstructionsQuery {
			addField(field: "canRemove", aliasSuffix: alias)
			return self
		}

		/// Whether the line item quantity can be updated.
		@discardableResult
		open func canUpdateQuantity(alias: String? = nil) -> CartLineInstructionsQuery {
			addField(field: "canUpdateQuantity", aliasSuffix: alias)
			return self
		}
	}

	/// Represents instructions for a cart line item.
	open class CartLineInstructions: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartLineInstructionsQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "canRemove":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartLineInstructions.self, field: fieldName, value: fieldValue)
				}
				return value

				case "canUpdateQuantity":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartLineInstructions.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartLineInstructions.self, field: fieldName, value: fieldValue)
			}
		}

		/// Whether the line item can be removed from the cart.
		open var canRemove: Bool {
			return internalGetCanRemove()
		}

		func internalGetCanRemove(alias: String? = nil) -> Bool {
			return field(field: "canRemove", aliasSuffix: alias) as! Bool
		}

		/// Whether the line item quantity can be updated.
		open var canUpdateQuantity: Bool {
			return internalGetCanUpdateQuantity()
		}

		func internalGetCanUpdateQuantity(alias: String? = nil) -> Bool {
			return field(field: "canUpdateQuantity", aliasSuffix: alias) as! Bool
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

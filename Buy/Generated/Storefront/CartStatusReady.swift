//
//  CartStatusReady.swift
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
	/// Cart is ready for payment update and completion. 
	open class CartStatusReadyQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartStatusReady

		/// The result of cart preparation for completion. 
		@discardableResult
		open func cart(alias: String? = nil, _ subfields: (CartQuery) -> Void) -> CartStatusReadyQuery {
			let subquery = CartQuery()
			subfields(subquery)

			addField(field: "cart", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Cart is ready for payment update and completion. 
	open class CartStatusReady: GraphQL.AbstractResponse, GraphQLObject, CartPrepareForCompletionResult {
		public typealias Query = CartStatusReadyQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cart":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartStatusReady.self, field: fieldName, value: fieldValue)
				}
				return try Cart(fields: value)

				default:
				throw SchemaViolationError(type: CartStatusReady.self, field: fieldName, value: fieldValue)
			}
		}

		/// The result of cart preparation for completion. 
		open var cart: Storefront.Cart? {
			return internalGetCart()
		}

		func internalGetCart(alias: String? = nil) -> Storefront.Cart? {
			return field(field: "cart", aliasSuffix: alias) as! Storefront.Cart?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "cart":
					if let value = internalGetCart() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

//
//  CartLineEstimatedCost.swift
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
	/// The estimated cost of the merchandise line that the buyer will pay at 
	/// checkout. 
	open class CartLineEstimatedCostQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartLineEstimatedCost

		/// The estimated cost of the merchandise line before discounts. 
		@discardableResult
		open func subtotalAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartLineEstimatedCostQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "subtotalAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The estimated total cost of the merchandise line. 
		@discardableResult
		open func totalAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartLineEstimatedCostQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The estimated cost of the merchandise line that the buyer will pay at 
	/// checkout. 
	open class CartLineEstimatedCost: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartLineEstimatedCostQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "subtotalAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartLineEstimatedCost.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartLineEstimatedCost.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: CartLineEstimatedCost.self, field: fieldName, value: fieldValue)
			}
		}

		/// The estimated cost of the merchandise line before discounts. 
		open var subtotalAmount: Storefront.MoneyV2 {
			return internalGetSubtotalAmount()
		}

		func internalGetSubtotalAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "subtotalAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The estimated total cost of the merchandise line. 
		open var totalAmount: Storefront.MoneyV2 {
			return internalGetTotalAmount()
		}

		func internalGetTotalAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "subtotalAmount":
					response.append(internalGetSubtotalAmount())
					response.append(contentsOf: internalGetSubtotalAmount().childResponseObjectMap())

					case "totalAmount":
					response.append(internalGetTotalAmount())
					response.append(contentsOf: internalGetTotalAmount().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

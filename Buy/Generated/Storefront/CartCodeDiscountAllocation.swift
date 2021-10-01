//
//  CartCodeDiscountAllocation.swift
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
	/// The discount that has been applied to the cart line using a discount code. 
	open class CartCodeDiscountAllocationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCodeDiscountAllocation

		/// The code used to apply the discount. 
		@discardableResult
		open func code(alias: String? = nil) -> CartCodeDiscountAllocationQuery {
			addField(field: "code", aliasSuffix: alias)
			return self
		}

		/// The discounted amount that has been applied to the cart line. 
		@discardableResult
		open func discountedAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartCodeDiscountAllocationQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "discountedAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The discount that has been applied to the cart line using a discount code. 
	open class CartCodeDiscountAllocation: GraphQL.AbstractResponse, GraphQLObject, CartDiscountAllocation {
		public typealias Query = CartCodeDiscountAllocationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "code":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCodeDiscountAllocation.self, field: fieldName, value: fieldValue)
				}
				return value

				case "discountedAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartCodeDiscountAllocation.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: CartCodeDiscountAllocation.self, field: fieldName, value: fieldValue)
			}
		}

		/// The code used to apply the discount. 
		open var code: String {
			return internalGetCode()
		}

		func internalGetCode(alias: String? = nil) -> String {
			return field(field: "code", aliasSuffix: alias) as! String
		}

		/// The discounted amount that has been applied to the cart line. 
		open var discountedAmount: Storefront.MoneyV2 {
			return internalGetDiscountedAmount()
		}

		func internalGetDiscountedAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "discountedAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "discountedAmount":
					response.append(internalGetDiscountedAmount())
					response.append(contentsOf: internalGetDiscountedAmount().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

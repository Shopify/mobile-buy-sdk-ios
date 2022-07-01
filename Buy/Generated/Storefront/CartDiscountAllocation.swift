//
//  CartDiscountAllocation.swift
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

/// The discounts that have been applied to the cart line. 
public protocol CartDiscountAllocation {
	var discountedAmount: Storefront.MoneyV2 { get }
}

extension Storefront {
	/// The discounts that have been applied to the cart line. 
	open class CartDiscountAllocationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartDiscountAllocation

		/// The discounted amount that has been applied to the cart line. 
		@discardableResult
		open func discountedAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartDiscountAllocationQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "discountedAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// The discounts that have been applied to the cart line. 
		@discardableResult
		open func onCartAutomaticDiscountAllocation(subfields: (CartAutomaticDiscountAllocationQuery) -> Void) -> CartDiscountAllocationQuery {
			let subquery = CartAutomaticDiscountAllocationQuery()
			subfields(subquery)
			addInlineFragment(on: "CartAutomaticDiscountAllocation", subfields: subquery)
			return self
		}

		/// The discounts that have been applied to the cart line. 
		@discardableResult
		open func onCartCodeDiscountAllocation(subfields: (CartCodeDiscountAllocationQuery) -> Void) -> CartDiscountAllocationQuery {
			let subquery = CartCodeDiscountAllocationQuery()
			subfields(subquery)
			addInlineFragment(on: "CartCodeDiscountAllocation", subfields: subquery)
			return self
		}

		/// The discounts that have been applied to the cart line. 
		@discardableResult
		open func onCartCustomDiscountAllocation(subfields: (CartCustomDiscountAllocationQuery) -> Void) -> CartDiscountAllocationQuery {
			let subquery = CartCustomDiscountAllocationQuery()
			subfields(subquery)
			addInlineFragment(on: "CartCustomDiscountAllocation", subfields: subquery)
			return self
		}
	}

	/// The discounts that have been applied to the cart line. 
	open class UnknownCartDiscountAllocation: GraphQL.AbstractResponse, GraphQLObject, CartDiscountAllocation {
		public typealias Query = CartDiscountAllocationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "discountedAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: UnknownCartDiscountAllocation.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: UnknownCartDiscountAllocation.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> CartDiscountAllocation {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownCartDiscountAllocation.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "CartAutomaticDiscountAllocation": return try CartAutomaticDiscountAllocation.init(fields: fields)

				case "CartCodeDiscountAllocation": return try CartCodeDiscountAllocation.init(fields: fields)

				case "CartCustomDiscountAllocation": return try CartCustomDiscountAllocation.init(fields: fields)

				default:
				return try UnknownCartDiscountAllocation.init(fields: fields)
			}
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

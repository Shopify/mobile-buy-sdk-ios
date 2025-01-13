//
//  ShopPayPaymentRequestTotalShippingPrice.swift
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
	/// Represents a shipping total for a Shop Pay payment request. 
	open class ShopPayPaymentRequestTotalShippingPriceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestTotalShippingPrice

		/// The discounts for the shipping total. 
		@discardableResult
		open func discounts(alias: String? = nil, _ subfields: (ShopPayPaymentRequestDiscountQuery) -> Void) -> ShopPayPaymentRequestTotalShippingPriceQuery {
			let subquery = ShopPayPaymentRequestDiscountQuery()
			subfields(subquery)

			addField(field: "discounts", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The final total for the shipping total. 
		@discardableResult
		open func finalTotal(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestTotalShippingPriceQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "finalTotal", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The original total for the shipping total. 
		@discardableResult
		open func originalTotal(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestTotalShippingPriceQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "originalTotal", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents a shipping total for a Shop Pay payment request. 
	open class ShopPayPaymentRequestTotalShippingPrice: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestTotalShippingPriceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "discounts":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestTotalShippingPrice.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayPaymentRequestDiscount(fields: $0) }

				case "finalTotal":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestTotalShippingPrice.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "originalTotal":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestTotalShippingPrice.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestTotalShippingPrice.self, field: fieldName, value: fieldValue)
			}
		}

		/// The discounts for the shipping total. 
		open var discounts: [Storefront.ShopPayPaymentRequestDiscount] {
			return internalGetDiscounts()
		}

		func internalGetDiscounts(alias: String? = nil) -> [Storefront.ShopPayPaymentRequestDiscount] {
			return field(field: "discounts", aliasSuffix: alias) as! [Storefront.ShopPayPaymentRequestDiscount]
		}

		/// The final total for the shipping total. 
		open var finalTotal: Storefront.MoneyV2 {
			return internalGetFinalTotal()
		}

		func internalGetFinalTotal(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "finalTotal", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The original total for the shipping total. 
		open var originalTotal: Storefront.MoneyV2? {
			return internalGetOriginalTotal()
		}

		func internalGetOriginalTotal(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "originalTotal", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "discounts":
					internalGetDiscounts().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "finalTotal":
					response.append(internalGetFinalTotal())
					response.append(contentsOf: internalGetFinalTotal().childResponseObjectMap())

					case "originalTotal":
					if let value = internalGetOriginalTotal() {
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

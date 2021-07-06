//
//  SellingPlanAllocationPriceAdjustment.swift
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
	/// The resulting prices for variants when they're purchased with a specific 
	/// selling plan. 
	open class SellingPlanAllocationPriceAdjustmentQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanAllocationPriceAdjustment

		/// The price of the variant when it's purchased without a selling plan for the 
		/// same number of deliveries. For example, if a customer purchases 6 
		/// deliveries of $10.00 granola separately, then the price is 6 x $10.00 = 
		/// $60.00. 
		@discardableResult
		open func compareAtPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> SellingPlanAllocationPriceAdjustmentQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "compareAtPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The effective price for a single delivery. For example, for a prepaid 
		/// subscription plan that includes 6 deliveries at the price of $48.00, the 
		/// per delivery price is $8.00. 
		@discardableResult
		open func perDeliveryPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> SellingPlanAllocationPriceAdjustmentQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "perDeliveryPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The price of the variant when it's purchased with a selling plan For 
		/// example, for a prepaid subscription plan that includes 6 deliveries of 
		/// $10.00 granola, where the customer gets 20% off, the price is 6 x $10.00 x 
		/// 0.80 = $48.00. 
		@discardableResult
		open func price(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> SellingPlanAllocationPriceAdjustmentQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "price", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The resulting price per unit for the variant associated with the selling 
		/// plan. If the variant isn't sold by quantity or measurement, then this field 
		/// returns `null`. 
		@discardableResult
		open func unitPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> SellingPlanAllocationPriceAdjustmentQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "unitPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The resulting prices for variants when they're purchased with a specific 
	/// selling plan. 
	open class SellingPlanAllocationPriceAdjustment: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SellingPlanAllocationPriceAdjustmentQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "compareAtPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanAllocationPriceAdjustment.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "perDeliveryPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanAllocationPriceAdjustment.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "price":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanAllocationPriceAdjustment.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "unitPrice":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanAllocationPriceAdjustment.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: SellingPlanAllocationPriceAdjustment.self, field: fieldName, value: fieldValue)
			}
		}

		/// The price of the variant when it's purchased without a selling plan for the 
		/// same number of deliveries. For example, if a customer purchases 6 
		/// deliveries of $10.00 granola separately, then the price is 6 x $10.00 = 
		/// $60.00. 
		open var compareAtPrice: Storefront.MoneyV2 {
			return internalGetCompareAtPrice()
		}

		func internalGetCompareAtPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "compareAtPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The effective price for a single delivery. For example, for a prepaid 
		/// subscription plan that includes 6 deliveries at the price of $48.00, the 
		/// per delivery price is $8.00. 
		open var perDeliveryPrice: Storefront.MoneyV2 {
			return internalGetPerDeliveryPrice()
		}

		func internalGetPerDeliveryPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "perDeliveryPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The price of the variant when it's purchased with a selling plan For 
		/// example, for a prepaid subscription plan that includes 6 deliveries of 
		/// $10.00 granola, where the customer gets 20% off, the price is 6 x $10.00 x 
		/// 0.80 = $48.00. 
		open var price: Storefront.MoneyV2 {
			return internalGetPrice()
		}

		func internalGetPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "price", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The resulting price per unit for the variant associated with the selling 
		/// plan. If the variant isn't sold by quantity or measurement, then this field 
		/// returns `null`. 
		open var unitPrice: Storefront.MoneyV2? {
			return internalGetUnitPrice()
		}

		func internalGetUnitPrice(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "unitPrice", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "compareAtPrice":
					response.append(internalGetCompareAtPrice())
					response.append(contentsOf: internalGetCompareAtPrice().childResponseObjectMap())

					case "perDeliveryPrice":
					response.append(internalGetPerDeliveryPrice())
					response.append(contentsOf: internalGetPerDeliveryPrice().childResponseObjectMap())

					case "price":
					response.append(internalGetPrice())
					response.append(contentsOf: internalGetPrice().childResponseObjectMap())

					case "unitPrice":
					if let value = internalGetUnitPrice() {
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

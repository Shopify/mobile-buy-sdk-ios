//
//  ShopPayInstallmentsPricing.swift
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
	/// The result for a Shop Pay Installments pricing request. 
	open class ShopPayInstallmentsPricingQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayInstallmentsPricing

		/// The financing plans available for the given price range. 
		@discardableResult
		open func financingPlans(alias: String? = nil, _ subfields: (ShopPayInstallmentsFinancingPlanQuery) -> Void) -> ShopPayInstallmentsPricingQuery {
			let subquery = ShopPayInstallmentsFinancingPlanQuery()
			subfields(subquery)

			addField(field: "financingPlans", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The maximum price to qualify for financing. 
		@discardableResult
		open func maxPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayInstallmentsPricingQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "maxPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The minimum price to qualify for financing. 
		@discardableResult
		open func minPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayInstallmentsPricingQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "minPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The result for a Shop Pay Installments pricing request. 
	open class ShopPayInstallmentsPricing: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayInstallmentsPricingQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "financingPlans":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayInstallmentsPricing.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayInstallmentsFinancingPlan(fields: $0) }

				case "maxPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsPricing.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "minPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsPricing.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: ShopPayInstallmentsPricing.self, field: fieldName, value: fieldValue)
			}
		}

		/// The financing plans available for the given price range. 
		open var financingPlans: [Storefront.ShopPayInstallmentsFinancingPlan] {
			return internalGetFinancingPlans()
		}

		func internalGetFinancingPlans(alias: String? = nil) -> [Storefront.ShopPayInstallmentsFinancingPlan] {
			return field(field: "financingPlans", aliasSuffix: alias) as! [Storefront.ShopPayInstallmentsFinancingPlan]
		}

		/// The maximum price to qualify for financing. 
		open var maxPrice: Storefront.MoneyV2 {
			return internalGetMaxPrice()
		}

		func internalGetMaxPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "maxPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The minimum price to qualify for financing. 
		open var minPrice: Storefront.MoneyV2 {
			return internalGetMinPrice()
		}

		func internalGetMinPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "minPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "financingPlans":
					internalGetFinancingPlans().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "maxPrice":
					response.append(internalGetMaxPrice())
					response.append(contentsOf: internalGetMaxPrice().childResponseObjectMap())

					case "minPrice":
					response.append(internalGetMinPrice())
					response.append(contentsOf: internalGetMinPrice().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

//
//  ShopPayInstallmentsFinancingPlan.swift
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
	/// The financing plan in Shop Pay Installments. 
	open class ShopPayInstallmentsFinancingPlanQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayInstallmentsFinancingPlan

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ShopPayInstallmentsFinancingPlanQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The maximum price to qualify for the financing plan. 
		@discardableResult
		open func maxPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayInstallmentsFinancingPlanQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "maxPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The minimum price to qualify for the financing plan. 
		@discardableResult
		open func minPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayInstallmentsFinancingPlanQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "minPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The terms of the financing plan. 
		@discardableResult
		open func terms(alias: String? = nil, _ subfields: (ShopPayInstallmentsFinancingPlanTermQuery) -> Void) -> ShopPayInstallmentsFinancingPlanQuery {
			let subquery = ShopPayInstallmentsFinancingPlanTermQuery()
			subfields(subquery)

			addField(field: "terms", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The financing plan in Shop Pay Installments. 
	open class ShopPayInstallmentsFinancingPlan: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = ShopPayInstallmentsFinancingPlanQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlan.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "maxPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlan.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "minPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlan.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "terms":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlan.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayInstallmentsFinancingPlanTerm(fields: $0) }

				default:
				throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlan.self, field: fieldName, value: fieldValue)
			}
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The maximum price to qualify for the financing plan. 
		open var maxPrice: Storefront.MoneyV2 {
			return internalGetMaxPrice()
		}

		func internalGetMaxPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "maxPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The minimum price to qualify for the financing plan. 
		open var minPrice: Storefront.MoneyV2 {
			return internalGetMinPrice()
		}

		func internalGetMinPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "minPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The terms of the financing plan. 
		open var terms: [Storefront.ShopPayInstallmentsFinancingPlanTerm] {
			return internalGetTerms()
		}

		func internalGetTerms(alias: String? = nil) -> [Storefront.ShopPayInstallmentsFinancingPlanTerm] {
			return field(field: "terms", aliasSuffix: alias) as! [Storefront.ShopPayInstallmentsFinancingPlanTerm]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "maxPrice":
					response.append(internalGetMaxPrice())
					response.append(contentsOf: internalGetMaxPrice().childResponseObjectMap())

					case "minPrice":
					response.append(internalGetMinPrice())
					response.append(contentsOf: internalGetMinPrice().childResponseObjectMap())

					case "terms":
					internalGetTerms().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

//
//  SellingPlanAllocation.swift
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
	/// Represents an association between a variant and a selling plan. Selling 
	/// plan allocations describe the options offered for each variant, and the 
	/// price of the variant when purchased with a selling plan. 
	open class SellingPlanAllocationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanAllocation

		/// A list of price adjustments, with a maximum of two. When there are two, the 
		/// first price adjustment goes into effect at the time of purchase, while the 
		/// second one starts after a certain number of orders. 
		@discardableResult
		open func priceAdjustments(alias: String? = nil, _ subfields: (SellingPlanAllocationPriceAdjustmentQuery) -> Void) -> SellingPlanAllocationQuery {
			let subquery = SellingPlanAllocationPriceAdjustmentQuery()
			subfields(subquery)

			addField(field: "priceAdjustments", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A representation of how products and variants can be sold and purchased. 
		/// For example, an individual selling plan could be '6 weeks of prepaid 
		/// granola, delivered weekly'. 
		@discardableResult
		open func sellingPlan(alias: String? = nil, _ subfields: (SellingPlanQuery) -> Void) -> SellingPlanAllocationQuery {
			let subquery = SellingPlanQuery()
			subfields(subquery)

			addField(field: "sellingPlan", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents an association between a variant and a selling plan. Selling 
	/// plan allocations describe the options offered for each variant, and the 
	/// price of the variant when purchased with a selling plan. 
	open class SellingPlanAllocation: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SellingPlanAllocationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "priceAdjustments":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SellingPlanAllocation.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SellingPlanAllocationPriceAdjustment(fields: $0) }

				case "sellingPlan":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanAllocation.self, field: fieldName, value: fieldValue)
				}
				return try SellingPlan(fields: value)

				default:
				throw SchemaViolationError(type: SellingPlanAllocation.self, field: fieldName, value: fieldValue)
			}
		}

		/// A list of price adjustments, with a maximum of two. When there are two, the 
		/// first price adjustment goes into effect at the time of purchase, while the 
		/// second one starts after a certain number of orders. 
		open var priceAdjustments: [Storefront.SellingPlanAllocationPriceAdjustment] {
			return internalGetPriceAdjustments()
		}

		func internalGetPriceAdjustments(alias: String? = nil) -> [Storefront.SellingPlanAllocationPriceAdjustment] {
			return field(field: "priceAdjustments", aliasSuffix: alias) as! [Storefront.SellingPlanAllocationPriceAdjustment]
		}

		/// A representation of how products and variants can be sold and purchased. 
		/// For example, an individual selling plan could be '6 weeks of prepaid 
		/// granola, delivered weekly'. 
		open var sellingPlan: Storefront.SellingPlan {
			return internalGetSellingPlan()
		}

		func internalGetSellingPlan(alias: String? = nil) -> Storefront.SellingPlan {
			return field(field: "sellingPlan", aliasSuffix: alias) as! Storefront.SellingPlan
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "priceAdjustments":
					internalGetPriceAdjustments().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "sellingPlan":
					response.append(internalGetSellingPlan())
					response.append(contentsOf: internalGetSellingPlan().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

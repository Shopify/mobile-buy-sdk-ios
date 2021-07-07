//
//  SellingPlanFixedAmountPriceAdjustment.swift
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
	/// A fixed amount that's deducted from the original variant price. For 
	/// example, $10.00 off. 
	open class SellingPlanFixedAmountPriceAdjustmentQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanFixedAmountPriceAdjustment

		/// The money value of the price adjustment. 
		@discardableResult
		open func adjustmentAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> SellingPlanFixedAmountPriceAdjustmentQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "adjustmentAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// A fixed amount that's deducted from the original variant price. For 
	/// example, $10.00 off. 
	open class SellingPlanFixedAmountPriceAdjustment: GraphQL.AbstractResponse, GraphQLObject, SellingPlanPriceAdjustmentValue {
		public typealias Query = SellingPlanFixedAmountPriceAdjustmentQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "adjustmentAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanFixedAmountPriceAdjustment.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: SellingPlanFixedAmountPriceAdjustment.self, field: fieldName, value: fieldValue)
			}
		}

		/// The money value of the price adjustment. 
		open var adjustmentAmount: Storefront.MoneyV2 {
			return internalGetAdjustmentAmount()
		}

		func internalGetAdjustmentAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "adjustmentAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "adjustmentAmount":
					response.append(internalGetAdjustmentAmount())
					response.append(contentsOf: internalGetAdjustmentAmount().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

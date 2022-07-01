//
//  SellingPlanCheckoutChargePercentageValue.swift
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
	/// The percentage value of the price used for checkout charge. 
	open class SellingPlanCheckoutChargePercentageValueQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanCheckoutChargePercentageValue

		/// The percentage value of the price used for checkout charge. 
		@discardableResult
		open func percentage(alias: String? = nil) -> SellingPlanCheckoutChargePercentageValueQuery {
			addField(field: "percentage", aliasSuffix: alias)
			return self
		}
	}

	/// The percentage value of the price used for checkout charge. 
	open class SellingPlanCheckoutChargePercentageValue: GraphQL.AbstractResponse, GraphQLObject, SellingPlanCheckoutChargeValue {
		public typealias Query = SellingPlanCheckoutChargePercentageValueQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "percentage":
				guard let value = value as? Double else {
					throw SchemaViolationError(type: SellingPlanCheckoutChargePercentageValue.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: SellingPlanCheckoutChargePercentageValue.self, field: fieldName, value: fieldValue)
			}
		}

		/// The percentage value of the price used for checkout charge. 
		open var percentage: Double {
			return internalGetPercentage()
		}

		func internalGetPercentage(alias: String? = nil) -> Double {
			return field(field: "percentage", aliasSuffix: alias) as! Double
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

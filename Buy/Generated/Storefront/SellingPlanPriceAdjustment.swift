//
//  SellingPlanPriceAdjustment.swift
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
	/// Represents by how much the price of a variant associated with a selling 
	/// plan is adjusted. Each variant can have up to two price adjustments. 
	open class SellingPlanPriceAdjustmentQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanPriceAdjustment

		/// The type of price adjustment. An adjustment value can have one of three 
		/// types: percentage, amount off, or a new price. 
		@discardableResult
		open func adjustmentValue(alias: String? = nil, _ subfields: (SellingPlanPriceAdjustmentValueQuery) -> Void) -> SellingPlanPriceAdjustmentQuery {
			let subquery = SellingPlanPriceAdjustmentValueQuery()
			subfields(subquery)

			addField(field: "adjustmentValue", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The number of orders that the price adjustment applies to If the price 
		/// adjustment always applies, then this field is `null`. 
		@discardableResult
		open func orderCount(alias: String? = nil) -> SellingPlanPriceAdjustmentQuery {
			addField(field: "orderCount", aliasSuffix: alias)
			return self
		}
	}

	/// Represents by how much the price of a variant associated with a selling 
	/// plan is adjusted. Each variant can have up to two price adjustments. 
	open class SellingPlanPriceAdjustment: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SellingPlanPriceAdjustmentQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "adjustmentValue":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanPriceAdjustment.self, field: fieldName, value: fieldValue)
				}
				return try UnknownSellingPlanPriceAdjustmentValue.create(fields: value)

				case "orderCount":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: SellingPlanPriceAdjustment.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: SellingPlanPriceAdjustment.self, field: fieldName, value: fieldValue)
			}
		}

		/// The type of price adjustment. An adjustment value can have one of three 
		/// types: percentage, amount off, or a new price. 
		open var adjustmentValue: SellingPlanPriceAdjustmentValue {
			return internalGetAdjustmentValue()
		}

		func internalGetAdjustmentValue(alias: String? = nil) -> SellingPlanPriceAdjustmentValue {
			return field(field: "adjustmentValue", aliasSuffix: alias) as! SellingPlanPriceAdjustmentValue
		}

		/// The number of orders that the price adjustment applies to If the price 
		/// adjustment always applies, then this field is `null`. 
		open var orderCount: Int32? {
			return internalGetOrderCount()
		}

		func internalGetOrderCount(alias: String? = nil) -> Int32? {
			return field(field: "orderCount", aliasSuffix: alias) as! Int32?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

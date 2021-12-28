//
//  SellingPlanPriceAdjustmentValue.swift
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

/// Represents by how much the price of a variant associated with a selling 
/// plan is adjusted. Each variant can have up to two price adjustments. 
public protocol SellingPlanPriceAdjustmentValue {
}

extension Storefront {
	/// Represents by how much the price of a variant associated with a selling 
	/// plan is adjusted. Each variant can have up to two price adjustments. 
	open class SellingPlanPriceAdjustmentValueQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanPriceAdjustmentValue

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents by how much the price of a variant associated with a selling 
		/// plan is adjusted. Each variant can have up to two price adjustments. 
		@discardableResult
		open func onSellingPlanFixedAmountPriceAdjustment(subfields: (SellingPlanFixedAmountPriceAdjustmentQuery) -> Void) -> SellingPlanPriceAdjustmentValueQuery {
			let subquery = SellingPlanFixedAmountPriceAdjustmentQuery()
			subfields(subquery)
			addInlineFragment(on: "SellingPlanFixedAmountPriceAdjustment", subfields: subquery)
			return self
		}

		/// Represents by how much the price of a variant associated with a selling 
		/// plan is adjusted. Each variant can have up to two price adjustments. 
		@discardableResult
		open func onSellingPlanFixedPriceAdjustment(subfields: (SellingPlanFixedPriceAdjustmentQuery) -> Void) -> SellingPlanPriceAdjustmentValueQuery {
			let subquery = SellingPlanFixedPriceAdjustmentQuery()
			subfields(subquery)
			addInlineFragment(on: "SellingPlanFixedPriceAdjustment", subfields: subquery)
			return self
		}

		/// Represents by how much the price of a variant associated with a selling 
		/// plan is adjusted. Each variant can have up to two price adjustments. 
		@discardableResult
		open func onSellingPlanPercentagePriceAdjustment(subfields: (SellingPlanPercentagePriceAdjustmentQuery) -> Void) -> SellingPlanPriceAdjustmentValueQuery {
			let subquery = SellingPlanPercentagePriceAdjustmentQuery()
			subfields(subquery)
			addInlineFragment(on: "SellingPlanPercentagePriceAdjustment", subfields: subquery)
			return self
		}
	}

	/// Represents by how much the price of a variant associated with a selling 
	/// plan is adjusted. Each variant can have up to two price adjustments. 
	open class UnknownSellingPlanPriceAdjustmentValue: GraphQL.AbstractResponse, GraphQLObject, SellingPlanPriceAdjustmentValue {
		public typealias Query = SellingPlanPriceAdjustmentValueQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownSellingPlanPriceAdjustmentValue.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> SellingPlanPriceAdjustmentValue {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownSellingPlanPriceAdjustmentValue.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "SellingPlanFixedAmountPriceAdjustment": return try SellingPlanFixedAmountPriceAdjustment.init(fields: fields)

				case "SellingPlanFixedPriceAdjustment": return try SellingPlanFixedPriceAdjustment.init(fields: fields)

				case "SellingPlanPercentagePriceAdjustment": return try SellingPlanPercentagePriceAdjustment.init(fields: fields)

				default:
				return try UnknownSellingPlanPriceAdjustmentValue.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

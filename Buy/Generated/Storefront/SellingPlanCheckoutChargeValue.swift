//
//  SellingPlanCheckoutChargeValue.swift
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

/// The portion of the price to be charged at checkout. 
public protocol SellingPlanCheckoutChargeValue {
}

extension Storefront {
	/// The portion of the price to be charged at checkout. 
	open class SellingPlanCheckoutChargeValueQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanCheckoutChargeValue

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// The portion of the price to be charged at checkout. 
		@discardableResult
		open func onMoneyV2(subfields: (MoneyV2Query) -> Void) -> SellingPlanCheckoutChargeValueQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)
			addInlineFragment(on: "MoneyV2", subfields: subquery)
			return self
		}

		/// The portion of the price to be charged at checkout. 
		@discardableResult
		open func onSellingPlanCheckoutChargePercentageValue(subfields: (SellingPlanCheckoutChargePercentageValueQuery) -> Void) -> SellingPlanCheckoutChargeValueQuery {
			let subquery = SellingPlanCheckoutChargePercentageValueQuery()
			subfields(subquery)
			addInlineFragment(on: "SellingPlanCheckoutChargePercentageValue", subfields: subquery)
			return self
		}
	}

	/// The portion of the price to be charged at checkout. 
	open class UnknownSellingPlanCheckoutChargeValue: GraphQL.AbstractResponse, GraphQLObject, SellingPlanCheckoutChargeValue {
		public typealias Query = SellingPlanCheckoutChargeValueQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownSellingPlanCheckoutChargeValue.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> SellingPlanCheckoutChargeValue {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownSellingPlanCheckoutChargeValue.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "MoneyV2": return try MoneyV2.init(fields: fields)

				case "SellingPlanCheckoutChargePercentageValue": return try SellingPlanCheckoutChargePercentageValue.init(fields: fields)

				default:
				return try UnknownSellingPlanCheckoutChargeValue.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

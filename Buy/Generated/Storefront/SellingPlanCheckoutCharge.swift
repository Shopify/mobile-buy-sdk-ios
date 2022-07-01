//
//  SellingPlanCheckoutCharge.swift
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
	/// The initial payment due for the purchase. 
	open class SellingPlanCheckoutChargeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanCheckoutCharge

		/// The charge type for the checkout charge. 
		@discardableResult
		open func type(alias: String? = nil) -> SellingPlanCheckoutChargeQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The charge value for the checkout charge. 
		@discardableResult
		open func value(alias: String? = nil, _ subfields: (SellingPlanCheckoutChargeValueQuery) -> Void) -> SellingPlanCheckoutChargeQuery {
			let subquery = SellingPlanCheckoutChargeValueQuery()
			subfields(subquery)

			addField(field: "value", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The initial payment due for the purchase. 
	open class SellingPlanCheckoutCharge: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SellingPlanCheckoutChargeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "type":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlanCheckoutCharge.self, field: fieldName, value: fieldValue)
				}
				return SellingPlanCheckoutChargeType(rawValue: value) ?? .unknownValue

				case "value":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanCheckoutCharge.self, field: fieldName, value: fieldValue)
				}
				return try UnknownSellingPlanCheckoutChargeValue.create(fields: value)

				default:
				throw SchemaViolationError(type: SellingPlanCheckoutCharge.self, field: fieldName, value: fieldValue)
			}
		}

		/// The charge type for the checkout charge. 
		open var type: Storefront.SellingPlanCheckoutChargeType {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> Storefront.SellingPlanCheckoutChargeType {
			return field(field: "type", aliasSuffix: alias) as! Storefront.SellingPlanCheckoutChargeType
		}

		/// The charge value for the checkout charge. 
		open var value: SellingPlanCheckoutChargeValue {
			return internalGetValue()
		}

		func internalGetValue(alias: String? = nil) -> SellingPlanCheckoutChargeValue {
			return field(field: "value", aliasSuffix: alias) as! SellingPlanCheckoutChargeValue
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

//
//  SellingPlanRecurringDeliveryPolicy.swift
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
	/// The recurring delivery policy for the selling plan. 
	open class SellingPlanRecurringDeliveryPolicyQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanRecurringDeliveryPolicy

		/// The delivery frequency, it can be either: day, week, month or year. 
		@discardableResult
		open func interval(alias: String? = nil) -> SellingPlanRecurringDeliveryPolicyQuery {
			addField(field: "interval", aliasSuffix: alias)
			return self
		}

		/// The number of intervals between deliveries. 
		@discardableResult
		open func intervalCount(alias: String? = nil) -> SellingPlanRecurringDeliveryPolicyQuery {
			addField(field: "intervalCount", aliasSuffix: alias)
			return self
		}
	}

	/// The recurring delivery policy for the selling plan. 
	open class SellingPlanRecurringDeliveryPolicy: GraphQL.AbstractResponse, GraphQLObject, SellingPlanDeliveryPolicy {
		public typealias Query = SellingPlanRecurringDeliveryPolicyQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "interval":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlanRecurringDeliveryPolicy.self, field: fieldName, value: fieldValue)
				}
				return SellingPlanInterval(rawValue: value) ?? .unknownValue

				case "intervalCount":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: SellingPlanRecurringDeliveryPolicy.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: SellingPlanRecurringDeliveryPolicy.self, field: fieldName, value: fieldValue)
			}
		}

		/// The delivery frequency, it can be either: day, week, month or year. 
		open var interval: Storefront.SellingPlanInterval {
			return internalGetInterval()
		}

		func internalGetInterval(alias: String? = nil) -> Storefront.SellingPlanInterval {
			return field(field: "interval", aliasSuffix: alias) as! Storefront.SellingPlanInterval
		}

		/// The number of intervals between deliveries. 
		open var intervalCount: Int32 {
			return internalGetIntervalCount()
		}

		func internalGetIntervalCount(alias: String? = nil) -> Int32 {
			return field(field: "intervalCount", aliasSuffix: alias) as! Int32
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

//
//  SellingPlanDeliveryPolicy.swift
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

/// The selling plan delivery policy. 
public protocol SellingPlanDeliveryPolicy {
}

extension Storefront {
	/// The selling plan delivery policy. 
	open class SellingPlanDeliveryPolicyQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanDeliveryPolicy

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// The selling plan delivery policy. 
		@discardableResult
		open func onSellingPlanRecurringDeliveryPolicy(subfields: (SellingPlanRecurringDeliveryPolicyQuery) -> Void) -> SellingPlanDeliveryPolicyQuery {
			let subquery = SellingPlanRecurringDeliveryPolicyQuery()
			subfields(subquery)
			addInlineFragment(on: "SellingPlanRecurringDeliveryPolicy", subfields: subquery)
			return self
		}
	}

	/// The selling plan delivery policy. 
	open class UnknownSellingPlanDeliveryPolicy: GraphQL.AbstractResponse, GraphQLObject, SellingPlanDeliveryPolicy {
		public typealias Query = SellingPlanDeliveryPolicyQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownSellingPlanDeliveryPolicy.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> SellingPlanDeliveryPolicy {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownSellingPlanDeliveryPolicy.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "SellingPlanRecurringDeliveryPolicy": return try SellingPlanRecurringDeliveryPolicy.init(fields: fields)

				default:
				return try UnknownSellingPlanDeliveryPolicy.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

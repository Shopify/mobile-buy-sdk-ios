//
//  PricingPercentageValue.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2026 Shopify Inc. All rights reserved.
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
	/// A percentage discount value applied to cart items or orders. Returned as
	/// part of the
	/// [`PricingValue`](https://shopify.dev/docs/api/storefront/current/unions/PricingValue)
	/// union on [discount
	/// applications](https://shopify.dev/docs/api/storefront/current/interfaces/DiscountApplication),
	/// where it represents discounts calculated as a percentage off rather than a
	/// [fixed
	/// amount](https://shopify.dev/docs/api/storefront/current/objects/MoneyV2).
	open class PricingPercentageValueQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PricingPercentageValue

		/// The percentage value of the object.
		@discardableResult
		open func percentage(alias: String? = nil) -> PricingPercentageValueQuery {
			addField(field: "percentage", aliasSuffix: alias)
			return self
		}
	}

	/// A percentage discount value applied to cart items or orders. Returned as
	/// part of the
	/// [`PricingValue`](https://shopify.dev/docs/api/storefront/current/unions/PricingValue)
	/// union on [discount
	/// applications](https://shopify.dev/docs/api/storefront/current/interfaces/DiscountApplication),
	/// where it represents discounts calculated as a percentage off rather than a
	/// [fixed
	/// amount](https://shopify.dev/docs/api/storefront/current/objects/MoneyV2).
	open class PricingPercentageValue: GraphQL.AbstractResponse, GraphQLObject, PricingValue {
		public typealias Query = PricingPercentageValueQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "percentage":
				guard let value = value as? Double else {
					throw SchemaViolationError(type: PricingPercentageValue.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: PricingPercentageValue.self, field: fieldName, value: fieldValue)
			}
		}

		/// The percentage value of the object.
		open var percentage: Double {
			return internalGetPercentage()
		}

		func internalGetPercentage(alias: String? = nil) -> Double {
			return field(field: "percentage", aliasSuffix: alias) as! Double
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

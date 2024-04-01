//
//  QuantityPriceBreak.swift
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
	/// Quantity price breaks lets you offer different rates that are based on the 
	/// amount of a specific variant being ordered. 
	open class QuantityPriceBreakQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = QuantityPriceBreak

		/// Minimum quantity required to reach new quantity break price. 
		@discardableResult
		open func minimumQuantity(alias: String? = nil) -> QuantityPriceBreakQuery {
			addField(field: "minimumQuantity", aliasSuffix: alias)
			return self
		}

		/// The price of variant after reaching the minimum quanity. 
		@discardableResult
		open func price(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> QuantityPriceBreakQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "price", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Quantity price breaks lets you offer different rates that are based on the 
	/// amount of a specific variant being ordered. 
	open class QuantityPriceBreak: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = QuantityPriceBreakQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "minimumQuantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: QuantityPriceBreak.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "price":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QuantityPriceBreak.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: QuantityPriceBreak.self, field: fieldName, value: fieldValue)
			}
		}

		/// Minimum quantity required to reach new quantity break price. 
		open var minimumQuantity: Int32 {
			return internalGetMinimumQuantity()
		}

		func internalGetMinimumQuantity(alias: String? = nil) -> Int32 {
			return field(field: "minimumQuantity", aliasSuffix: alias) as! Int32
		}

		/// The price of variant after reaching the minimum quanity. 
		open var price: Storefront.MoneyV2 {
			return internalGetPrice()
		}

		func internalGetPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "price", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "price":
					response.append(internalGetPrice())
					response.append(contentsOf: internalGetPrice().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

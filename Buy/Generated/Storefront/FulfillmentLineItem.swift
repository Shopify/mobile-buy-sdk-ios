//
//  FulfillmentLineItem.swift
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
	/// Represents a single line item in a fulfillment. There is at most one 
	/// fulfillment line item for each order line item. 
	open class FulfillmentLineItemQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = FulfillmentLineItem

		/// The associated order's line item. 
		@discardableResult
		open func lineItem(alias: String? = nil, _ subfields: (OrderLineItemQuery) -> Void) -> FulfillmentLineItemQuery {
			let subquery = OrderLineItemQuery()
			subfields(subquery)

			addField(field: "lineItem", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The amount fulfilled in this fulfillment. 
		@discardableResult
		open func quantity(alias: String? = nil) -> FulfillmentLineItemQuery {
			addField(field: "quantity", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a single line item in a fulfillment. There is at most one 
	/// fulfillment line item for each order line item. 
	open class FulfillmentLineItem: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = FulfillmentLineItemQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "lineItem":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: FulfillmentLineItem.self, field: fieldName, value: fieldValue)
				}
				return try OrderLineItem(fields: value)

				case "quantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: FulfillmentLineItem.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: FulfillmentLineItem.self, field: fieldName, value: fieldValue)
			}
		}

		/// The associated order's line item. 
		open var lineItem: Storefront.OrderLineItem {
			return internalGetLineItem()
		}

		func internalGetLineItem(alias: String? = nil) -> Storefront.OrderLineItem {
			return field(field: "lineItem", aliasSuffix: alias) as! Storefront.OrderLineItem
		}

		/// The amount fulfilled in this fulfillment. 
		open var quantity: Int32 {
			return internalGetQuantity()
		}

		func internalGetQuantity(alias: String? = nil) -> Int32 {
			return field(field: "quantity", aliasSuffix: alias) as! Int32
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "lineItem":
					response.append(internalGetLineItem())
					response.append(contentsOf: internalGetLineItem().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

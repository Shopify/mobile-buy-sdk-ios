//
//  Fulfillment.swift
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
	/// Represents a single fulfillment in an order. 
	open class FulfillmentQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Fulfillment

		/// List of the fulfillment's line items. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func fulfillmentLineItems(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (FulfillmentLineItemConnectionQuery) -> Void) -> FulfillmentQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = FulfillmentLineItemConnectionQuery()
			subfields(subquery)

			addField(field: "fulfillmentLineItems", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The name of the tracking company. 
		@discardableResult
		open func trackingCompany(alias: String? = nil) -> FulfillmentQuery {
			addField(field: "trackingCompany", aliasSuffix: alias)
			return self
		}

		/// Tracking information associated with the fulfillment, such as the tracking 
		/// number and tracking URL. 
		///
		/// - parameters:
		///     - first: Truncate the array result to this size.
		///
		@discardableResult
		open func trackingInfo(alias: String? = nil, first: Int32? = nil, _ subfields: (FulfillmentTrackingInfoQuery) -> Void) -> FulfillmentQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = FulfillmentTrackingInfoQuery()
			subfields(subquery)

			addField(field: "trackingInfo", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}
	}

	/// Represents a single fulfillment in an order. 
	open class Fulfillment: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = FulfillmentQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "fulfillmentLineItems":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Fulfillment.self, field: fieldName, value: fieldValue)
				}
				return try FulfillmentLineItemConnection(fields: value)

				case "trackingCompany":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Fulfillment.self, field: fieldName, value: fieldValue)
				}
				return value

				case "trackingInfo":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Fulfillment.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try FulfillmentTrackingInfo(fields: $0) }

				default:
				throw SchemaViolationError(type: Fulfillment.self, field: fieldName, value: fieldValue)
			}
		}

		/// List of the fulfillment's line items. 
		open var fulfillmentLineItems: Storefront.FulfillmentLineItemConnection {
			return internalGetFulfillmentLineItems()
		}

		open func aliasedFulfillmentLineItems(alias: String) -> Storefront.FulfillmentLineItemConnection {
			return internalGetFulfillmentLineItems(alias: alias)
		}

		func internalGetFulfillmentLineItems(alias: String? = nil) -> Storefront.FulfillmentLineItemConnection {
			return field(field: "fulfillmentLineItems", aliasSuffix: alias) as! Storefront.FulfillmentLineItemConnection
		}

		/// The name of the tracking company. 
		open var trackingCompany: String? {
			return internalGetTrackingCompany()
		}

		func internalGetTrackingCompany(alias: String? = nil) -> String? {
			return field(field: "trackingCompany", aliasSuffix: alias) as! String?
		}

		/// Tracking information associated with the fulfillment, such as the tracking 
		/// number and tracking URL. 
		open var trackingInfo: [Storefront.FulfillmentTrackingInfo] {
			return internalGetTrackingInfo()
		}

		open func aliasedTrackingInfo(alias: String) -> [Storefront.FulfillmentTrackingInfo] {
			return internalGetTrackingInfo(alias: alias)
		}

		func internalGetTrackingInfo(alias: String? = nil) -> [Storefront.FulfillmentTrackingInfo] {
			return field(field: "trackingInfo", aliasSuffix: alias) as! [Storefront.FulfillmentTrackingInfo]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "fulfillmentLineItems":
					response.append(internalGetFulfillmentLineItems())
					response.append(contentsOf: internalGetFulfillmentLineItems().childResponseObjectMap())

					case "trackingInfo":
					internalGetTrackingInfo().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

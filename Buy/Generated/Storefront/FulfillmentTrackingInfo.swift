//
//  FulfillmentTrackingInfo.swift
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
	/// Tracking information associated with the fulfillment. 
	open class FulfillmentTrackingInfoQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = FulfillmentTrackingInfo

		/// The tracking number of the fulfillment. 
		@discardableResult
		open func number(alias: String? = nil) -> FulfillmentTrackingInfoQuery {
			addField(field: "number", aliasSuffix: alias)
			return self
		}

		/// The URL to track the fulfillment. 
		@discardableResult
		open func url(alias: String? = nil) -> FulfillmentTrackingInfoQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// Tracking information associated with the fulfillment. 
	open class FulfillmentTrackingInfo: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = FulfillmentTrackingInfoQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "number":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: FulfillmentTrackingInfo.self, field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: FulfillmentTrackingInfo.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: FulfillmentTrackingInfo.self, field: fieldName, value: fieldValue)
			}
		}

		/// The tracking number of the fulfillment. 
		open var number: String? {
			return internalGetNumber()
		}

		func internalGetNumber(alias: String? = nil) -> String? {
			return field(field: "number", aliasSuffix: alias) as! String?
		}

		/// The URL to track the fulfillment. 
		open var url: URL? {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> URL? {
			return field(field: "url", aliasSuffix: alias) as! URL?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

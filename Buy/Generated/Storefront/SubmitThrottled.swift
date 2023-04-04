//
//  SubmitThrottled.swift
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
	/// Cart submit for checkout completion is throttled. 
	open class SubmitThrottledQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SubmitThrottled

		/// UTC date time string that indicates the time after which clients should 
		/// make their next poll request. Any poll requests sent before this time will 
		/// be ignored. Use this value to schedule the next poll request. 
		@discardableResult
		open func pollAfter(alias: String? = nil) -> SubmitThrottledQuery {
			addField(field: "pollAfter", aliasSuffix: alias)
			return self
		}
	}

	/// Cart submit for checkout completion is throttled. 
	open class SubmitThrottled: GraphQL.AbstractResponse, GraphQLObject, CartSubmitForCompletionResult {
		public typealias Query = SubmitThrottledQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "pollAfter":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SubmitThrottled.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: SubmitThrottled.self, field: fieldName, value: fieldValue)
			}
		}

		/// UTC date time string that indicates the time after which clients should 
		/// make their next poll request. Any poll requests sent before this time will 
		/// be ignored. Use this value to schedule the next poll request. 
		open var pollAfter: Date {
			return internalGetPollAfter()
		}

		func internalGetPollAfter(alias: String? = nil) -> Date {
			return field(field: "pollAfter", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

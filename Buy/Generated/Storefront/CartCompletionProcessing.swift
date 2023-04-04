//
//  CartCompletionProcessing.swift
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
	/// A cart checkout completion that's still processing. 
	open class CartCompletionProcessingQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCompletionProcessing

		/// The ID of the cart completion attempt. 
		@discardableResult
		open func id(alias: String? = nil) -> CartCompletionProcessingQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The number of milliseconds to wait before polling again. 
		@discardableResult
		open func pollDelay(alias: String? = nil) -> CartCompletionProcessingQuery {
			addField(field: "pollDelay", aliasSuffix: alias)
			return self
		}
	}

	/// A cart checkout completion that's still processing. 
	open class CartCompletionProcessing: GraphQL.AbstractResponse, GraphQLObject, CartCompletionAttemptResult {
		public typealias Query = CartCompletionProcessingQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartCompletionProcessing.self, field: fieldName, value: fieldValue)
				}
				return value

				case "pollDelay":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: CartCompletionProcessing.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: CartCompletionProcessing.self, field: fieldName, value: fieldValue)
			}
		}

		/// The ID of the cart completion attempt. 
		open var id: String {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> String {
			return field(field: "id", aliasSuffix: alias) as! String
		}

		/// The number of milliseconds to wait before polling again. 
		open var pollDelay: Int32 {
			return internalGetPollDelay()
		}

		func internalGetPollDelay(alias: String? = nil) -> Int32 {
			return field(field: "pollDelay", aliasSuffix: alias) as! Int32
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

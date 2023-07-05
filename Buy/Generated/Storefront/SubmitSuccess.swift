//
//  SubmitSuccess.swift
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
	/// Cart submit for checkout completion is already accepted. 
	open class SubmitSuccessQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SubmitSuccess

		/// The ID of the cart completion attempt that will be used for polling for the 
		/// result. 
		@discardableResult
		open func attemptId(alias: String? = nil) -> SubmitSuccessQuery {
			addField(field: "attemptId", aliasSuffix: alias)
			return self
		}
	}

	/// Cart submit for checkout completion is already accepted. 
	open class SubmitSuccess: GraphQL.AbstractResponse, GraphQLObject, CartSubmitForCompletionResult {
		public typealias Query = SubmitSuccessQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "attemptId":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SubmitSuccess.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: SubmitSuccess.self, field: fieldName, value: fieldValue)
			}
		}

		/// The ID of the cart completion attempt that will be used for polling for the 
		/// result. 
		open var attemptId: String {
			return internalGetAttemptId()
		}

		func internalGetAttemptId(alias: String? = nil) -> String {
			return field(field: "attemptId", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

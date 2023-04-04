//
//  SubmitFailed.swift
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
	/// Cart submit for checkout completion failed. 
	open class SubmitFailedQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SubmitFailed

		/// The URL of the checkout for the cart. 
		@discardableResult
		open func checkoutUrl(alias: String? = nil) -> SubmitFailedQuery {
			addField(field: "checkoutUrl", aliasSuffix: alias)
			return self
		}

		/// The list of errors that occurred from executing the mutation. 
		@discardableResult
		open func errors(alias: String? = nil, _ subfields: (SubmissionErrorQuery) -> Void) -> SubmitFailedQuery {
			let subquery = SubmissionErrorQuery()
			subfields(subquery)

			addField(field: "errors", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Cart submit for checkout completion failed. 
	open class SubmitFailed: GraphQL.AbstractResponse, GraphQLObject, CartSubmitForCompletionResult {
		public typealias Query = SubmitFailedQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkoutUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SubmitFailed.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "errors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SubmitFailed.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SubmissionError(fields: $0) }

				default:
				throw SchemaViolationError(type: SubmitFailed.self, field: fieldName, value: fieldValue)
			}
		}

		/// The URL of the checkout for the cart. 
		open var checkoutUrl: URL? {
			return internalGetCheckoutUrl()
		}

		func internalGetCheckoutUrl(alias: String? = nil) -> URL? {
			return field(field: "checkoutUrl", aliasSuffix: alias) as! URL?
		}

		/// The list of errors that occurred from executing the mutation. 
		open var errors: [Storefront.SubmissionError] {
			return internalGetErrors()
		}

		func internalGetErrors(alias: String? = nil) -> [Storefront.SubmissionError] {
			return field(field: "errors", aliasSuffix: alias) as! [Storefront.SubmissionError]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

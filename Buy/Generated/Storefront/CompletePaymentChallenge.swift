//
//  CompletePaymentChallenge.swift
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
	/// The action for the 3DS payment redirect. 
	open class CompletePaymentChallengeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CompletePaymentChallenge

		/// The URL for the 3DS payment redirect. 
		@discardableResult
		open func redirectUrl(alias: String? = nil) -> CompletePaymentChallengeQuery {
			addField(field: "redirectUrl", aliasSuffix: alias)
			return self
		}
	}

	/// The action for the 3DS payment redirect. 
	open class CompletePaymentChallenge: GraphQL.AbstractResponse, GraphQLObject, CartCompletionAction {
		public typealias Query = CompletePaymentChallengeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "redirectUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CompletePaymentChallenge.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: CompletePaymentChallenge.self, field: fieldName, value: fieldValue)
			}
		}

		/// The URL for the 3DS payment redirect. 
		open var redirectUrl: URL? {
			return internalGetRedirectUrl()
		}

		func internalGetRedirectUrl(alias: String? = nil) -> URL? {
			return field(field: "redirectUrl", aliasSuffix: alias) as! URL?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

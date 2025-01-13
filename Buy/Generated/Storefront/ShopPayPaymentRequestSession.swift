//
//  ShopPayPaymentRequestSession.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// Represents a Shop Pay payment request session. 
	open class ShopPayPaymentRequestSessionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestSession

		/// The checkout URL of the Shop Pay payment request session. 
		@discardableResult
		open func checkoutUrl(alias: String? = nil) -> ShopPayPaymentRequestSessionQuery {
			addField(field: "checkoutUrl", aliasSuffix: alias)
			return self
		}

		/// The payment request associated with the Shop Pay payment request session. 
		@discardableResult
		open func paymentRequest(alias: String? = nil, _ subfields: (ShopPayPaymentRequestQuery) -> Void) -> ShopPayPaymentRequestSessionQuery {
			let subquery = ShopPayPaymentRequestQuery()
			subfields(subquery)

			addField(field: "paymentRequest", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The source identifier of the Shop Pay payment request session. 
		@discardableResult
		open func sourceIdentifier(alias: String? = nil) -> ShopPayPaymentRequestSessionQuery {
			addField(field: "sourceIdentifier", aliasSuffix: alias)
			return self
		}

		/// The token of the Shop Pay payment request session. 
		@discardableResult
		open func token(alias: String? = nil) -> ShopPayPaymentRequestSessionQuery {
			addField(field: "token", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a Shop Pay payment request session. 
	open class ShopPayPaymentRequestSession: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestSessionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkoutUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestSession.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "paymentRequest":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestSession.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequest(fields: value)

				case "sourceIdentifier":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestSession.self, field: fieldName, value: fieldValue)
				}
				return value

				case "token":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestSession.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestSession.self, field: fieldName, value: fieldValue)
			}
		}

		/// The checkout URL of the Shop Pay payment request session. 
		open var checkoutUrl: URL {
			return internalGetCheckoutUrl()
		}

		func internalGetCheckoutUrl(alias: String? = nil) -> URL {
			return field(field: "checkoutUrl", aliasSuffix: alias) as! URL
		}

		/// The payment request associated with the Shop Pay payment request session. 
		open var paymentRequest: Storefront.ShopPayPaymentRequest {
			return internalGetPaymentRequest()
		}

		func internalGetPaymentRequest(alias: String? = nil) -> Storefront.ShopPayPaymentRequest {
			return field(field: "paymentRequest", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequest
		}

		/// The source identifier of the Shop Pay payment request session. 
		open var sourceIdentifier: String {
			return internalGetSourceIdentifier()
		}

		func internalGetSourceIdentifier(alias: String? = nil) -> String {
			return field(field: "sourceIdentifier", aliasSuffix: alias) as! String
		}

		/// The token of the Shop Pay payment request session. 
		open var token: String {
			return internalGetToken()
		}

		func internalGetToken(alias: String? = nil) -> String {
			return field(field: "token", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "paymentRequest":
					response.append(internalGetPaymentRequest())
					response.append(contentsOf: internalGetPaymentRequest().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

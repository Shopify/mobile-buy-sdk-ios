//
//  ShopPayPaymentRequestSessionCreatePayload.swift
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
	/// Return type for `shopPayPaymentRequestSessionCreate` mutation. 
	open class ShopPayPaymentRequestSessionCreatePayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestSessionCreatePayload

		/// The new Shop Pay payment request session object. 
		@discardableResult
		open func shopPayPaymentRequestSession(alias: String? = nil, _ subfields: (ShopPayPaymentRequestSessionQuery) -> Void) -> ShopPayPaymentRequestSessionCreatePayloadQuery {
			let subquery = ShopPayPaymentRequestSessionQuery()
			subfields(subquery)

			addField(field: "shopPayPaymentRequestSession", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Error codes for failed Shop Pay payment request session mutations. 
		@discardableResult
		open func userErrors(alias: String? = nil, _ subfields: (UserErrorsShopPayPaymentRequestSessionUserErrorsQuery) -> Void) -> ShopPayPaymentRequestSessionCreatePayloadQuery {
			let subquery = UserErrorsShopPayPaymentRequestSessionUserErrorsQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Return type for `shopPayPaymentRequestSessionCreate` mutation. 
	open class ShopPayPaymentRequestSessionCreatePayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestSessionCreatePayloadQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "shopPayPaymentRequestSession":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestSessionCreatePayload.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequestSession(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestSessionCreatePayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserErrorsShopPayPaymentRequestSessionUserErrors(fields: $0) }

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestSessionCreatePayload.self, field: fieldName, value: fieldValue)
			}
		}

		/// The new Shop Pay payment request session object. 
		open var shopPayPaymentRequestSession: Storefront.ShopPayPaymentRequestSession? {
			return internalGetShopPayPaymentRequestSession()
		}

		func internalGetShopPayPaymentRequestSession(alias: String? = nil) -> Storefront.ShopPayPaymentRequestSession? {
			return field(field: "shopPayPaymentRequestSession", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequestSession?
		}

		/// Error codes for failed Shop Pay payment request session mutations. 
		open var userErrors: [Storefront.UserErrorsShopPayPaymentRequestSessionUserErrors] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(alias: String? = nil) -> [Storefront.UserErrorsShopPayPaymentRequestSessionUserErrors] {
			return field(field: "userErrors", aliasSuffix: alias) as! [Storefront.UserErrorsShopPayPaymentRequestSessionUserErrors]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "shopPayPaymentRequestSession":
					if let value = internalGetShopPayPaymentRequestSession() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "userErrors":
					internalGetUserErrors().forEach {
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

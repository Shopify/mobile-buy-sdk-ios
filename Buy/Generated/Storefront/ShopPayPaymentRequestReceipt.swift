//
//  ShopPayPaymentRequestReceipt.swift
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
	/// Represents a receipt for a Shop Pay payment request. 
	open class ShopPayPaymentRequestReceiptQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestReceipt

		/// The payment request object. 
		@discardableResult
		open func paymentRequest(alias: String? = nil, _ subfields: (ShopPayPaymentRequestQuery) -> Void) -> ShopPayPaymentRequestReceiptQuery {
			let subquery = ShopPayPaymentRequestQuery()
			subfields(subquery)

			addField(field: "paymentRequest", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The processing status. 
		@discardableResult
		open func processingStatusType(alias: String? = nil) -> ShopPayPaymentRequestReceiptQuery {
			addField(field: "processingStatusType", aliasSuffix: alias)
			return self
		}

		/// The token of the receipt. 
		@discardableResult
		open func token(alias: String? = nil) -> ShopPayPaymentRequestReceiptQuery {
			addField(field: "token", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a receipt for a Shop Pay payment request. 
	open class ShopPayPaymentRequestReceipt: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestReceiptQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "paymentRequest":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestReceipt.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequest(fields: value)

				case "processingStatusType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestReceipt.self, field: fieldName, value: fieldValue)
				}
				return value

				case "token":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestReceipt.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestReceipt.self, field: fieldName, value: fieldValue)
			}
		}

		/// The payment request object. 
		open var paymentRequest: Storefront.ShopPayPaymentRequest {
			return internalGetPaymentRequest()
		}

		func internalGetPaymentRequest(alias: String? = nil) -> Storefront.ShopPayPaymentRequest {
			return field(field: "paymentRequest", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequest
		}

		/// The processing status. 
		open var processingStatusType: String {
			return internalGetProcessingStatusType()
		}

		func internalGetProcessingStatusType(alias: String? = nil) -> String {
			return field(field: "processingStatusType", aliasSuffix: alias) as! String
		}

		/// The token of the receipt. 
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

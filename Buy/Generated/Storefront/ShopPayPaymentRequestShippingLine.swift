//
//  ShopPayPaymentRequestShippingLine.swift
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
	/// Represents a shipping line for a Shop Pay payment request. 
	open class ShopPayPaymentRequestShippingLineQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestShippingLine

		/// The amount for the shipping line. 
		@discardableResult
		open func amount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestShippingLineQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "amount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The code of the shipping line. 
		@discardableResult
		open func code(alias: String? = nil) -> ShopPayPaymentRequestShippingLineQuery {
			addField(field: "code", aliasSuffix: alias)
			return self
		}

		/// The label of the shipping line. 
		@discardableResult
		open func label(alias: String? = nil) -> ShopPayPaymentRequestShippingLineQuery {
			addField(field: "label", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a shipping line for a Shop Pay payment request. 
	open class ShopPayPaymentRequestShippingLine: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestShippingLineQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestShippingLine.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "code":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestShippingLine.self, field: fieldName, value: fieldValue)
				}
				return value

				case "label":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestShippingLine.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestShippingLine.self, field: fieldName, value: fieldValue)
			}
		}

		/// The amount for the shipping line. 
		open var amount: Storefront.MoneyV2 {
			return internalGetAmount()
		}

		func internalGetAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "amount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The code of the shipping line. 
		open var code: String {
			return internalGetCode()
		}

		func internalGetCode(alias: String? = nil) -> String {
			return field(field: "code", aliasSuffix: alias) as! String
		}

		/// The label of the shipping line. 
		open var label: String {
			return internalGetLabel()
		}

		func internalGetLabel(alias: String? = nil) -> String {
			return field(field: "label", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "amount":
					response.append(internalGetAmount())
					response.append(contentsOf: internalGetAmount().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

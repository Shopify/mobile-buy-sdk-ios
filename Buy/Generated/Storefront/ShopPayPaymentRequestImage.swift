//
//  ShopPayPaymentRequestImage.swift
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
	/// Represents an image for a Shop Pay payment request line item. 
	open class ShopPayPaymentRequestImageQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestImage

		/// The alt text of the image. 
		@discardableResult
		open func alt(alias: String? = nil) -> ShopPayPaymentRequestImageQuery {
			addField(field: "alt", aliasSuffix: alias)
			return self
		}

		/// The source URL of the image. 
		@discardableResult
		open func url(alias: String? = nil) -> ShopPayPaymentRequestImageQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// Represents an image for a Shop Pay payment request line item. 
	open class ShopPayPaymentRequestImage: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestImageQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "alt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestImage.self, field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestImage.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestImage.self, field: fieldName, value: fieldValue)
			}
		}

		/// The alt text of the image. 
		open var alt: String? {
			return internalGetAlt()
		}

		func internalGetAlt(alias: String? = nil) -> String? {
			return field(field: "alt", aliasSuffix: alias) as! String?
		}

		/// The source URL of the image. 
		open var url: String {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> String {
			return field(field: "url", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

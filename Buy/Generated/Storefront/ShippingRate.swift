//
//  ShippingRate.swift
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
	/// A shipping rate to be applied to a checkout. 
	open class ShippingRateQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShippingRate

		/// Human-readable unique identifier for this shipping rate. 
		@discardableResult
		open func handle(alias: String? = nil) -> ShippingRateQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// Price of this shipping rate. 
		@discardableResult
		open func price(alias: String? = nil) -> ShippingRateQuery {
			addField(field: "price", aliasSuffix: alias)
			return self
		}

		/// Title of this shipping rate. 
		@discardableResult
		open func title(alias: String? = nil) -> ShippingRateQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}
	}

	/// A shipping rate to be applied to a checkout. 
	open class ShippingRate: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShippingRateQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "price":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// Human-readable unique identifier for this shipping rate. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// Price of this shipping rate. 
		open var price: Decimal {
			return internalGetPrice()
		}

		func internalGetPrice(alias: String? = nil) -> Decimal {
			return field(field: "price", aliasSuffix: alias) as! Decimal
		}

		/// Title of this shipping rate. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

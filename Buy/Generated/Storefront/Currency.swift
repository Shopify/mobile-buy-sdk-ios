//
//  Currency.swift
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
	/// A currency. 
	open class CurrencyQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Currency

		/// The ISO code of the currency. 
		@discardableResult
		open func isoCode(alias: String? = nil) -> CurrencyQuery {
			addField(field: "isoCode", aliasSuffix: alias)
			return self
		}

		/// The name of the currency. 
		@discardableResult
		open func name(alias: String? = nil) -> CurrencyQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// The symbol of the currency. 
		@discardableResult
		open func symbol(alias: String? = nil) -> CurrencyQuery {
			addField(field: "symbol", aliasSuffix: alias)
			return self
		}
	}

	/// A currency. 
	open class Currency: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CurrencyQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "isoCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Currency.self, field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Currency.self, field: fieldName, value: fieldValue)
				}
				return value

				case "symbol":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Currency.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Currency.self, field: fieldName, value: fieldValue)
			}
		}

		/// The ISO code of the currency. 
		open var isoCode: Storefront.CurrencyCode {
			return internalGetIsoCode()
		}

		func internalGetIsoCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "isoCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// The name of the currency. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// The symbol of the currency. 
		open var symbol: String {
			return internalGetSymbol()
		}

		func internalGetSymbol(alias: String? = nil) -> String {
			return field(field: "symbol", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

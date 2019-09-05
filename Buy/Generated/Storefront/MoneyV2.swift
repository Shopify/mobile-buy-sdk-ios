//
//  MoneyV2.swift
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
	/// A monetary value with currency. To format currencies, combine this type's 
	/// amount and currencyCode fields with your client's locale. For example, in 
	/// JavaScript you could use Intl.NumberFormat: ```js new 
	/// Intl.NumberFormat(locale, { style: 'currency', currency: currencyCode 
	/// }).format(amount); ``` Other formatting libraries include: * iOS - 
	/// [NumberFormatter](https://developer.apple.com/documentation/foundation/numberformatter) 
	/// * Android - 
	/// [NumberFormat](https://developer.android.com/reference/java/text/NumberFormat.html) 
	/// * PHP - 
	/// [NumberFormatter](http://php.net/manual/en/class.numberformatter.php) For a 
	/// more general solution, the [Unicode CLDR number formatting database] is 
	/// available with many implementations (such as 
	/// [TwitterCldr](https://github.com/twitter/twitter-cldr-rb)). 
	open class MoneyV2Query: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MoneyV2

		/// Decimal money amount. 
		@discardableResult
		open func amount(alias: String? = nil) -> MoneyV2Query {
			addField(field: "amount", aliasSuffix: alias)
			return self
		}

		/// Currency of the money. 
		@discardableResult
		open func currencyCode(alias: String? = nil) -> MoneyV2Query {
			addField(field: "currencyCode", aliasSuffix: alias)
			return self
		}
	}

	/// A monetary value with currency. To format currencies, combine this type's 
	/// amount and currencyCode fields with your client's locale. For example, in 
	/// JavaScript you could use Intl.NumberFormat: ```js new 
	/// Intl.NumberFormat(locale, { style: 'currency', currency: currencyCode 
	/// }).format(amount); ``` Other formatting libraries include: * iOS - 
	/// [NumberFormatter](https://developer.apple.com/documentation/foundation/numberformatter) 
	/// * Android - 
	/// [NumberFormat](https://developer.android.com/reference/java/text/NumberFormat.html) 
	/// * PHP - 
	/// [NumberFormatter](http://php.net/manual/en/class.numberformatter.php) For a 
	/// more general solution, the [Unicode CLDR number formatting database] is 
	/// available with many implementations (such as 
	/// [TwitterCldr](https://github.com/twitter/twitter-cldr-rb)). 
	open class MoneyV2: GraphQL.AbstractResponse, GraphQLObject, PricingValue {
		public typealias Query = MoneyV2Query

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MoneyV2.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MoneyV2.self, field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: MoneyV2.self, field: fieldName, value: fieldValue)
			}
		}

		/// Decimal money amount. 
		open var amount: Decimal {
			return internalGetAmount()
		}

		func internalGetAmount(alias: String? = nil) -> Decimal {
			return field(field: "amount", aliasSuffix: alias) as! Decimal
		}

		/// Currency of the money. 
		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

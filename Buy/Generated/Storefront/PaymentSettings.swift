//
//  PaymentSettings.swift
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
	/// Values required for completing various payment methods. 
	open class PaymentSettingsQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PaymentSettings

		/// The url pointing to the endpoint to vault credit cards. 
		@discardableResult
		open func cardVaultUrl(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "cardVaultUrl", aliasSuffix: alias)
			return self
		}

		/// The two-letter code for where the shop is located. 
		@discardableResult
		open func countryCode(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// The three-letter code for the currency that the shop accepts. 
		@discardableResult
		open func currencyCode(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "currencyCode", aliasSuffix: alias)
			return self
		}

		/// The shop’s Shopify Payments account id. 
		@discardableResult
		open func shopifyPaymentsAccountId(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "shopifyPaymentsAccountId", aliasSuffix: alias)
			return self
		}
	}

	/// Values required for completing various payment methods. 
	open class PaymentSettings: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = PaymentSettingsQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cardVaultUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "countryCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return CountryCode(rawValue: value) ?? .unknownValue

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "shopifyPaymentsAccountId":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The url pointing to the endpoint to vault credit cards. 
		open var cardVaultUrl: URL {
			return internalGetCardVaultUrl()
		}

		func internalGetCardVaultUrl(alias: String? = nil) -> URL {
			return field(field: "cardVaultUrl", aliasSuffix: alias) as! URL
		}

		/// The two-letter code for where the shop is located. 
		open var countryCode: Storefront.CountryCode {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> Storefront.CountryCode {
			return field(field: "countryCode", aliasSuffix: alias) as! Storefront.CountryCode
		}

		/// The three-letter code for the currency that the shop accepts. 
		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// The shop’s Shopify Payments account id. 
		open var shopifyPaymentsAccountId: String? {
			return internalGetShopifyPaymentsAccountId()
		}

		func internalGetShopifyPaymentsAccountId(alias: String? = nil) -> String? {
			return field(field: "shopifyPaymentsAccountId", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

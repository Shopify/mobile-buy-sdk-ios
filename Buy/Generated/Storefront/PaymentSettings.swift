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
	/// Settings related to payments. 
	open class PaymentSettingsQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PaymentSettings

		/// List of the card brands which the shop accepts. 
		@discardableResult
		open func acceptedCardBrands(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "acceptedCardBrands", aliasSuffix: alias)
			return self
		}

		/// The url pointing to the endpoint to vault credit cards. 
		@discardableResult
		open func cardVaultUrl(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "cardVaultUrl", aliasSuffix: alias)
			return self
		}

		/// The country where the shop is located. 
		@discardableResult
		open func countryCode(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// The three-letter code for the shop's primary currency. 
		@discardableResult
		open func currencyCode(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "currencyCode", aliasSuffix: alias)
			return self
		}

		/// A list of enabled currencies (ISO 4217 format) that the shop accepts. 
		/// Merchants can enable currencies from their Shopify Payments settings in the 
		/// Shopify admin. 
		@discardableResult
		open func enabledPresentmentCurrencies(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "enabledPresentmentCurrencies", aliasSuffix: alias)
			return self
		}

		/// The shop’s Shopify Payments account id. 
		@discardableResult
		open func shopifyPaymentsAccountId(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "shopifyPaymentsAccountId", aliasSuffix: alias)
			return self
		}

		/// List of the digital wallets which the shop supports. 
		@discardableResult
		open func supportedDigitalWallets(alias: String? = nil) -> PaymentSettingsQuery {
			addField(field: "supportedDigitalWallets", aliasSuffix: alias)
			return self
		}
	}

	/// Settings related to payments. 
	open class PaymentSettings: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = PaymentSettingsQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "acceptedCardBrands":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
				}
				return value.map { return CardBrand(rawValue: $0) ?? .unknownValue }

				case "cardVaultUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "countryCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
				}
				return CountryCode(rawValue: value) ?? .unknownValue

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "enabledPresentmentCurrencies":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
				}
				return value.map { return CurrencyCode(rawValue: $0) ?? .unknownValue }

				case "shopifyPaymentsAccountId":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
				}
				return value

				case "supportedDigitalWallets":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
				}
				return value.map { return DigitalWallet(rawValue: $0) ?? .unknownValue }

				default:
				throw SchemaViolationError(type: PaymentSettings.self, field: fieldName, value: fieldValue)
			}
		}

		/// List of the card brands which the shop accepts. 
		open var acceptedCardBrands: [Storefront.CardBrand] {
			return internalGetAcceptedCardBrands()
		}

		func internalGetAcceptedCardBrands(alias: String? = nil) -> [Storefront.CardBrand] {
			return field(field: "acceptedCardBrands", aliasSuffix: alias) as! [Storefront.CardBrand]
		}

		/// The url pointing to the endpoint to vault credit cards. 
		open var cardVaultUrl: URL {
			return internalGetCardVaultUrl()
		}

		func internalGetCardVaultUrl(alias: String? = nil) -> URL {
			return field(field: "cardVaultUrl", aliasSuffix: alias) as! URL
		}

		/// The country where the shop is located. 
		open var countryCode: Storefront.CountryCode {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> Storefront.CountryCode {
			return field(field: "countryCode", aliasSuffix: alias) as! Storefront.CountryCode
		}

		/// The three-letter code for the shop's primary currency. 
		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// A list of enabled currencies (ISO 4217 format) that the shop accepts. 
		/// Merchants can enable currencies from their Shopify Payments settings in the 
		/// Shopify admin. 
		open var enabledPresentmentCurrencies: [Storefront.CurrencyCode] {
			return internalGetEnabledPresentmentCurrencies()
		}

		func internalGetEnabledPresentmentCurrencies(alias: String? = nil) -> [Storefront.CurrencyCode] {
			return field(field: "enabledPresentmentCurrencies", aliasSuffix: alias) as! [Storefront.CurrencyCode]
		}

		/// The shop’s Shopify Payments account id. 
		open var shopifyPaymentsAccountId: String? {
			return internalGetShopifyPaymentsAccountId()
		}

		func internalGetShopifyPaymentsAccountId(alias: String? = nil) -> String? {
			return field(field: "shopifyPaymentsAccountId", aliasSuffix: alias) as! String?
		}

		/// List of the digital wallets which the shop supports. 
		open var supportedDigitalWallets: [Storefront.DigitalWallet] {
			return internalGetSupportedDigitalWallets()
		}

		func internalGetSupportedDigitalWallets(alias: String? = nil) -> [Storefront.DigitalWallet] {
			return field(field: "supportedDigitalWallets", aliasSuffix: alias) as! [Storefront.DigitalWallet]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

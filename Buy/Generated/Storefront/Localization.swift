//
//  Localization.swift
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
	/// Information about the localized experiences configured for the shop. 
	open class LocalizationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Localization

		/// The list of countries with enabled localized experiences. 
		@discardableResult
		open func availableCountries(alias: String? = nil, _ subfields: (CountryQuery) -> Void) -> LocalizationQuery {
			let subquery = CountryQuery()
			subfields(subquery)

			addField(field: "availableCountries", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The list of languages available for the active country. 
		@discardableResult
		open func availableLanguages(alias: String? = nil, _ subfields: (LanguageQuery) -> Void) -> LocalizationQuery {
			let subquery = LanguageQuery()
			subfields(subquery)

			addField(field: "availableLanguages", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The country of the active localized experience. Use the `@inContext` 
		/// directive to change this value. 
		@discardableResult
		open func country(alias: String? = nil, _ subfields: (CountryQuery) -> Void) -> LocalizationQuery {
			let subquery = CountryQuery()
			subfields(subquery)

			addField(field: "country", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The language of the active localized experience. Use the `@inContext` 
		/// directive to change this value. 
		@discardableResult
		open func language(alias: String? = nil, _ subfields: (LanguageQuery) -> Void) -> LocalizationQuery {
			let subquery = LanguageQuery()
			subfields(subquery)

			addField(field: "language", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The market including the country of the active localized experience. Use 
		/// the `@inContext` directive to change this value. 
		@discardableResult
		open func market(alias: String? = nil, _ subfields: (MarketQuery) -> Void) -> LocalizationQuery {
			let subquery = MarketQuery()
			subfields(subquery)

			addField(field: "market", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Information about the localized experiences configured for the shop. 
	open class Localization: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = LocalizationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "availableCountries":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Country(fields: $0) }

				case "availableLanguages":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Language(fields: $0) }

				case "country":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
				}
				return try Country(fields: value)

				case "language":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
				}
				return try Language(fields: value)

				case "market":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
				}
				return try Market(fields: value)

				default:
				throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
			}
		}

		/// The list of countries with enabled localized experiences. 
		open var availableCountries: [Storefront.Country] {
			return internalGetAvailableCountries()
		}

		func internalGetAvailableCountries(alias: String? = nil) -> [Storefront.Country] {
			return field(field: "availableCountries", aliasSuffix: alias) as! [Storefront.Country]
		}

		/// The list of languages available for the active country. 
		open var availableLanguages: [Storefront.Language] {
			return internalGetAvailableLanguages()
		}

		func internalGetAvailableLanguages(alias: String? = nil) -> [Storefront.Language] {
			return field(field: "availableLanguages", aliasSuffix: alias) as! [Storefront.Language]
		}

		/// The country of the active localized experience. Use the `@inContext` 
		/// directive to change this value. 
		open var country: Storefront.Country {
			return internalGetCountry()
		}

		func internalGetCountry(alias: String? = nil) -> Storefront.Country {
			return field(field: "country", aliasSuffix: alias) as! Storefront.Country
		}

		/// The language of the active localized experience. Use the `@inContext` 
		/// directive to change this value. 
		open var language: Storefront.Language {
			return internalGetLanguage()
		}

		func internalGetLanguage(alias: String? = nil) -> Storefront.Language {
			return field(field: "language", aliasSuffix: alias) as! Storefront.Language
		}

		/// The market including the country of the active localized experience. Use 
		/// the `@inContext` directive to change this value. 
		open var market: Storefront.Market {
			return internalGetMarket()
		}

		func internalGetMarket(alias: String? = nil) -> Storefront.Market {
			return field(field: "market", aliasSuffix: alias) as! Storefront.Market
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "availableCountries":
					internalGetAvailableCountries().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "availableLanguages":
					internalGetAvailableLanguages().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "country":
					response.append(internalGetCountry())
					response.append(contentsOf: internalGetCountry().childResponseObjectMap())

					case "language":
					response.append(internalGetLanguage())
					response.append(contentsOf: internalGetLanguage().childResponseObjectMap())

					case "market":
					response.append(internalGetMarket())
					response.append(contentsOf: internalGetMarket().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

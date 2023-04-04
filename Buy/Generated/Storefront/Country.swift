//
//  Country.swift
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
	/// A country. 
	open class CountryQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Country

		/// The languages available for the country. 
		@discardableResult
		open func availableLanguages(alias: String? = nil, _ subfields: (LanguageQuery) -> Void) -> CountryQuery {
			let subquery = LanguageQuery()
			subfields(subquery)

			addField(field: "availableLanguages", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The currency of the country. 
		@discardableResult
		open func currency(alias: String? = nil, _ subfields: (CurrencyQuery) -> Void) -> CountryQuery {
			let subquery = CurrencyQuery()
			subfields(subquery)

			addField(field: "currency", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The ISO code of the country. 
		@discardableResult
		open func isoCode(alias: String? = nil) -> CountryQuery {
			addField(field: "isoCode", aliasSuffix: alias)
			return self
		}

		/// The market that includes this country. 
		@discardableResult
		open func market(alias: String? = nil, _ subfields: (MarketQuery) -> Void) -> CountryQuery {
			let subquery = MarketQuery()
			subfields(subquery)

			addField(field: "market", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The name of the country. 
		@discardableResult
		open func name(alias: String? = nil) -> CountryQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// The unit system used in the country. 
		@discardableResult
		open func unitSystem(alias: String? = nil) -> CountryQuery {
			addField(field: "unitSystem", aliasSuffix: alias)
			return self
		}
	}

	/// A country. 
	open class Country: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CountryQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "availableLanguages":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Country.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Language(fields: $0) }

				case "currency":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Country.self, field: fieldName, value: fieldValue)
				}
				return try Currency(fields: value)

				case "isoCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Country.self, field: fieldName, value: fieldValue)
				}
				return CountryCode(rawValue: value) ?? .unknownValue

				case "market":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Country.self, field: fieldName, value: fieldValue)
				}
				return try Market(fields: value)

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Country.self, field: fieldName, value: fieldValue)
				}
				return value

				case "unitSystem":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Country.self, field: fieldName, value: fieldValue)
				}
				return UnitSystem(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: Country.self, field: fieldName, value: fieldValue)
			}
		}

		/// The languages available for the country. 
		open var availableLanguages: [Storefront.Language] {
			return internalGetAvailableLanguages()
		}

		func internalGetAvailableLanguages(alias: String? = nil) -> [Storefront.Language] {
			return field(field: "availableLanguages", aliasSuffix: alias) as! [Storefront.Language]
		}

		/// The currency of the country. 
		open var currency: Storefront.Currency {
			return internalGetCurrency()
		}

		func internalGetCurrency(alias: String? = nil) -> Storefront.Currency {
			return field(field: "currency", aliasSuffix: alias) as! Storefront.Currency
		}

		/// The ISO code of the country. 
		open var isoCode: Storefront.CountryCode {
			return internalGetIsoCode()
		}

		func internalGetIsoCode(alias: String? = nil) -> Storefront.CountryCode {
			return field(field: "isoCode", aliasSuffix: alias) as! Storefront.CountryCode
		}

		/// The market that includes this country. 
		open var market: Storefront.Market? {
			return internalGetMarket()
		}

		func internalGetMarket(alias: String? = nil) -> Storefront.Market? {
			return field(field: "market", aliasSuffix: alias) as! Storefront.Market?
		}

		/// The name of the country. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// The unit system used in the country. 
		open var unitSystem: Storefront.UnitSystem {
			return internalGetUnitSystem()
		}

		func internalGetUnitSystem(alias: String? = nil) -> Storefront.UnitSystem {
			return field(field: "unitSystem", aliasSuffix: alias) as! Storefront.UnitSystem
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "availableLanguages":
					internalGetAvailableLanguages().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "currency":
					response.append(internalGetCurrency())
					response.append(contentsOf: internalGetCurrency().childResponseObjectMap())

					case "market":
					if let value = internalGetMarket() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

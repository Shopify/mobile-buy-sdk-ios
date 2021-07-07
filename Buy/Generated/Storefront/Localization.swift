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

		/// List of countries with enabled localized experiences. 
		@discardableResult
		open func availableCountries(alias: String? = nil, _ subfields: (CountryQuery) -> Void) -> LocalizationQuery {
			let subquery = CountryQuery()
			subfields(subquery)

			addField(field: "availableCountries", aliasSuffix: alias, subfields: subquery)
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

				case "country":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
				}
				return try Country(fields: value)

				default:
				throw SchemaViolationError(type: Localization.self, field: fieldName, value: fieldValue)
			}
		}

		/// List of countries with enabled localized experiences. 
		open var availableCountries: [Storefront.Country] {
			return internalGetAvailableCountries()
		}

		func internalGetAvailableCountries(alias: String? = nil) -> [Storefront.Country] {
			return field(field: "availableCountries", aliasSuffix: alias) as! [Storefront.Country]
		}

		/// The country of the active localized experience. Use the `@inContext` 
		/// directive to change this value. 
		open var country: Storefront.Country {
			return internalGetCountry()
		}

		func internalGetCountry(alias: String? = nil) -> Storefront.Country {
			return field(field: "country", aliasSuffix: alias) as! Storefront.Country
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

					case "country":
					response.append(internalGetCountry())
					response.append(contentsOf: internalGetCountry().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

//
//  ConsentManagement.swift
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
	/// Interaction of the current visitor consent with the configured consent 
	/// policies of the shop. 
	open class ConsentManagementQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ConsentManagement

		/// The privacy banner that should be displayed to the visitor, if any, plus 
		/// the list of country/regions configured in the cookie banner visibility. 
		@discardableResult
		open func banner(alias: String? = nil, _ subfields: (ConsentManagementBannerQuery) -> Void) -> ConsentManagementQuery {
			let subquery = ConsentManagementBannerQuery()
			subfields(subquery)

			addField(field: "banner", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Given the provided visitor consent, the resulting ConsentManagementCookies 
		/// that need to be setin the browser for the Consent Management Platform to 
		/// work and respect visitor consent. 
		///
		/// - parameters:
		///     - landingPage: A possible landing_page that was on hold to be set when consent is granted.
		///     - origReferrer: A possible referrer that was on hold to be set when consent is granted.
		///     - visitorConsent: The latest visitor consent that the cookies should be calculated for.
		///     - visitorEmail: If known, the visitor email. It will be used to fetch their Do Not Sell my Data opt out preferences if any.
		///
		@discardableResult
		open func cookies(alias: String? = nil, landingPage: String? = nil, origReferrer: String? = nil, visitorConsent: VisitorConsent, visitorEmail: String? = nil, _ subfields: (ConsentManagementCookiesQuery) -> Void) -> ConsentManagementQuery {
			var args: [String] = []

			args.append("visitorConsent:\(visitorConsent.serialize())")

			if let landingPage = landingPage {
				args.append("landingPage:\(GraphQL.quoteString(input: landingPage))")
			}

			if let origReferrer = origReferrer {
				args.append("origReferrer:\(GraphQL.quoteString(input: origReferrer))")
			}

			if let visitorEmail = visitorEmail {
				args.append("visitorEmail:\(GraphQL.quoteString(input: visitorEmail))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ConsentManagementCookiesQuery()
			subfields(subquery)

			addField(field: "cookies", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// For debugging purposes, decodes the cookies from `_shopify_essential`, 
		/// `_shopify_analytics` etc and prints them in plain text. 
		@discardableResult
		open func currentCookies(alias: String? = nil) -> ConsentManagementQuery {
			addField(field: "currentCookies", aliasSuffix: alias)
			return self
		}

		/// URL to the customer accounts page. 
		@discardableResult
		open func customerAccountUrl(alias: String? = nil) -> ConsentManagementQuery {
			addField(field: "customerAccountUrl", aliasSuffix: alias)
			return self
		}

		/// List of ISO3166 2-character country codes where the sale of data is 
		/// enabled. 
		@discardableResult
		open func saleOfDataRegions(alias: String? = nil) -> ConsentManagementQuery {
			addField(field: "saleOfDataRegions", aliasSuffix: alias)
			return self
		}
	}

	/// Interaction of the current visitor consent with the configured consent 
	/// policies of the shop. 
	open class ConsentManagement: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ConsentManagementQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "banner":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ConsentManagement.self, field: fieldName, value: fieldValue)
				}
				return try ConsentManagementBanner(fields: value)

				case "cookies":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ConsentManagement.self, field: fieldName, value: fieldValue)
				}
				return try ConsentManagementCookies(fields: value)

				case "currentCookies":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagement.self, field: fieldName, value: fieldValue)
				}
				return value

				case "customerAccountUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagement.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "saleOfDataRegions":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: ConsentManagement.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				default:
				throw SchemaViolationError(type: ConsentManagement.self, field: fieldName, value: fieldValue)
			}
		}

		/// The privacy banner that should be displayed to the visitor, if any, plus 
		/// the list of country/regions configured in the cookie banner visibility. 
		open var banner: Storefront.ConsentManagementBanner? {
			return internalGetBanner()
		}

		func internalGetBanner(alias: String? = nil) -> Storefront.ConsentManagementBanner? {
			return field(field: "banner", aliasSuffix: alias) as! Storefront.ConsentManagementBanner?
		}

		/// Given the provided visitor consent, the resulting ConsentManagementCookies 
		/// that need to be setin the browser for the Consent Management Platform to 
		/// work and respect visitor consent. 
		open var cookies: Storefront.ConsentManagementCookies {
			return internalGetCookies()
		}

		open func aliasedCookies(alias: String) -> Storefront.ConsentManagementCookies {
			return internalGetCookies(alias: alias)
		}

		func internalGetCookies(alias: String? = nil) -> Storefront.ConsentManagementCookies {
			return field(field: "cookies", aliasSuffix: alias) as! Storefront.ConsentManagementCookies
		}

		/// For debugging purposes, decodes the cookies from `_shopify_essential`, 
		/// `_shopify_analytics` etc and prints them in plain text. 
		open var currentCookies: String {
			return internalGetCurrentCookies()
		}

		func internalGetCurrentCookies(alias: String? = nil) -> String {
			return field(field: "currentCookies", aliasSuffix: alias) as! String
		}

		/// URL to the customer accounts page. 
		open var customerAccountUrl: URL? {
			return internalGetCustomerAccountUrl()
		}

		func internalGetCustomerAccountUrl(alias: String? = nil) -> URL? {
			return field(field: "customerAccountUrl", aliasSuffix: alias) as! URL?
		}

		/// List of ISO3166 2-character country codes where the sale of data is 
		/// enabled. 
		open var saleOfDataRegions: [String] {
			return internalGetSaleOfDataRegions()
		}

		func internalGetSaleOfDataRegions(alias: String? = nil) -> [String] {
			return field(field: "saleOfDataRegions", aliasSuffix: alias) as! [String]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "banner":
					if let value = internalGetBanner() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cookies":
					response.append(internalGetCookies())
					response.append(contentsOf: internalGetCookies().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

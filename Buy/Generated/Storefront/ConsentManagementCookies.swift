//
//  ConsentManagementCookies.swift
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
	/// Computed cookies needed by the Consent Management Platform to respect and 
	/// query visitor consent. 
	open class ConsentManagementCookiesQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ConsentManagementCookies

		/// The domain that the cookies will be set for. 
		@discardableResult
		open func cookieDomain(alias: String? = nil) -> ConsentManagementCookiesQuery {
			addField(field: "cookieDomain", aliasSuffix: alias)
			return self
		}

		/// If needed, the _landing_page cookie to set. 
		@discardableResult
		open func landingPageCookie(alias: String? = nil) -> ConsentManagementCookiesQuery {
			addField(field: "landingPageCookie", aliasSuffix: alias)
			return self
		}

		/// If needed, the _orig_referrer cookie to set. 
		@discardableResult
		open func origReferrerCookie(alias: String? = nil) -> ConsentManagementCookiesQuery {
			addField(field: "origReferrerCookie", aliasSuffix: alias)
			return self
		}

		/// The _tracking_consent cookie, already URI encoded and serialized. 
		@discardableResult
		open func trackingConsentCookie(alias: String? = nil) -> ConsentManagementCookiesQuery {
			addField(field: "trackingConsentCookie", aliasSuffix: alias)
			return self
		}
	}

	/// Computed cookies needed by the Consent Management Platform to respect and 
	/// query visitor consent. 
	open class ConsentManagementCookies: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ConsentManagementCookiesQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cookieDomain":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementCookies.self, field: fieldName, value: fieldValue)
				}
				return value

				case "landingPageCookie":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementCookies.self, field: fieldName, value: fieldValue)
				}
				return value

				case "origReferrerCookie":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementCookies.self, field: fieldName, value: fieldValue)
				}
				return value

				case "trackingConsentCookie":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementCookies.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ConsentManagementCookies.self, field: fieldName, value: fieldValue)
			}
		}

		/// The domain that the cookies will be set for. 
		open var cookieDomain: String {
			return internalGetCookieDomain()
		}

		func internalGetCookieDomain(alias: String? = nil) -> String {
			return field(field: "cookieDomain", aliasSuffix: alias) as! String
		}

		/// If needed, the _landing_page cookie to set. 
		open var landingPageCookie: String? {
			return internalGetLandingPageCookie()
		}

		func internalGetLandingPageCookie(alias: String? = nil) -> String? {
			return field(field: "landingPageCookie", aliasSuffix: alias) as! String?
		}

		/// If needed, the _orig_referrer cookie to set. 
		open var origReferrerCookie: String? {
			return internalGetOrigReferrerCookie()
		}

		func internalGetOrigReferrerCookie(alias: String? = nil) -> String? {
			return field(field: "origReferrerCookie", aliasSuffix: alias) as! String?
		}

		/// The _tracking_consent cookie, already URI encoded and serialized. 
		open var trackingConsentCookie: String {
			return internalGetTrackingConsentCookie()
		}

		func internalGetTrackingConsentCookie(alias: String? = nil) -> String {
			return field(field: "trackingConsentCookie", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

//
//  ConsentManagementBanner.swift
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
	/// A shop's privacy banner settings. 
	open class ConsentManagementBannerQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ConsentManagementBanner

		/// Text for the accept button. 
		@discardableResult
		open func buttonAcceptText(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "buttonAcceptText", aliasSuffix: alias)
			return self
		}

		/// Text for the decline button. 
		@discardableResult
		open func buttonDeclineText(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "buttonDeclineText", aliasSuffix: alias)
			return self
		}

		/// Text for the preference button. 
		@discardableResult
		open func buttonPrefsOpenText(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "buttonPrefsOpenText", aliasSuffix: alias)
			return self
		}

		/// Indicates if the banner is visible. 
		@discardableResult
		open func enabled(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "enabled", aliasSuffix: alias)
			return self
		}

		/// Deprecated field. Whether the merchant changed or not any banner field from 
		/// its default value. 
		@discardableResult
		open func isDefault(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "isDefault", aliasSuffix: alias)
			return self
		}

		/// Text for the policy link. 
		@discardableResult
		open func policyLinkText(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "policyLinkText", aliasSuffix: alias)
			return self
		}

		/// URL for the policy link. 
		@discardableResult
		open func policyLinkUrl(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "policyLinkUrl", aliasSuffix: alias)
			return self
		}

		/// Position of the banner. 
		@discardableResult
		open func position(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "position", aliasSuffix: alias)
			return self
		}

		/// Fields for the banner preferences popup. 
		@discardableResult
		open func preferences(alias: String? = nil, _ subfields: (ConsentManagementBannerPreferencesQuery) -> Void) -> ConsentManagementBannerQuery {
			let subquery = ConsentManagementBannerPreferencesQuery()
			subfields(subquery)

			addField(field: "preferences", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// List of ISO3166 2-character country codes where the banner should be 
		/// visible. 
		@discardableResult
		open func regionVisibility(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "regionVisibility", aliasSuffix: alias)
			return self
		}

		/// Body text on the banner. 
		@discardableResult
		open func text(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "text", aliasSuffix: alias)
			return self
		}

		/// Theme related fields of the banner. 
		@discardableResult
		open func theme(alias: String? = nil, _ subfields: (ConsentManagementBannerThemeQuery) -> Void) -> ConsentManagementBannerQuery {
			let subquery = ConsentManagementBannerThemeQuery()
			subfields(subquery)

			addField(field: "theme", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Title of the banner. 
		@discardableResult
		open func title(alias: String? = nil) -> ConsentManagementBannerQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}
	}

	/// A shop's privacy banner settings. 
	open class ConsentManagementBanner: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ConsentManagementBannerQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "buttonAcceptText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "buttonDeclineText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "buttonPrefsOpenText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "enabled":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "isDefault":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "policyLinkText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "policyLinkUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "position":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return ConsentManagementBannerPosition(rawValue: value) ?? .unknownValue

				case "preferences":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return try ConsentManagementBannerPreferences(fields: value)

				case "regionVisibility":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "text":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				case "theme":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return try ConsentManagementBannerTheme(fields: value)

				case "title":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ConsentManagementBanner.self, field: fieldName, value: fieldValue)
			}
		}

		/// Text for the accept button. 
		open var buttonAcceptText: String {
			return internalGetButtonAcceptText()
		}

		func internalGetButtonAcceptText(alias: String? = nil) -> String {
			return field(field: "buttonAcceptText", aliasSuffix: alias) as! String
		}

		/// Text for the decline button. 
		open var buttonDeclineText: String {
			return internalGetButtonDeclineText()
		}

		func internalGetButtonDeclineText(alias: String? = nil) -> String {
			return field(field: "buttonDeclineText", aliasSuffix: alias) as! String
		}

		/// Text for the preference button. 
		open var buttonPrefsOpenText: String {
			return internalGetButtonPrefsOpenText()
		}

		func internalGetButtonPrefsOpenText(alias: String? = nil) -> String {
			return field(field: "buttonPrefsOpenText", aliasSuffix: alias) as! String
		}

		/// Indicates if the banner is visible. 
		open var enabled: Bool {
			return internalGetEnabled()
		}

		func internalGetEnabled(alias: String? = nil) -> Bool {
			return field(field: "enabled", aliasSuffix: alias) as! Bool
		}

		/// Deprecated field. Whether the merchant changed or not any banner field from 
		/// its default value. 
		open var isDefault: Bool {
			return internalGetIsDefault()
		}

		func internalGetIsDefault(alias: String? = nil) -> Bool {
			return field(field: "isDefault", aliasSuffix: alias) as! Bool
		}

		/// Text for the policy link. 
		open var policyLinkText: String {
			return internalGetPolicyLinkText()
		}

		func internalGetPolicyLinkText(alias: String? = nil) -> String {
			return field(field: "policyLinkText", aliasSuffix: alias) as! String
		}

		/// URL for the policy link. 
		open var policyLinkUrl: String {
			return internalGetPolicyLinkUrl()
		}

		func internalGetPolicyLinkUrl(alias: String? = nil) -> String {
			return field(field: "policyLinkUrl", aliasSuffix: alias) as! String
		}

		/// Position of the banner. 
		open var position: Storefront.ConsentManagementBannerPosition {
			return internalGetPosition()
		}

		func internalGetPosition(alias: String? = nil) -> Storefront.ConsentManagementBannerPosition {
			return field(field: "position", aliasSuffix: alias) as! Storefront.ConsentManagementBannerPosition
		}

		/// Fields for the banner preferences popup. 
		open var preferences: Storefront.ConsentManagementBannerPreferences {
			return internalGetPreferences()
		}

		func internalGetPreferences(alias: String? = nil) -> Storefront.ConsentManagementBannerPreferences {
			return field(field: "preferences", aliasSuffix: alias) as! Storefront.ConsentManagementBannerPreferences
		}

		/// List of ISO3166 2-character country codes where the banner should be 
		/// visible. 
		open var regionVisibility: [String] {
			return internalGetRegionVisibility()
		}

		func internalGetRegionVisibility(alias: String? = nil) -> [String] {
			return field(field: "regionVisibility", aliasSuffix: alias) as! [String]
		}

		/// Body text on the banner. 
		open var text: String {
			return internalGetText()
		}

		func internalGetText(alias: String? = nil) -> String {
			return field(field: "text", aliasSuffix: alias) as! String
		}

		/// Theme related fields of the banner. 
		open var theme: Storefront.ConsentManagementBannerTheme {
			return internalGetTheme()
		}

		func internalGetTheme(alias: String? = nil) -> Storefront.ConsentManagementBannerTheme {
			return field(field: "theme", aliasSuffix: alias) as! Storefront.ConsentManagementBannerTheme
		}

		/// Title of the banner. 
		open var title: String? {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String? {
			return field(field: "title", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "preferences":
					response.append(internalGetPreferences())
					response.append(contentsOf: internalGetPreferences().childResponseObjectMap())

					case "theme":
					response.append(internalGetTheme())
					response.append(contentsOf: internalGetTheme().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

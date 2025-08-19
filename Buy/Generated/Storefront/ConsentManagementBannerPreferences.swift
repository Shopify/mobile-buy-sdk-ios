//
//  ConsentManagementBannerPreferences.swift
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
	/// Settings related to the banner preferences. 
	open class ConsentManagementBannerPreferencesQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ConsentManagementBannerPreferences

		/// Data related to the bullet points of consent. 
		@discardableResult
		open func bulletPoints(alias: String? = nil, _ subfields: (ConsentManagementBannerBulletPointsQuery) -> Void) -> ConsentManagementBannerPreferencesQuery {
			let subquery = ConsentManagementBannerBulletPointsQuery()
			subfields(subquery)

			addField(field: "bulletPoints", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Accept button text. 
		@discardableResult
		open func buttonAcceptText(alias: String? = nil) -> ConsentManagementBannerPreferencesQuery {
			addField(field: "buttonAcceptText", aliasSuffix: alias)
			return self
		}

		/// Decline button text. 
		@discardableResult
		open func buttonDeclineText(alias: String? = nil) -> ConsentManagementBannerPreferencesQuery {
			addField(field: "buttonDeclineText", aliasSuffix: alias)
			return self
		}

		/// Save button text. 
		@discardableResult
		open func buttonSaveText(alias: String? = nil) -> ConsentManagementBannerPreferencesQuery {
			addField(field: "buttonSaveText", aliasSuffix: alias)
			return self
		}

		/// Introduction text. 
		@discardableResult
		open func introText(alias: String? = nil) -> ConsentManagementBannerPreferencesQuery {
			addField(field: "introText", aliasSuffix: alias)
			return self
		}

		/// Introduction title. 
		@discardableResult
		open func introTitle(alias: String? = nil) -> ConsentManagementBannerPreferencesQuery {
			addField(field: "introTitle", aliasSuffix: alias)
			return self
		}

		/// Purpose descriptions. 
		@discardableResult
		open func purposes(alias: String? = nil, _ subfields: (ConsentManagementBannerPurposesQuery) -> Void) -> ConsentManagementBannerPreferencesQuery {
			let subquery = ConsentManagementBannerPurposesQuery()
			subfields(subquery)

			addField(field: "purposes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Title for the banner preferences. 
		@discardableResult
		open func title(alias: String? = nil) -> ConsentManagementBannerPreferencesQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}
	}

	/// Settings related to the banner preferences. 
	open class ConsentManagementBannerPreferences: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ConsentManagementBannerPreferencesQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "bulletPoints":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return try ConsentManagementBannerBulletPoints(fields: value)

				case "buttonAcceptText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return value

				case "buttonDeclineText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return value

				case "buttonSaveText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return value

				case "introText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return value

				case "introTitle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return value

				case "purposes":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return try ConsentManagementBannerPurposes(fields: value)

				case "title":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ConsentManagementBannerPreferences.self, field: fieldName, value: fieldValue)
			}
		}

		/// Data related to the bullet points of consent. 
		open var bulletPoints: Storefront.ConsentManagementBannerBulletPoints? {
			return internalGetBulletPoints()
		}

		func internalGetBulletPoints(alias: String? = nil) -> Storefront.ConsentManagementBannerBulletPoints? {
			return field(field: "bulletPoints", aliasSuffix: alias) as! Storefront.ConsentManagementBannerBulletPoints?
		}

		/// Accept button text. 
		open var buttonAcceptText: String {
			return internalGetButtonAcceptText()
		}

		func internalGetButtonAcceptText(alias: String? = nil) -> String {
			return field(field: "buttonAcceptText", aliasSuffix: alias) as! String
		}

		/// Decline button text. 
		open var buttonDeclineText: String {
			return internalGetButtonDeclineText()
		}

		func internalGetButtonDeclineText(alias: String? = nil) -> String {
			return field(field: "buttonDeclineText", aliasSuffix: alias) as! String
		}

		/// Save button text. 
		open var buttonSaveText: String {
			return internalGetButtonSaveText()
		}

		func internalGetButtonSaveText(alias: String? = nil) -> String {
			return field(field: "buttonSaveText", aliasSuffix: alias) as! String
		}

		/// Introduction text. 
		open var introText: String {
			return internalGetIntroText()
		}

		func internalGetIntroText(alias: String? = nil) -> String {
			return field(field: "introText", aliasSuffix: alias) as! String
		}

		/// Introduction title. 
		open var introTitle: String {
			return internalGetIntroTitle()
		}

		func internalGetIntroTitle(alias: String? = nil) -> String {
			return field(field: "introTitle", aliasSuffix: alias) as! String
		}

		/// Purpose descriptions. 
		open var purposes: Storefront.ConsentManagementBannerPurposes {
			return internalGetPurposes()
		}

		func internalGetPurposes(alias: String? = nil) -> Storefront.ConsentManagementBannerPurposes {
			return field(field: "purposes", aliasSuffix: alias) as! Storefront.ConsentManagementBannerPurposes
		}

		/// Title for the banner preferences. 
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
					case "bulletPoints":
					if let value = internalGetBulletPoints() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "purposes":
					response.append(internalGetPurposes())
					response.append(contentsOf: internalGetPurposes().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

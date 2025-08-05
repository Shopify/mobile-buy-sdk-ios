//
//  ConsentManagementBannerTheme.swift
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
	/// Represents the theme settings for the privacy banner. 
	open class ConsentManagementBannerThemeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ConsentManagementBannerTheme

		/// Background color. 
		@discardableResult
		open func backgroundColor(alias: String? = nil) -> ConsentManagementBannerThemeQuery {
			addField(field: "backgroundColor", aliasSuffix: alias)
			return self
		}

		/// Button background color. 
		@discardableResult
		open func buttonBackgroundColor(alias: String? = nil) -> ConsentManagementBannerThemeQuery {
			addField(field: "buttonBackgroundColor", aliasSuffix: alias)
			return self
		}

		/// Button font color. 
		@discardableResult
		open func buttonFontColor(alias: String? = nil) -> ConsentManagementBannerThemeQuery {
			addField(field: "buttonFontColor", aliasSuffix: alias)
			return self
		}

		/// Font color. 
		@discardableResult
		open func fontColor(alias: String? = nil) -> ConsentManagementBannerThemeQuery {
			addField(field: "fontColor", aliasSuffix: alias)
			return self
		}

		/// The chosen theme. 
		@discardableResult
		open func theme(alias: String? = nil) -> ConsentManagementBannerThemeQuery {
			addField(field: "theme", aliasSuffix: alias)
			return self
		}
	}

	/// Represents the theme settings for the privacy banner. 
	open class ConsentManagementBannerTheme: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ConsentManagementBannerThemeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "backgroundColor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerTheme.self, field: fieldName, value: fieldValue)
				}
				return value

				case "buttonBackgroundColor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerTheme.self, field: fieldName, value: fieldValue)
				}
				return value

				case "buttonFontColor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerTheme.self, field: fieldName, value: fieldValue)
				}
				return value

				case "fontColor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerTheme.self, field: fieldName, value: fieldValue)
				}
				return value

				case "theme":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerTheme.self, field: fieldName, value: fieldValue)
				}
				return ConsentManagementBannerThemeEnum(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: ConsentManagementBannerTheme.self, field: fieldName, value: fieldValue)
			}
		}

		/// Background color. 
		open var backgroundColor: String {
			return internalGetBackgroundColor()
		}

		func internalGetBackgroundColor(alias: String? = nil) -> String {
			return field(field: "backgroundColor", aliasSuffix: alias) as! String
		}

		/// Button background color. 
		open var buttonBackgroundColor: String {
			return internalGetButtonBackgroundColor()
		}

		func internalGetButtonBackgroundColor(alias: String? = nil) -> String {
			return field(field: "buttonBackgroundColor", aliasSuffix: alias) as! String
		}

		/// Button font color. 
		open var buttonFontColor: String {
			return internalGetButtonFontColor()
		}

		func internalGetButtonFontColor(alias: String? = nil) -> String {
			return field(field: "buttonFontColor", aliasSuffix: alias) as! String
		}

		/// Font color. 
		open var fontColor: String {
			return internalGetFontColor()
		}

		func internalGetFontColor(alias: String? = nil) -> String {
			return field(field: "fontColor", aliasSuffix: alias) as! String
		}

		/// The chosen theme. 
		open var theme: Storefront.ConsentManagementBannerThemeEnum {
			return internalGetTheme()
		}

		func internalGetTheme(alias: String? = nil) -> Storefront.ConsentManagementBannerThemeEnum {
			return field(field: "theme", aliasSuffix: alias) as! Storefront.ConsentManagementBannerThemeEnum
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

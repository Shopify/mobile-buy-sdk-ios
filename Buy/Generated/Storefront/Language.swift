//
//  Language.swift
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
	/// A language. 
	open class LanguageQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Language

		/// The name of the language in the language itself. If the language uses 
		/// capitalization, it is capitalized for a mid-sentence position. 
		@discardableResult
		open func endonymName(alias: String? = nil) -> LanguageQuery {
			addField(field: "endonymName", aliasSuffix: alias)
			return self
		}

		/// The ISO code. 
		@discardableResult
		open func isoCode(alias: String? = nil) -> LanguageQuery {
			addField(field: "isoCode", aliasSuffix: alias)
			return self
		}

		/// The name of the language in the current language. 
		@discardableResult
		open func name(alias: String? = nil) -> LanguageQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}
	}

	/// A language. 
	open class Language: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = LanguageQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "endonymName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Language.self, field: fieldName, value: fieldValue)
				}
				return value

				case "isoCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Language.self, field: fieldName, value: fieldValue)
				}
				return LanguageCode(rawValue: value) ?? .unknownValue

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Language.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Language.self, field: fieldName, value: fieldValue)
			}
		}

		/// The name of the language in the language itself. If the language uses 
		/// capitalization, it is capitalized for a mid-sentence position. 
		open var endonymName: String {
			return internalGetEndonymName()
		}

		func internalGetEndonymName(alias: String? = nil) -> String {
			return field(field: "endonymName", aliasSuffix: alias) as! String
		}

		/// The ISO code. 
		open var isoCode: Storefront.LanguageCode {
			return internalGetIsoCode()
		}

		func internalGetIsoCode(alias: String? = nil) -> Storefront.LanguageCode {
			return field(field: "isoCode", aliasSuffix: alias) as! Storefront.LanguageCode
		}

		/// The name of the language in the current language. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

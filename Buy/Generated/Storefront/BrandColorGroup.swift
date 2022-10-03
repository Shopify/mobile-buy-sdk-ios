//
//  BrandColorGroup.swift
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
	/// A group of related colors for the shop's brand. 
	open class BrandColorGroupQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = BrandColorGroup

		/// The background color. 
		@discardableResult
		open func background(alias: String? = nil) -> BrandColorGroupQuery {
			addField(field: "background", aliasSuffix: alias)
			return self
		}

		/// The foreground color. 
		@discardableResult
		open func foreground(alias: String? = nil) -> BrandColorGroupQuery {
			addField(field: "foreground", aliasSuffix: alias)
			return self
		}
	}

	/// A group of related colors for the shop's brand. 
	open class BrandColorGroup: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = BrandColorGroupQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "background":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: BrandColorGroup.self, field: fieldName, value: fieldValue)
				}
				return value

				case "foreground":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: BrandColorGroup.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: BrandColorGroup.self, field: fieldName, value: fieldValue)
			}
		}

		/// The background color. 
		open var background: String? {
			return internalGetBackground()
		}

		func internalGetBackground(alias: String? = nil) -> String? {
			return field(field: "background", aliasSuffix: alias) as! String?
		}

		/// The foreground color. 
		open var foreground: String? {
			return internalGetForeground()
		}

		func internalGetForeground(alias: String? = nil) -> String? {
			return field(field: "foreground", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

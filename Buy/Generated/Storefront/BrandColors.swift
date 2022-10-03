//
//  BrandColors.swift
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
	/// The colors of the shop's brand. 
	open class BrandColorsQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = BrandColors

		/// The shop's primary brand colors. 
		@discardableResult
		open func primary(alias: String? = nil, _ subfields: (BrandColorGroupQuery) -> Void) -> BrandColorsQuery {
			let subquery = BrandColorGroupQuery()
			subfields(subquery)

			addField(field: "primary", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop's secondary brand colors. 
		@discardableResult
		open func secondary(alias: String? = nil, _ subfields: (BrandColorGroupQuery) -> Void) -> BrandColorsQuery {
			let subquery = BrandColorGroupQuery()
			subfields(subquery)

			addField(field: "secondary", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The colors of the shop's brand. 
	open class BrandColors: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = BrandColorsQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "primary":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: BrandColors.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try BrandColorGroup(fields: $0) }

				case "secondary":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: BrandColors.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try BrandColorGroup(fields: $0) }

				default:
				throw SchemaViolationError(type: BrandColors.self, field: fieldName, value: fieldValue)
			}
		}

		/// The shop's primary brand colors. 
		open var primary: [Storefront.BrandColorGroup] {
			return internalGetPrimary()
		}

		func internalGetPrimary(alias: String? = nil) -> [Storefront.BrandColorGroup] {
			return field(field: "primary", aliasSuffix: alias) as! [Storefront.BrandColorGroup]
		}

		/// The shop's secondary brand colors. 
		open var secondary: [Storefront.BrandColorGroup] {
			return internalGetSecondary()
		}

		func internalGetSecondary(alias: String? = nil) -> [Storefront.BrandColorGroup] {
			return field(field: "secondary", aliasSuffix: alias) as! [Storefront.BrandColorGroup]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

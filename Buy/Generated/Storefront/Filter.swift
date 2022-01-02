//
//  Filter.swift
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
	/// A filter that is supported on the parent field. 
	open class FilterQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Filter

		/// A unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> FilterQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// A human-friendly string for this filter. 
		@discardableResult
		open func label(alias: String? = nil) -> FilterQuery {
			addField(field: "label", aliasSuffix: alias)
			return self
		}

		/// An enumeration that denotes the type of data this filter represents. 
		@discardableResult
		open func type(alias: String? = nil) -> FilterQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The list of values for this filter. 
		@discardableResult
		open func values(alias: String? = nil, _ subfields: (FilterValueQuery) -> Void) -> FilterQuery {
			let subquery = FilterValueQuery()
			subfields(subquery)

			addField(field: "values", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// A filter that is supported on the parent field. 
	open class Filter: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = FilterQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Filter.self, field: fieldName, value: fieldValue)
				}
				return value

				case "label":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Filter.self, field: fieldName, value: fieldValue)
				}
				return value

				case "type":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Filter.self, field: fieldName, value: fieldValue)
				}
				return FilterType(rawValue: value) ?? .unknownValue

				case "values":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Filter.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try FilterValue(fields: $0) }

				default:
				throw SchemaViolationError(type: Filter.self, field: fieldName, value: fieldValue)
			}
		}

		/// A unique identifier. 
		open var id: String {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> String {
			return field(field: "id", aliasSuffix: alias) as! String
		}

		/// A human-friendly string for this filter. 
		open var label: String {
			return internalGetLabel()
		}

		func internalGetLabel(alias: String? = nil) -> String {
			return field(field: "label", aliasSuffix: alias) as! String
		}

		/// An enumeration that denotes the type of data this filter represents. 
		open var type: Storefront.FilterType {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> Storefront.FilterType {
			return field(field: "type", aliasSuffix: alias) as! Storefront.FilterType
		}

		/// The list of values for this filter. 
		open var values: [Storefront.FilterValue] {
			return internalGetValues()
		}

		func internalGetValues(alias: String? = nil) -> [Storefront.FilterValue] {
			return field(field: "values", aliasSuffix: alias) as! [Storefront.FilterValue]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

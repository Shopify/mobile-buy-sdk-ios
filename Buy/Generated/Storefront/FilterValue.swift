//
//  FilterValue.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// A selectable value within a filter. 
	open class FilterValueQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = FilterValue

		/// The number of results that match this filter value. 
		@discardableResult
		open func count(alias: String? = nil) -> FilterValueQuery {
			addField(field: "count", aliasSuffix: alias)
			return self
		}

		/// A unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> FilterValueQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The visual representation when the filter's presentation is `IMAGE`. 
		@discardableResult
		open func image(alias: String? = nil, _ subfields: (MediaImageQuery) -> Void) -> FilterValueQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// An input object that can be used to filter by this value on the parent 
		/// field. The value is provided as a helper for building dynamic filtering UI. 
		/// For example, if you have a list of selected `FilterValue` objects, you can 
		/// combine their respective `input` values to use in a subsequent query. 
		@discardableResult
		open func input(alias: String? = nil) -> FilterValueQuery {
			addField(field: "input", aliasSuffix: alias)
			return self
		}

		/// A human-friendly string for this filter value. 
		@discardableResult
		open func label(alias: String? = nil) -> FilterValueQuery {
			addField(field: "label", aliasSuffix: alias)
			return self
		}

		/// The visual representation when the filter's presentation is `SWATCH`. 
		@discardableResult
		open func swatch(alias: String? = nil, _ subfields: (SwatchQuery) -> Void) -> FilterValueQuery {
			let subquery = SwatchQuery()
			subfields(subquery)

			addField(field: "swatch", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// A selectable value within a filter. 
	open class FilterValue: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = FilterValueQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "count":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: FilterValue.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: FilterValue.self, field: fieldName, value: fieldValue)
				}
				return value

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: FilterValue.self, field: fieldName, value: fieldValue)
				}
				return try MediaImage(fields: value)

				case "input":
				guard let value = value as? String else {
					throw SchemaViolationError(type: FilterValue.self, field: fieldName, value: fieldValue)
				}
				return value

				case "label":
				guard let value = value as? String else {
					throw SchemaViolationError(type: FilterValue.self, field: fieldName, value: fieldValue)
				}
				return value

				case "swatch":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: FilterValue.self, field: fieldName, value: fieldValue)
				}
				return try Swatch(fields: value)

				default:
				throw SchemaViolationError(type: FilterValue.self, field: fieldName, value: fieldValue)
			}
		}

		/// The number of results that match this filter value. 
		open var count: Int32 {
			return internalGetCount()
		}

		func internalGetCount(alias: String? = nil) -> Int32 {
			return field(field: "count", aliasSuffix: alias) as! Int32
		}

		/// A unique identifier. 
		open var id: String {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> String {
			return field(field: "id", aliasSuffix: alias) as! String
		}

		/// The visual representation when the filter's presentation is `IMAGE`. 
		open var image: Storefront.MediaImage? {
			return internalGetImage()
		}

		func internalGetImage(alias: String? = nil) -> Storefront.MediaImage? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.MediaImage?
		}

		/// An input object that can be used to filter by this value on the parent 
		/// field. The value is provided as a helper for building dynamic filtering UI. 
		/// For example, if you have a list of selected `FilterValue` objects, you can 
		/// combine their respective `input` values to use in a subsequent query. 
		open var input: String {
			return internalGetInput()
		}

		func internalGetInput(alias: String? = nil) -> String {
			return field(field: "input", aliasSuffix: alias) as! String
		}

		/// A human-friendly string for this filter value. 
		open var label: String {
			return internalGetLabel()
		}

		func internalGetLabel(alias: String? = nil) -> String {
			return field(field: "label", aliasSuffix: alias) as! String
		}

		/// The visual representation when the filter's presentation is `SWATCH`. 
		open var swatch: Storefront.Swatch? {
			return internalGetSwatch()
		}

		func internalGetSwatch(alias: String? = nil) -> Storefront.Swatch? {
			return field(field: "swatch", aliasSuffix: alias) as! Storefront.Swatch?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "swatch":
					if let value = internalGetSwatch() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

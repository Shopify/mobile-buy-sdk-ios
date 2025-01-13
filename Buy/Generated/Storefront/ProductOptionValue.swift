//
//  ProductOptionValue.swift
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
	/// The product option value names. For example, "Red", "Blue", and "Green" for 
	/// a "Color" option. 
	open class ProductOptionValueQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ProductOptionValue

		/// The product variant that combines this option value with the 
		/// lowest-position option values for all other options. This field will always 
		/// return a variant, provided a variant including this option value exists. 
		@discardableResult
		open func firstSelectableVariant(alias: String? = nil, _ subfields: (ProductVariantQuery) -> Void) -> ProductOptionValueQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "firstSelectableVariant", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ProductOptionValueQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The name of the product option value. 
		@discardableResult
		open func name(alias: String? = nil) -> ProductOptionValueQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// The swatch of the product option value. 
		@discardableResult
		open func swatch(alias: String? = nil, _ subfields: (ProductOptionValueSwatchQuery) -> Void) -> ProductOptionValueQuery {
			let subquery = ProductOptionValueSwatchQuery()
			subfields(subquery)

			addField(field: "swatch", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The product option value names. For example, "Red", "Blue", and "Green" for 
	/// a "Color" option. 
	open class ProductOptionValue: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = ProductOptionValueQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "firstSelectableVariant":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductOptionValue.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariant(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductOptionValue.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductOptionValue.self, field: fieldName, value: fieldValue)
				}
				return value

				case "swatch":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductOptionValue.self, field: fieldName, value: fieldValue)
				}
				return try ProductOptionValueSwatch(fields: value)

				default:
				throw SchemaViolationError(type: ProductOptionValue.self, field: fieldName, value: fieldValue)
			}
		}

		/// The product variant that combines this option value with the 
		/// lowest-position option values for all other options. This field will always 
		/// return a variant, provided a variant including this option value exists. 
		open var firstSelectableVariant: Storefront.ProductVariant? {
			return internalGetFirstSelectableVariant()
		}

		func internalGetFirstSelectableVariant(alias: String? = nil) -> Storefront.ProductVariant? {
			return field(field: "firstSelectableVariant", aliasSuffix: alias) as! Storefront.ProductVariant?
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The name of the product option value. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// The swatch of the product option value. 
		open var swatch: Storefront.ProductOptionValueSwatch? {
			return internalGetSwatch()
		}

		func internalGetSwatch(alias: String? = nil) -> Storefront.ProductOptionValueSwatch? {
			return field(field: "swatch", aliasSuffix: alias) as! Storefront.ProductOptionValueSwatch?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "firstSelectableVariant":
					if let value = internalGetFirstSelectableVariant() {
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

//
//  ProductVariantComponent.swift
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
	/// Represents a component of a bundle variant. 
	open class ProductVariantComponentQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ProductVariantComponent

		/// The product variant object that the component belongs to. 
		@discardableResult
		open func productVariant(alias: String? = nil, _ subfields: (ProductVariantQuery) -> Void) -> ProductVariantComponentQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "productVariant", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The quantity of component present in the bundle. 
		@discardableResult
		open func quantity(alias: String? = nil) -> ProductVariantComponentQuery {
			addField(field: "quantity", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a component of a bundle variant. 
	open class ProductVariantComponent: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ProductVariantComponentQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "productVariant":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariantComponent.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariant(fields: value)

				case "quantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: ProductVariantComponent.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: ProductVariantComponent.self, field: fieldName, value: fieldValue)
			}
		}

		/// The product variant object that the component belongs to. 
		open var productVariant: Storefront.ProductVariant {
			return internalGetProductVariant()
		}

		func internalGetProductVariant(alias: String? = nil) -> Storefront.ProductVariant {
			return field(field: "productVariant", aliasSuffix: alias) as! Storefront.ProductVariant
		}

		/// The quantity of component present in the bundle. 
		open var quantity: Int32 {
			return internalGetQuantity()
		}

		func internalGetQuantity(alias: String? = nil) -> Int32 {
			return field(field: "quantity", aliasSuffix: alias) as! Int32
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "productVariant":
					response.append(internalGetProductVariant())
					response.append(contentsOf: internalGetProductVariant().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

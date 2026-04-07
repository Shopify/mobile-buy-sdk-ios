//
//  TaxonomyCategory.swift
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
	/// A category from Shopify's [Standard Product
	/// Taxonomy](https://shopify.github.io/product-taxonomy/releases/unstable/?categoryId=sg-4-17-2-17)
	/// assigned to a
	/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product).
	/// Categories provide hierarchical classification through the `ancestors`
	/// field. The
	/// [`ancestors`](https://shopify.dev/docs/api/storefront/current/objects/TaxonomyCategory#field-TaxonomyCategory.fields.ancestors)
	/// field returns the parent chain from the immediate parent up to the root.
	/// Each ancestor category also includes its own `ancestors`. The
	/// [`name`](https://shopify.dev/docs/api/storefront/latest/objects/TaxonomyCategory#field-TaxonomyCategory.fields.name)
	/// field returns the localized category name based on the storefront's request
	/// language with shop locale fallbacks. If a translation isn't available for
	/// the resolved locale, the English taxonomy name is returned.
	open class TaxonomyCategoryQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = TaxonomyCategory

		/// All parent nodes of the current taxonomy category.
		@discardableResult
		open func ancestors(alias: String? = nil, _ subfields: (TaxonomyCategoryQuery) -> Void) -> TaxonomyCategoryQuery {
			let subquery = TaxonomyCategoryQuery()
			subfields(subquery)

			addField(field: "ancestors", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A static identifier for the taxonomy category.
		@discardableResult
		open func id(alias: String? = nil) -> TaxonomyCategoryQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The localized name of the taxonomy category.
		@discardableResult
		open func name(alias: String? = nil) -> TaxonomyCategoryQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}
	}

	/// A category from Shopify's [Standard Product
	/// Taxonomy](https://shopify.github.io/product-taxonomy/releases/unstable/?categoryId=sg-4-17-2-17)
	/// assigned to a
	/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product).
	/// Categories provide hierarchical classification through the `ancestors`
	/// field. The
	/// [`ancestors`](https://shopify.dev/docs/api/storefront/current/objects/TaxonomyCategory#field-TaxonomyCategory.fields.ancestors)
	/// field returns the parent chain from the immediate parent up to the root.
	/// Each ancestor category also includes its own `ancestors`. The
	/// [`name`](https://shopify.dev/docs/api/storefront/latest/objects/TaxonomyCategory#field-TaxonomyCategory.fields.name)
	/// field returns the localized category name based on the storefront's request
	/// language with shop locale fallbacks. If a translation isn't available for
	/// the resolved locale, the English taxonomy name is returned.
	open class TaxonomyCategory: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = TaxonomyCategoryQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "ancestors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: TaxonomyCategory.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try TaxonomyCategory(fields: $0) }

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: TaxonomyCategory.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: TaxonomyCategory.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: TaxonomyCategory.self, field: fieldName, value: fieldValue)
			}
		}

		/// All parent nodes of the current taxonomy category.
		open var ancestors: [Storefront.TaxonomyCategory] {
			return internalGetAncestors()
		}

		func internalGetAncestors(alias: String? = nil) -> [Storefront.TaxonomyCategory] {
			return field(field: "ancestors", aliasSuffix: alias) as! [Storefront.TaxonomyCategory]
		}

		/// A static identifier for the taxonomy category.
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The localized name of the taxonomy category.
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

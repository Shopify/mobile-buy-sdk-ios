//
//  MetafieldParentResource.swift
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

/// A resource that the metafield belongs to. 
public protocol MetafieldParentResource {
}

extension Storefront {
	/// A resource that the metafield belongs to. 
	open class MetafieldParentResourceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MetafieldParentResource

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onArticle(subfields: (ArticleQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = ArticleQuery()
			subfields(subquery)
			addInlineFragment(on: "Article", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onBlog(subfields: (BlogQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = BlogQuery()
			subfields(subquery)
			addInlineFragment(on: "Blog", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onCustomer(subfields: (CustomerQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = CustomerQuery()
			subfields(subquery)
			addInlineFragment(on: "Customer", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onOrder(subfields: (OrderQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = OrderQuery()
			subfields(subquery)
			addInlineFragment(on: "Order", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onPage(subfields: (PageQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = PageQuery()
			subfields(subquery)
			addInlineFragment(on: "Page", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onProductVariant(subfields: (ProductVariantQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductVariant", subfields: subquery)
			return self
		}

		/// A resource that the metafield belongs to. 
		@discardableResult
		open func onShop(subfields: (ShopQuery) -> Void) -> MetafieldParentResourceQuery {
			let subquery = ShopQuery()
			subfields(subquery)
			addInlineFragment(on: "Shop", subfields: subquery)
			return self
		}
	}

	/// A resource that the metafield belongs to. 
	open class UnknownMetafieldParentResource: GraphQL.AbstractResponse, GraphQLObject, MetafieldParentResource {
		public typealias Query = MetafieldParentResourceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownMetafieldParentResource.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> MetafieldParentResource {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownMetafieldParentResource.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Article": return try Article.init(fields: fields)

				case "Blog": return try Blog.init(fields: fields)

				case "Collection": return try Collection.init(fields: fields)

				case "Customer": return try Customer.init(fields: fields)

				case "Order": return try Order.init(fields: fields)

				case "Page": return try Page.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				case "ProductVariant": return try ProductVariant.init(fields: fields)

				case "Shop": return try Shop.init(fields: fields)

				default:
				return try UnknownMetafieldParentResource.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

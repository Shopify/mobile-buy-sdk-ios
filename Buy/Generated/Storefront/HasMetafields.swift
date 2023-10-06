//
//  HasMetafields.swift
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

/// Represents information about the metafields associated to the specified 
/// resource. 
public protocol HasMetafields {
	var metafield: Storefront.Metafield? { get }

	var metafields: [Storefront.Metafield?] { get }
}

extension Storefront {
	/// Represents information about the metafields associated to the specified 
	/// resource. 
	open class HasMetafieldsQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = HasMetafields

		/// Returns a metafield found by namespace and key. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> HasMetafieldsQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> HasMetafieldsQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onArticle(subfields: (ArticleQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = ArticleQuery()
			subfields(subquery)
			addInlineFragment(on: "Article", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onBlog(subfields: (BlogQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = BlogQuery()
			subfields(subquery)
			addInlineFragment(on: "Blog", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onCart(subfields: (CartQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = CartQuery()
			subfields(subquery)
			addInlineFragment(on: "Cart", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onCustomer(subfields: (CustomerQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = CustomerQuery()
			subfields(subquery)
			addInlineFragment(on: "Customer", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onLocation(subfields: (LocationQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = LocationQuery()
			subfields(subquery)
			addInlineFragment(on: "Location", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onMarket(subfields: (MarketQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = MarketQuery()
			subfields(subquery)
			addInlineFragment(on: "Market", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onOrder(subfields: (OrderQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = OrderQuery()
			subfields(subquery)
			addInlineFragment(on: "Order", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onPage(subfields: (PageQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = PageQuery()
			subfields(subquery)
			addInlineFragment(on: "Page", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onProductVariant(subfields: (ProductVariantQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductVariant", subfields: subquery)
			return self
		}

		/// Represents information about the metafields associated to the specified 
		/// resource. 
		@discardableResult
		open func onShop(subfields: (ShopQuery) -> Void) -> HasMetafieldsQuery {
			let subquery = ShopQuery()
			subfields(subquery)
			addInlineFragment(on: "Shop", subfields: subquery)
			return self
		}
	}

	/// Represents information about the metafields associated to the specified 
	/// resource. 
	open class UnknownHasMetafields: GraphQL.AbstractResponse, GraphQLObject, HasMetafields {
		public typealias Query = HasMetafieldsQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: UnknownHasMetafields.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: UnknownHasMetafields.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: UnknownHasMetafields.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				default:
				throw SchemaViolationError(type: UnknownHasMetafields.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> HasMetafields {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownHasMetafields.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Article": return try Article.init(fields: fields)

				case "Blog": return try Blog.init(fields: fields)

				case "Cart": return try Cart.init(fields: fields)

				case "Collection": return try Collection.init(fields: fields)

				case "Customer": return try Customer.init(fields: fields)

				case "Location": return try Location.init(fields: fields)

				case "Market": return try Market.init(fields: fields)

				case "Order": return try Order.init(fields: fields)

				case "Page": return try Page.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				case "ProductVariant": return try ProductVariant.init(fields: fields)

				case "Shop": return try Shop.init(fields: fields)

				default:
				return try UnknownHasMetafields.init(fields: fields)
			}
		}

		/// Returns a metafield found by namespace and key. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		open var metafields: [Storefront.Metafield?] {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> [Storefront.Metafield?] {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield?] {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield?]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					internalGetMetafields().forEach {
						if let value = $0 {
							response.append(value)
							response.append(contentsOf: value.childResponseObjectMap())
						}
					}

					default:
					break
				}
			}
			return response
		}
	}
}

//
//  Shop.swift
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
	/// Shop represents a collection of the general settings and information about 
	/// the shop. 
	open class ShopQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Shop

		/// List of the shop' articles. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Supported filter parameters:
		///         - `author`
		///         - `blog_title`
		///         - `created_at`
		///         - `tag`
		///         - `updated_at`
		///        
		///        See the detailed [search syntax](https://help.shopify.com/api/getting-started/search-syntax)
		///        for more information about using filters.
		///
		@available(*, deprecated, message:"Use `QueryRoot.articles` instead.")
		@discardableResult
		open func articles(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ArticleSortKeys? = nil, query: String? = nil, _ subfields: (ArticleConnectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ArticleConnectionQuery()
			subfields(subquery)

			addField(field: "articles", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of the shop' blogs. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Supported filter parameters:
		///         - `created_at`
		///         - `handle`
		///         - `title`
		///         - `updated_at`
		///        
		///        See the detailed [search syntax](https://help.shopify.com/api/getting-started/search-syntax)
		///        for more information about using filters.
		///
		@available(*, deprecated, message:"Use `QueryRoot.blogs` instead.")
		@discardableResult
		open func blogs(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: BlogSortKeys? = nil, query: String? = nil, _ subfields: (BlogConnectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = BlogConnectionQuery()
			subfields(subquery)

			addField(field: "blogs", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Find a collection by its handle. 
		///
		/// - parameters:
		///     - handle: The handle of the collection.
		///
		@available(*, deprecated, message:"Use `QueryRoot.collectionByHandle` instead.")
		@discardableResult
		open func collectionByHandle(alias: String? = nil, handle: String, _ subfields: (CollectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CollectionQuery()
			subfields(subquery)

			addField(field: "collectionByHandle", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of the shop’s collections. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Supported filter parameters:
		///         - `collection_type`
		///         - `title`
		///         - `updated_at`
		///        
		///        See the detailed [search syntax](https://help.shopify.com/api/getting-started/search-syntax)
		///        for more information about using filters.
		///
		@available(*, deprecated, message:"Use `QueryRoot.collections` instead.")
		@discardableResult
		open func collections(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: CollectionSortKeys? = nil, query: String? = nil, _ subfields: (CollectionConnectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CollectionConnectionQuery()
			subfields(subquery)

			addField(field: "collections", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The three-letter code for the currency that the shop accepts. 
		@available(*, deprecated, message:"Use `paymentSettings` instead")
		@discardableResult
		open func currencyCode(alias: String? = nil) -> ShopQuery {
			addField(field: "currencyCode", aliasSuffix: alias)
			return self
		}

		/// A description of the shop. 
		@discardableResult
		open func description(alias: String? = nil) -> ShopQuery {
			addField(field: "description", aliasSuffix: alias)
			return self
		}

		/// Returns a metafield found by namespace and key. 
		///
		/// - parameters:
		///     - namespace: Container for a set of metafields (maximum of 20 characters).
		///     - key: Identifier for the metafield (maximum of 30 characters).
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String, key: String, _ subfields: (MetafieldQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			args.append("namespace:\(GraphQL.quoteString(input: namespace))")

			args.append("key:\(GraphQL.quoteString(input: key))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A paginated list of metafields associated with the resource. 
		///
		/// - parameters:
		///     - namespace: Container for a set of metafields (maximum of 20 characters).
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func metafields(alias: String? = nil, namespace: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (MetafieldConnectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldConnectionQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A string representing the way currency is formatted when the currency isn’t 
		/// specified. 
		@discardableResult
		open func moneyFormat(alias: String? = nil) -> ShopQuery {
			addField(field: "moneyFormat", aliasSuffix: alias)
			return self
		}

		/// The shop’s name. 
		@discardableResult
		open func name(alias: String? = nil) -> ShopQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// Settings related to payments. 
		@discardableResult
		open func paymentSettings(alias: String? = nil, _ subfields: (PaymentSettingsQuery) -> Void) -> ShopQuery {
			let subquery = PaymentSettingsQuery()
			subfields(subquery)

			addField(field: "paymentSettings", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop’s primary domain. 
		@discardableResult
		open func primaryDomain(alias: String? = nil, _ subfields: (DomainQuery) -> Void) -> ShopQuery {
			let subquery = DomainQuery()
			subfields(subquery)

			addField(field: "primaryDomain", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop’s privacy policy. 
		@discardableResult
		open func privacyPolicy(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "privacyPolicy", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Find a product by its handle. 
		///
		/// - parameters:
		///     - handle: The handle of the product.
		///
		@available(*, deprecated, message:"Use `QueryRoot.productByHandle` instead.")
		@discardableResult
		open func productByHandle(alias: String? = nil, handle: String, _ subfields: (ProductQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "productByHandle", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A list of tags that have been added to products. Additional access scope 
		/// required: unauthenticated_read_product_tags. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///
		@available(*, deprecated, message:"Use `QueryRoot.productTags` instead.")
		@discardableResult
		open func productTags(alias: String? = nil, first: Int32, _ subfields: (StringConnectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			args.append("first:\(first)")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = StringConnectionQuery()
			subfields(subquery)

			addField(field: "productTags", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of the shop’s product types. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///
		@available(*, deprecated, message:"Use `QueryRoot.productTypes` instead.")
		@discardableResult
		open func productTypes(alias: String? = nil, first: Int32, _ subfields: (StringConnectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			args.append("first:\(first)")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = StringConnectionQuery()
			subfields(subquery)

			addField(field: "productTypes", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of the shop’s products. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Supported filter parameters:
		///         - `available_for_sale`
		///         - `created_at`
		///         - `product_type`
		///         - `tag`
		///         - `title`
		///         - `updated_at`
		///         - `variants.price`
		///         - `vendor`
		///        
		///        See the detailed [search syntax](https://help.shopify.com/api/getting-started/search-syntax)
		///        for more information about using filters.
		///
		@available(*, deprecated, message:"Use `QueryRoot.products` instead.")
		@discardableResult
		open func products(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductSortKeys? = nil, query: String? = nil, _ subfields: (ProductConnectionQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductConnectionQuery()
			subfields(subquery)

			addField(field: "products", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The shop’s refund policy. 
		@discardableResult
		open func refundPolicy(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "refundPolicy", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop’s shipping policy. 
		@discardableResult
		open func shippingPolicy(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "shippingPolicy", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Countries that the shop ships to. 
		@discardableResult
		open func shipsToCountries(alias: String? = nil) -> ShopQuery {
			addField(field: "shipsToCountries", aliasSuffix: alias)
			return self
		}

		/// The shop’s Shopify Payments account id. 
		@available(*, deprecated, message:"Use `paymentSettings` instead")
		@discardableResult
		open func shopifyPaymentsAccountId(alias: String? = nil) -> ShopQuery {
			addField(field: "shopifyPaymentsAccountId", aliasSuffix: alias)
			return self
		}

		/// The shop’s terms of service. 
		@discardableResult
		open func termsOfService(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "termsOfService", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Shop represents a collection of the general settings and information about 
	/// the shop. 
	open class Shop: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MetafieldParentResource {
		public typealias Query = ShopQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "articles":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ArticleConnection(fields: value)

				case "blogs":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try BlogConnection(fields: value)

				case "collectionByHandle":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Collection(fields: value)

				case "collections":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try CollectionConnection(fields: value)

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "description":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try MetafieldConnection(fields: value)

				case "moneyFormat":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value

				case "paymentSettings":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try PaymentSettings(fields: value)

				case "primaryDomain":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Domain(fields: value)

				case "privacyPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "productByHandle":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				case "productTags":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try StringConnection(fields: value)

				case "productTypes":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try StringConnection(fields: value)

				case "products":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ProductConnection(fields: value)

				case "refundPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "shippingPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "shipsToCountries":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value.map { return CountryCode(rawValue: $0) ?? .unknownValue }

				case "shopifyPaymentsAccountId":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value

				case "termsOfService":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				default:
				throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
			}
		}

		/// List of the shop' articles. 
		@available(*, deprecated, message:"Use `QueryRoot.articles` instead.")
		open var articles: Storefront.ArticleConnection {
			return internalGetArticles()
		}

		@available(*, deprecated, message:"Use `QueryRoot.articles` instead.")

		open func aliasedArticles(alias: String) -> Storefront.ArticleConnection {
			return internalGetArticles(alias: alias)
		}

		func internalGetArticles(alias: String? = nil) -> Storefront.ArticleConnection {
			return field(field: "articles", aliasSuffix: alias) as! Storefront.ArticleConnection
		}

		/// List of the shop' blogs. 
		@available(*, deprecated, message:"Use `QueryRoot.blogs` instead.")
		open var blogs: Storefront.BlogConnection {
			return internalGetBlogs()
		}

		@available(*, deprecated, message:"Use `QueryRoot.blogs` instead.")

		open func aliasedBlogs(alias: String) -> Storefront.BlogConnection {
			return internalGetBlogs(alias: alias)
		}

		func internalGetBlogs(alias: String? = nil) -> Storefront.BlogConnection {
			return field(field: "blogs", aliasSuffix: alias) as! Storefront.BlogConnection
		}

		/// Find a collection by its handle. 
		@available(*, deprecated, message:"Use `QueryRoot.collectionByHandle` instead.")
		open var collectionByHandle: Storefront.Collection? {
			return internalGetCollectionByHandle()
		}

		@available(*, deprecated, message:"Use `QueryRoot.collectionByHandle` instead.")

		open func aliasedCollectionByHandle(alias: String) -> Storefront.Collection? {
			return internalGetCollectionByHandle(alias: alias)
		}

		func internalGetCollectionByHandle(alias: String? = nil) -> Storefront.Collection? {
			return field(field: "collectionByHandle", aliasSuffix: alias) as! Storefront.Collection?
		}

		/// List of the shop’s collections. 
		@available(*, deprecated, message:"Use `QueryRoot.collections` instead.")
		open var collections: Storefront.CollectionConnection {
			return internalGetCollections()
		}

		@available(*, deprecated, message:"Use `QueryRoot.collections` instead.")

		open func aliasedCollections(alias: String) -> Storefront.CollectionConnection {
			return internalGetCollections(alias: alias)
		}

		func internalGetCollections(alias: String? = nil) -> Storefront.CollectionConnection {
			return field(field: "collections", aliasSuffix: alias) as! Storefront.CollectionConnection
		}

		/// The three-letter code for the currency that the shop accepts. 
		@available(*, deprecated, message:"Use `paymentSettings` instead")
		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// A description of the shop. 
		open var description: String? {
			return internalGetDescription()
		}

		func internalGetDescription(alias: String? = nil) -> String? {
			return field(field: "description", aliasSuffix: alias) as! String?
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

		/// A paginated list of metafields associated with the resource. 
		open var metafields: Storefront.MetafieldConnection {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> Storefront.MetafieldConnection {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> Storefront.MetafieldConnection {
			return field(field: "metafields", aliasSuffix: alias) as! Storefront.MetafieldConnection
		}

		/// A string representing the way currency is formatted when the currency isn’t 
		/// specified. 
		open var moneyFormat: String {
			return internalGetMoneyFormat()
		}

		func internalGetMoneyFormat(alias: String? = nil) -> String {
			return field(field: "moneyFormat", aliasSuffix: alias) as! String
		}

		/// The shop’s name. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// Settings related to payments. 
		open var paymentSettings: Storefront.PaymentSettings {
			return internalGetPaymentSettings()
		}

		func internalGetPaymentSettings(alias: String? = nil) -> Storefront.PaymentSettings {
			return field(field: "paymentSettings", aliasSuffix: alias) as! Storefront.PaymentSettings
		}

		/// The shop’s primary domain. 
		open var primaryDomain: Storefront.Domain {
			return internalGetPrimaryDomain()
		}

		func internalGetPrimaryDomain(alias: String? = nil) -> Storefront.Domain {
			return field(field: "primaryDomain", aliasSuffix: alias) as! Storefront.Domain
		}

		/// The shop’s privacy policy. 
		open var privacyPolicy: Storefront.ShopPolicy? {
			return internalGetPrivacyPolicy()
		}

		func internalGetPrivacyPolicy(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "privacyPolicy", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		/// Find a product by its handle. 
		@available(*, deprecated, message:"Use `QueryRoot.productByHandle` instead.")
		open var productByHandle: Storefront.Product? {
			return internalGetProductByHandle()
		}

		@available(*, deprecated, message:"Use `QueryRoot.productByHandle` instead.")

		open func aliasedProductByHandle(alias: String) -> Storefront.Product? {
			return internalGetProductByHandle(alias: alias)
		}

		func internalGetProductByHandle(alias: String? = nil) -> Storefront.Product? {
			return field(field: "productByHandle", aliasSuffix: alias) as! Storefront.Product?
		}

		/// A list of tags that have been added to products. Additional access scope 
		/// required: unauthenticated_read_product_tags. 
		@available(*, deprecated, message:"Use `QueryRoot.productTags` instead.")
		open var productTags: Storefront.StringConnection {
			return internalGetProductTags()
		}

		@available(*, deprecated, message:"Use `QueryRoot.productTags` instead.")

		open func aliasedProductTags(alias: String) -> Storefront.StringConnection {
			return internalGetProductTags(alias: alias)
		}

		func internalGetProductTags(alias: String? = nil) -> Storefront.StringConnection {
			return field(field: "productTags", aliasSuffix: alias) as! Storefront.StringConnection
		}

		/// List of the shop’s product types. 
		@available(*, deprecated, message:"Use `QueryRoot.productTypes` instead.")
		open var productTypes: Storefront.StringConnection {
			return internalGetProductTypes()
		}

		@available(*, deprecated, message:"Use `QueryRoot.productTypes` instead.")

		open func aliasedProductTypes(alias: String) -> Storefront.StringConnection {
			return internalGetProductTypes(alias: alias)
		}

		func internalGetProductTypes(alias: String? = nil) -> Storefront.StringConnection {
			return field(field: "productTypes", aliasSuffix: alias) as! Storefront.StringConnection
		}

		/// List of the shop’s products. 
		@available(*, deprecated, message:"Use `QueryRoot.products` instead.")
		open var products: Storefront.ProductConnection {
			return internalGetProducts()
		}

		@available(*, deprecated, message:"Use `QueryRoot.products` instead.")

		open func aliasedProducts(alias: String) -> Storefront.ProductConnection {
			return internalGetProducts(alias: alias)
		}

		func internalGetProducts(alias: String? = nil) -> Storefront.ProductConnection {
			return field(field: "products", aliasSuffix: alias) as! Storefront.ProductConnection
		}

		/// The shop’s refund policy. 
		open var refundPolicy: Storefront.ShopPolicy? {
			return internalGetRefundPolicy()
		}

		func internalGetRefundPolicy(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "refundPolicy", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		/// The shop’s shipping policy. 
		open var shippingPolicy: Storefront.ShopPolicy? {
			return internalGetShippingPolicy()
		}

		func internalGetShippingPolicy(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "shippingPolicy", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		/// Countries that the shop ships to. 
		open var shipsToCountries: [Storefront.CountryCode] {
			return internalGetShipsToCountries()
		}

		func internalGetShipsToCountries(alias: String? = nil) -> [Storefront.CountryCode] {
			return field(field: "shipsToCountries", aliasSuffix: alias) as! [Storefront.CountryCode]
		}

		/// The shop’s Shopify Payments account id. 
		@available(*, deprecated, message:"Use `paymentSettings` instead")
		open var shopifyPaymentsAccountId: String? {
			return internalGetShopifyPaymentsAccountId()
		}

		func internalGetShopifyPaymentsAccountId(alias: String? = nil) -> String? {
			return field(field: "shopifyPaymentsAccountId", aliasSuffix: alias) as! String?
		}

		/// The shop’s terms of service. 
		open var termsOfService: Storefront.ShopPolicy? {
			return internalGetTermsOfService()
		}

		func internalGetTermsOfService(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "termsOfService", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "articles":
					response.append(internalGetArticles())
					response.append(contentsOf: internalGetArticles().childResponseObjectMap())

					case "blogs":
					response.append(internalGetBlogs())
					response.append(contentsOf: internalGetBlogs().childResponseObjectMap())

					case "collectionByHandle":
					if let value = internalGetCollectionByHandle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "collections":
					response.append(internalGetCollections())
					response.append(contentsOf: internalGetCollections().childResponseObjectMap())

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					response.append(internalGetMetafields())
					response.append(contentsOf: internalGetMetafields().childResponseObjectMap())

					case "paymentSettings":
					response.append(internalGetPaymentSettings())
					response.append(contentsOf: internalGetPaymentSettings().childResponseObjectMap())

					case "primaryDomain":
					response.append(internalGetPrimaryDomain())
					response.append(contentsOf: internalGetPrimaryDomain().childResponseObjectMap())

					case "privacyPolicy":
					if let value = internalGetPrivacyPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "productByHandle":
					if let value = internalGetProductByHandle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "productTags":
					response.append(internalGetProductTags())
					response.append(contentsOf: internalGetProductTags().childResponseObjectMap())

					case "productTypes":
					response.append(internalGetProductTypes())
					response.append(contentsOf: internalGetProductTypes().childResponseObjectMap())

					case "products":
					response.append(internalGetProducts())
					response.append(contentsOf: internalGetProducts().childResponseObjectMap())

					case "refundPolicy":
					if let value = internalGetRefundPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingPolicy":
					if let value = internalGetShippingPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "termsOfService":
					if let value = internalGetTermsOfService() {
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

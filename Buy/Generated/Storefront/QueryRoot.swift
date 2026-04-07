//
//  QueryRoot.swift
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
	/// The entry point for all Storefront API queries. Provides access to shop
	/// resources including products, collections, carts, and customer data, as
	/// well as content like articles and pages. This query acts as the public,
	/// top-level type from which all queries must start. Use individual queries
	/// like
	/// [`product`](https://shopify.dev/docs/api/storefront/current/queries/product)
	/// or
	/// [`collection`](https://shopify.dev/docs/api/storefront/current/queries/collection)
	/// to fetch specific resources by ID or handle. Use plural queries like
	/// [`products`](https://shopify.dev/docs/api/storefront/current/queries/products)
	/// or
	/// [`collections`](https://shopify.dev/docs/api/storefront/current/queries/collections)
	/// to retrieve paginated lists with optional filtering and sorting. The
	/// [`search`](https://shopify.dev/docs/api/storefront/current/queries/search)
	/// and
	/// [`predictiveSearch`](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch)
	/// queries enable storefront search functionality. Explore queries
	/// interactively with the [GraphiQL explorer and sample query
	/// kit](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/api-exploration).
	open class QueryRootQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = QueryRoot

		open override var description: String {
			return "query " + super.description
		}

		/// Returns an
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// by its ID. Each article belongs to a
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog) and
		/// includes content in both plain text and HTML formats,
		/// [`ArticleAuthor`](https://shopify.dev/docs/api/storefront/current/objects/ArticleAuthor)
		/// information,
		/// [`Comment`](https://shopify.dev/docs/api/storefront/current/objects/Comment)
		/// objects, tags, and
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO) data.
		///
		/// - parameters:
		///     - id: The ID of the `Article`.
		///
		@discardableResult
		open func article(alias: String? = nil, id: GraphQL.ID, _ subfields: (ArticleQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ArticleQuery()
			subfields(subquery)

			addField(field: "article", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects from the shop's
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog)
		/// objects. Each article is a blog post containing content, author
		/// information, tags, and optional images. Use the `query` argument to filter
		/// results by author, blog title, tags, or date fields. Sort results using the
		/// `sortKey` argument and reverse them with the `reverse` argument.
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Apply one or multiple filters to the query.
		///        | name | description | acceptable_values | default_value | example_use |
		///        | ---- | ---- | ---- | ---- | ---- |
		///        | author |
		///        | blog_title |
		///        | created_at |
		///        | tag |
		///        | tag_not |
		///        | updated_at |
		///        Refer to the detailed [search syntax](https://shopify.dev/api/usage/search-syntax) for more information about using filters.
		///
		@discardableResult
		open func articles(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ArticleSortKeys? = nil, query: String? = nil, _ subfields: (ArticleConnectionQuery) -> Void) -> QueryRootQuery {
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

		/// Retrieves a
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog) by
		/// its handle or ID. A blog organizes
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects for the online store and includes author information,
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO)
		/// settings, and custom
		/// [`Metafield`](https://shopify.dev/docs/api/storefront/current/objects/Metafield)
		/// objects.
		///
		/// - parameters:
		///     - handle: The handle of the `Blog`.
		///     - id: The ID of the `Blog`.
		///
		@discardableResult
		open func blog(alias: String? = nil, handle: String? = nil, id: GraphQL.ID? = nil, _ subfields: (BlogQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			if let handle = handle {
				args.append("handle:\(GraphQL.quoteString(input: handle))")
			}

			if let id = id {
				args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = BlogQuery()
			subfields(subquery)

			addField(field: "blog", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog) by
		/// its handle. A blog organizes
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects for the online store and includes author information,
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO)
		/// settings, and custom
		/// [`Metafield`](https://shopify.dev/docs/api/storefront/current/objects/Metafield)
		/// objects.
		///
		/// - parameters:
		///     - handle: The handle of the blog.
		///
		@available(*, deprecated, message: "Use `blog` instead.")
		@discardableResult
		open func blogByHandle(alias: String? = nil, handle: String, _ subfields: (BlogQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = BlogQuery()
			subfields(subquery)

			addField(field: "blogByHandle", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of the shop's
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog)
		/// objects. Each blog serves as a container for
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects.
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Apply one or multiple filters to the query.
		///        | name | description | acceptable_values | default_value | example_use |
		///        | ---- | ---- | ---- | ---- | ---- |
		///        | created_at |
		///        | handle |
		///        | title |
		///        | updated_at |
		///        Refer to the detailed [search syntax](https://shopify.dev/api/usage/search-syntax) for more information about using filters.
		///
		@discardableResult
		open func blogs(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: BlogSortKeys? = nil, query: String? = nil, _ subfields: (BlogConnectionQuery) -> Void) -> QueryRootQuery {
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

		/// Returns a
		/// [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart) by
		/// its ID. The cart contains the merchandise lines a buyer intends to
		/// purchase, along with estimated costs, applied discounts, gift cards, and
		/// delivery options. Use the
		/// [`checkoutUrl`](https://shopify.dev/docs/api/storefront/latest/queries/cart#returns-Cart.fields.checkoutUrl)
		/// field to redirect buyers to Shopify's web checkout when they're ready to
		/// complete their purchase. For more information, refer to [Manage a cart with
		/// the Storefront
		/// API](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/cart/manage).
		///
		/// - parameters:
		///     - id: The ID of the cart.
		///
		@discardableResult
		open func cart(alias: String? = nil, id: GraphQL.ID, _ subfields: (CartQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartQuery()
			subfields(subquery)

			addField(field: "cart", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A poll for the status of the cart checkout completion and order creation.
		///
		/// - parameters:
		///     - attemptId: The ID of the attempt.
		///
		@discardableResult
		open func cartCompletionAttempt(alias: String? = nil, attemptId: String, _ subfields: (CartCompletionAttemptResultQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("attemptId:\(GraphQL.quoteString(input: attemptId))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartCompletionAttemptResultQuery()
			subfields(subquery)

			addField(field: "cartCompletionAttempt", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a single
		/// [`Collection`](https://shopify.dev/docs/api/storefront/current/objects/Collection)
		/// by its ID or handle. Use the
		/// [`products`](https://shopify.dev/docs/api/storefront/current/objects/Collection#field-Collection.fields.products)
		/// field to access items in the collection.
		///
		/// - parameters:
		///     - id: The ID of the `Collection`.
		///     - handle: The handle of the `Collection`.
		///
		@discardableResult
		open func collection(alias: String? = nil, id: GraphQL.ID? = nil, handle: String? = nil, _ subfields: (CollectionQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			if let id = id {
				args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")
			}

			if let handle = handle {
				args.append("handle:\(GraphQL.quoteString(input: handle))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CollectionQuery()
			subfields(subquery)

			addField(field: "collection", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a
		/// [`Collection`](https://shopify.dev/docs/api/storefront/current/objects/Collection)
		/// by its URL-friendly handle. Handles are automatically generated from
		/// collection titles but merchants can customize them.
		///
		/// - parameters:
		///     - handle: The handle of the collection.
		///
		@available(*, deprecated, message: "Use `collection` instead.")
		@discardableResult
		open func collectionByHandle(alias: String? = nil, handle: String, _ subfields: (CollectionQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CollectionQuery()
			subfields(subquery)

			addField(field: "collectionByHandle", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of the shop's
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection).
		/// Each `Collection` object includes a nested connection to its
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Collection#field-Collection.fields.products).
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Apply one or multiple filters to the query.
		///        | name | description | acceptable_values | default_value | example_use |
		///        | ---- | ---- | ---- | ---- | ---- |
		///        | collection_type |
		///        | title |
		///        | updated_at |
		///        Refer to the detailed [search syntax](https://shopify.dev/api/usage/search-syntax) for more information about using filters.
		///
		@discardableResult
		open func collections(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: CollectionSortKeys? = nil, query: String? = nil, _ subfields: (CollectionConnectionQuery) -> Void) -> QueryRootQuery {
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

		/// Retrieves the
		/// [`Customer`](https://shopify.dev/docs/api/storefront/current/objects/Customer)
		/// associated with the provided access token. Use the
		/// [`customerAccessTokenCreate`](https://shopify.dev/docs/api/storefront/current/mutations/customerAccessTokenCreate)
		/// mutation to obtain an access token using legacy customer account
		/// authentication (email and password). The returned customer includes data
		/// such as contact information,
		/// [addresses](https://shopify.dev/docs/api/storefront/current/objects/MailingAddress),
		/// [orders](https://shopify.dev/docs/api/storefront/current/objects/Order),
		/// and [custom data](https://shopify.dev/docs/apps/build/custom-data)
		/// associated with the customer.
		///
		/// - parameters:
		///     - customerAccessToken: The customer access token.
		///
		@discardableResult
		open func customer(alias: String? = nil, customerAccessToken: String, _ subfields: (CustomerQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns the shop's localization settings. Use this query to build [country
		/// and language
		/// selectors](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/markets)
		/// for your storefront. The
		/// [`country`](https://shopify.dev/docs/api/storefront/latest/queries/localization#returns-Localization.fields.country)
		/// and
		/// [`language`](https://shopify.dev/docs/api/storefront/latest/queries/localization#returns-Localization.fields.language)
		/// fields reflect the active localized experience. To change the context, use
		/// the [`@inContext`](https://shopify.dev/docs/api/storefront#directives)
		/// directive with your desired country or language code.
		@discardableResult
		open func localization(alias: String? = nil, _ subfields: (LocalizationQuery) -> Void) -> QueryRootQuery {
			let subquery = LocalizationQuery()
			subfields(subquery)

			addField(field: "localization", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Returns shop locations that support in-store pickup. Use the `near`
		/// argument with
		/// [`GeoCoordinateInput`](https://shopify.dev/docs/api/storefront/current/input-objects/GeoCoordinateInput)
		/// to sort results by proximity to the customer's location. When sorting by
		/// distance, set `sortKey` to
		/// [`DISTANCE`](https://shopify.dev/docs/api/storefront/current/queries/locations#arguments-sortKey.enums.DISTANCE)
		/// and provide coordinates using the
		/// [`near`](https://shopify.dev/docs/api/storefront/current/queries/locations#arguments-near)
		/// argument. Learn more about [supporting local pickup on
		/// storefronts](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/local-pickup).
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - near: Used to sort results based on proximity to the provided location.
		///
		@discardableResult
		open func locations(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: LocationSortKeys? = nil, near: GeoCoordinateInput? = nil, _ subfields: (LocationConnectionQuery) -> Void) -> QueryRootQuery {
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

			if let near = near {
				args.append("near:\(near.serialize())")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = LocationConnectionQuery()
			subfields(subquery)

			addField(field: "locations", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a
		/// [`Menu`](https://shopify.dev/docs/api/storefront/current/objects/Menu) by
		/// its handle. Menus are [hierarchical navigation
		/// structures](https://help.shopify.com/manual/online-store/menus-and-links)
		/// that merchants configure for their storefront, such as header and footer
		/// navigation. Each menu contains
		/// [`MenuItem`](https://shopify.dev/docs/api/storefront/current/objects/MenuItem)
		/// objects that can nest up to three levels deep, with each item linking to
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [pages](https://shopify.dev/docs/api/storefront/current/objects/Page),
		/// [blogs](https://shopify.dev/docs/api/storefront/current/objects/Blog), or
		/// external URLs.
		///
		/// - parameters:
		///     - handle: The navigation menu's handle.
		///
		@discardableResult
		open func menu(alias: String? = nil, handle: String, _ subfields: (MenuQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MenuQuery()
			subfields(subquery)

			addField(field: "menu", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a single
		/// [`Metaobject`](https://shopify.dev/docs/api/storefront/current/objects/Metaobject)
		/// by either its [`global
		/// ID`](https://shopify.dev/docs/api/storefront/current/queries/metaobject#arguments-id)
		/// or its
		/// [`handle`](https://shopify.dev/docs/api/storefront/current/queries/metaobject#arguments-handle).
		/// > Note: > When using the handle, you must also provide the metaobject type
		/// because handles are only unique within a type.
		///
		/// - parameters:
		///     - id: The ID of the metaobject.
		///     - handle: The handle and type of the metaobject.
		///
		@discardableResult
		open func metaobject(alias: String? = nil, id: GraphQL.ID? = nil, handle: MetaobjectHandleInput? = nil, _ subfields: (MetaobjectQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			if let id = id {
				args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")
			}

			if let handle = handle {
				args.append("handle:\(handle.serialize())")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetaobjectQuery()
			subfields(subquery)

			addField(field: "metaobject", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of
		/// [`Metaobject`](https://shopify.dev/docs/api/storefront/current/objects/Metaobject)
		/// entries for a specific type. Metaobjects are [custom data
		/// structures](https://shopify.dev/docs/apps/build/metaobjects) that extend
		/// Shopify's data model with merchant-defined or app-defined content like size
		/// charts, product highlights, or custom sections. The required `type`
		/// argument specifies which metaobject type to retrieve. You can sort results
		/// by `id` or `updated_at` using the `sortKey` argument.
		///
		/// - parameters:
		///     - type: The type of metaobject to retrieve.
		///     - sortKey: The key of a field to sort with. Supports "id" and "updated_at".
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func metaobjects(alias: String? = nil, type: String, sortKey: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (MetaobjectConnectionQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("type:\(GraphQL.quoteString(input: type))")

			if let sortKey = sortKey {
				args.append("sortKey:\(GraphQL.quoteString(input: sortKey))")
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

			let subquery = MetaobjectConnectionQuery()
			subfields(subquery)

			addField(field: "metaobjects", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves any object that implements the
		/// [`Node`](https://shopify.dev/docs/api/storefront/current/interfaces/Node)
		/// interface by its globally-unique ID. Use inline fragments to access
		/// type-specific fields on the returned object. This query follows the [Relay
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface)
		/// and is commonly used for refetching objects when you have their ID but need
		/// updated data.
		///
		/// - parameters:
		///     - id: The ID of the Node to return.
		///
		@discardableResult
		open func node(alias: String? = nil, id: GraphQL.ID, _ subfields: (NodeQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = NodeQuery()
			subfields(subquery)

			addField(field: "node", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves multiple objects by their global IDs in a single request. Any
		/// object that implements the
		/// [`Node`](https://shopify.dev/docs/api/storefront/current/interfaces/Node)
		/// interface can be fetched, including
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// and [pages](https://shopify.dev/docs/api/storefront/current/objects/Page).
		/// Use inline fragments to access type-specific fields on the returned
		/// objects. The input accepts up to 250 IDs.
		///
		/// - parameters:
		///     - ids: The IDs of the Nodes to return.
		///
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func nodes(alias: String? = nil, ids: [GraphQL.ID], _ subfields: (NodeQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("ids:[\(ids.map { "\(GraphQL.quoteString(input: "\($0.rawValue)"))" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = NodeQuery()
			subfields(subquery)

			addField(field: "nodes", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page) by
		/// its
		/// [`handle`](https://shopify.dev/docs/api/storefront/current/queries/page#arguments-handle)
		/// or
		/// [`id`](https://shopify.dev/docs/api/storefront/current/queries/page#arguments-id).
		/// Pages are static content pages that merchants display outside their product
		/// catalog, such as "About Us," "Contact," or policy pages. The returned page
		/// includes information such as the [HTML body
		/// content](https://shopify.dev/docs/api/storefront/current/queries/page#returns-Page.fields.body),
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO)
		/// information, and any associated
		/// [`Metafield`](https://shopify.dev/docs/api/storefront/current/objects/Metafield)
		/// objects.
		///
		/// - parameters:
		///     - handle: The handle of the `Page`.
		///     - id: The ID of the `Page`.
		///
		@discardableResult
		open func page(alias: String? = nil, handle: String? = nil, id: GraphQL.ID? = nil, _ subfields: (PageQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			if let handle = handle {
				args.append("handle:\(GraphQL.quoteString(input: handle))")
			}

			if let id = id {
				args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = PageQuery()
			subfields(subquery)

			addField(field: "page", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page) by
		/// its handle.
		///
		/// - parameters:
		///     - handle: The handle of the page.
		///
		@available(*, deprecated, message: "Use `page` instead.")
		@discardableResult
		open func pageByHandle(alias: String? = nil, handle: String, _ subfields: (PageQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = PageQuery()
			subfields(subquery)

			addField(field: "pageByHandle", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of the shop's content
		/// [pages](https://shopify.dev/docs/api/storefront/current/objects/Page).
		/// Pages are custom HTML content like "About Us", "Contact", or policy
		/// information that merchants display outside their product catalog.
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: Apply one or multiple filters to the query.
		///        | name | description | acceptable_values | default_value | example_use |
		///        | ---- | ---- | ---- | ---- | ---- |
		///        | created_at |
		///        | handle |
		///        | title |
		///        | updated_at |
		///        Refer to the detailed [search syntax](https://shopify.dev/api/usage/search-syntax) for more information about using filters.
		///
		@discardableResult
		open func pages(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: PageSortKeys? = nil, query: String? = nil, _ subfields: (PageConnectionQuery) -> Void) -> QueryRootQuery {
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

			let subquery = PageConnectionQuery()
			subfields(subquery)

			addField(field: "pages", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Settings related to payments.
		@discardableResult
		open func paymentSettings(alias: String? = nil, _ subfields: (PaymentSettingsQuery) -> Void) -> QueryRootQuery {
			let subquery = PaymentSettingsQuery()
			subfields(subquery)

			addField(field: "paymentSettings", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Returns suggested results as customers type in a search field, enabling
		/// type-ahead search experiences. The query matches
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// [pages](https://shopify.dev/docs/api/storefront/current/objects/Page), and
		/// [articles](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// based on partial search terms, and also provides [search query
		/// suggestions](https://shopify.dev/docs/api/storefront/current/objects/SearchQuerySuggestion)
		/// to help customers refine their search. You can filter results by resource
		/// type and limit the quantity. The
		/// [`limitScope`](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch#arguments-limitScope)
		/// argument controls whether limits apply across all result types or per type.
		/// Use
		/// [`unavailableProducts`](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch#arguments-unavailableProducts)
		/// to control how out-of-stock products appear in results.
		///
		/// - parameters:
		///     - limit: Limits the number of results based on `limit_scope`. The value can range from 1 to 10, and the default is 10.
		///     - limitScope: Decides the distribution of results.
		///     - query: The search query.
		///     - searchableFields: Specifies the list of resource fields to use for search. The default fields searched on are TITLE, PRODUCT_TYPE, VARIANT_TITLE, and VENDOR. For the best search experience, you should search on the default field set.
		///
		///        The input must not contain more than `250` values.
		///     - types: The types of resources to search for.
		///
		///        The input must not contain more than `250` values.
		///     - unavailableProducts: Specifies how unavailable products are displayed in the search results.
		///
		@discardableResult
		open func predictiveSearch(alias: String? = nil, limit: Int32? = nil, limitScope: PredictiveSearchLimitScope? = nil, query: String, searchableFields: [SearchableField]? = nil, types: [PredictiveSearchType]? = nil, unavailableProducts: SearchUnavailableProductsType? = nil, _ subfields: (PredictiveSearchResultQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("query:\(GraphQL.quoteString(input: query))")

			if let limit = limit {
				args.append("limit:\(limit)")
			}

			if let limitScope = limitScope {
				args.append("limitScope:\(limitScope.rawValue)")
			}

			if let searchableFields = searchableFields {
				args.append("searchableFields:[\(searchableFields.map { "\($0.rawValue)" }.joined(separator: ","))]")
			}

			if let types = types {
				args.append("types:[\(types.map { "\($0.rawValue)" }.joined(separator: ","))]")
			}

			if let unavailableProducts = unavailableProducts {
				args.append("unavailableProducts:\(unavailableProducts.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = PredictiveSearchResultQuery()
			subfields(subquery)

			addField(field: "predictiveSearch", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a single
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// by its ID or handle. Use this query to build product detail pages, access
		/// variant and pricing information, or fetch product media and
		/// [metafields](https://shopify.dev/docs/api/storefront/current/objects/Metafield).
		/// See some [examples of querying
		/// products](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/getting-started).
		///
		/// - parameters:
		///     - id: The ID of the `Product`.
		///     - handle: The handle of the `Product`.
		///
		@discardableResult
		open func product(alias: String? = nil, id: GraphQL.ID? = nil, handle: String? = nil, _ subfields: (ProductQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			if let id = id {
				args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")
			}

			if let handle = handle {
				args.append("handle:\(GraphQL.quoteString(input: handle))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "product", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Retrieves a
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// by its handle. The handle is a URL-friendly identifier that's automatically
		/// generated from the product's title. If no product exists with the specified
		/// handle, returns `null`.
		///
		/// - parameters:
		///     - handle: A unique, human-readable string of the product's title.
		///        A handle can contain letters, hyphens (`-`), and numbers, but no spaces.
		///        The handle is used in the online store URL for the product.
		///
		@available(*, deprecated, message: "Use `product` instead.")
		@discardableResult
		open func productByHandle(alias: String? = nil, handle: String, _ subfields: (ProductQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("handle:\(GraphQL.quoteString(input: handle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "productByHandle", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns recommended products for a given product, identified by either ID
		/// or handle. Use the
		/// [`intent`](https://shopify.dev/docs/api/storefront/current/enums/ProductRecommendationIntent)
		/// argument to control the recommendation strategy. Shopify [auto-generates
		/// related
		/// recommendations](https://shopify.dev/docs/storefronts/themes/product-merchandising/recommendations)
		/// based on sales data, product descriptions, and collection relationships.
		/// Complementary recommendations require [manual
		/// configuration](https://help.shopify.com/manual/online-store/storefront-search/search-and-discovery-recommendations)
		/// through the Shopify Search & Discovery app. Returns up to ten
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// objects.
		///
		/// - parameters:
		///     - productId: The id of the product.
		///     - productHandle: The handle of the product.
		///     - intent: The recommendation intent that is used to generate product recommendations. You can use intent to generate product recommendations on various pages across the channels, according to different strategies.
		///
		@discardableResult
		open func productRecommendations(alias: String? = nil, productId: GraphQL.ID? = nil, productHandle: String? = nil, intent: ProductRecommendationIntent? = nil, _ subfields: (ProductQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			if let productId = productId {
				args.append("productId:\(GraphQL.quoteString(input: "\(productId.rawValue)"))")
			}

			if let productHandle = productHandle {
				args.append("productHandle:\(GraphQL.quoteString(input: productHandle))")
			}

			if let intent = intent {
				args.append("intent:\(intent.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "productRecommendations", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of all tags that have been added to
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// in the shop. Useful for building tag-based product filtering or navigation
		/// in a storefront.
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///
		@discardableResult
		open func productTags(alias: String? = nil, first: Int32, _ subfields: (StringConnectionQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("first:\(first)")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = StringConnectionQuery()
			subfields(subquery)

			addField(field: "productTags", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a list of product types from the shop's
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// objects that are published to your app. Use this query to build [filtering
		/// interfaces](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/filter-products)
		/// or navigation menus based on product categorization.
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///
		@discardableResult
		open func productTypes(alias: String? = nil, first: Int32, _ subfields: (StringConnectionQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("first:\(first)")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = StringConnectionQuery()
			subfields(subquery)

			addField(field: "productTypes", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of the shop's
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product).
		/// For full-text storefront search, use the
		/// [`search`](https://shopify.dev/docs/api/storefront/current/queries/search)
		/// query instead.
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: You can apply one or multiple filters to a query.
		///        | name | description | acceptable_values | default_value | example_use |
		///        | ---- | ---- | ---- | ---- | ---- |
		///        | available_for_sale | Filter by products that have at least one product variant available for sale. |
		///        | created_at | Filter by the date and time when the product was created. | | | - `created_at:>'2020-10-21T23:39:20Z'`<br/> - `created_at:<now`<br/> - `created_at:<=2024` |
		///        | product_type | Filter by a comma-separated list of [product types](https://help.shopify.com/en/manual/products/details/product-type). | | | `product_type:snowboard` |
		///        | tag | Filter products by the product [`tags`](https://shopify.dev/docs/api/storefront/latest/objects/Product#field-tags) field. | | | `tag:my_tag` |
		///        | tag_not | Filter by products that don't have the specified product [tags](https://shopify.dev/docs/api/storefront/latest/objects/Product#field-tags). | | | `tag_not:my_tag` |
		///        | title | Filter by the product [`title`](https://shopify.dev/docs/api/storefront/latest/objects/Product#field-title) field. | | | `title:The Minimal Snowboard` |
		///        | updated_at | Filter by the date and time when the product was last updated. | | | - `updated_at:>'2020-10-21T23:39:20Z'`<br/> - `updated_at:<now`<br/> - `updated_at:<=2024` |
		///        | variants.price | Filter by the price of the product's variants. |
		///        | vendor | Filter by the product [`vendor`](https://shopify.dev/docs/api/storefront/latest/objects/Product#field-vendor) field. | | | - `vendor:Snowdevil`<br/> - `vendor:Snowdevil OR vendor:Icedevil` |
		///        Learn more about [Shopify API search syntax](https://shopify.dev/api/usage/search-syntax).
		///
		@discardableResult
		open func products(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductSortKeys? = nil, query: String? = nil, _ subfields: (ProductConnectionQuery) -> Void) -> QueryRootQuery {
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

		/// Returns all public Storefront [API
		/// versions](https://shopify.dev/docs/api/storefront/current/objects/ApiVersion),
		/// including supported, release candidate, and unstable versions.
		@discardableResult
		open func publicApiVersions(alias: String? = nil, _ subfields: (ApiVersionQuery) -> Void) -> QueryRootQuery {
			let subquery = ApiVersionQuery()
			subfields(subquery)

			addField(field: "publicApiVersions", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Returns paginated search results for
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page), and
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// resources based on a query string. Results are sorted by relevance by
		/// default. The response includes the total result count and available product
		/// filters for building [faceted search
		/// interfaces](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/filter-products).
		/// Use the
		/// [`prefix`](https://shopify.dev/docs/api/storefront/current/enums/SearchPrefixQueryType)
		/// argument to enable partial word matching on the last search term, allowing
		/// queries like "winter snow" to match "snowboard" or "snowshoe".
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - query: The search query.
		///     - prefix: Specifies whether to perform a partial word match on the last search term.
		///     - productFilters: Returns a subset of products matching all product filters.
		///
		///        The input must not contain more than `250` values.
		///     - types: The types of resources to search for.
		///
		///        The input must not contain more than `250` values.
		///     - unavailableProducts: Specifies how unavailable products or variants are displayed in the search results.
		///
		@discardableResult
		open func search(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: SearchSortKeys? = nil, query: String, `prefix`: SearchPrefixQueryType? = nil, productFilters: [ProductFilter]? = nil, types: [SearchType]? = nil, unavailableProducts: SearchUnavailableProductsType? = nil, _ subfields: (SearchResultItemConnectionQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("query:\(GraphQL.quoteString(input: query))")

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

			if let `prefix` = `prefix` {
				args.append("prefix:\(prefix.rawValue)")
			}

			if let productFilters = productFilters {
				args.append("productFilters:[\(productFilters.map { "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let types = types {
				args.append("types:[\(types.map { "\($0.rawValue)" }.joined(separator: ","))]")
			}

			if let unavailableProducts = unavailableProducts {
				args.append("unavailableProducts:\(unavailableProducts.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = SearchResultItemConnectionQuery()
			subfields(subquery)

			addField(field: "search", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns the
		/// [`Shop`](https://shopify.dev/docs/api/storefront/current/objects/Shop)
		/// associated with the storefront access token. The `Shop` object provides
		/// general store information such as the shop name, description, and primary
		/// domain. Use this query to access data like store policies,
		/// [`PaymentSettings`](https://shopify.dev/docs/api/storefront/current/objects/PaymentSettings),
		/// [`Brand`](https://shopify.dev/docs/api/storefront/current/objects/Brand)
		/// configuration, and shipping destinations. It also exposes
		/// [`ShopPayInstallmentsPricing`](https://shopify.dev/docs/api/storefront/current/objects/ShopPayInstallmentsPricing)
		/// and
		/// [`SocialLoginProvider`](https://shopify.dev/docs/api/storefront/current/objects/SocialLoginProvider)
		/// options for customer accounts.
		@discardableResult
		open func shop(alias: String? = nil, _ subfields: (ShopQuery) -> Void) -> QueryRootQuery {
			let subquery = ShopQuery()
			subfields(subquery)

			addField(field: "shop", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Returns sitemap data for a specific resource type, enabling headless
		/// storefronts to generate XML sitemaps for search engine optimization. The
		/// query provides a page count and paginated access to resources like
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [`Collection`](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page), and
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog)
		/// objects. When paginating through resources, the number of items per page
		/// varies from 0 to 250, and empty pages can occur without indicating the end
		/// of results. Always check
		/// [`hasNextPage`](https://shopify.dev/docs/api/storefront/current/objects/PaginatedSitemapResources#field-PaginatedSitemapResources.fields.hasNextPage)
		/// to determine if more pages are available.
		///
		/// - parameters:
		///     - type: The type of the resource for the sitemap.
		///
		@discardableResult
		open func sitemap(alias: String? = nil, type: SitemapType, _ subfields: (SitemapQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("type:\(type.rawValue)")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = SitemapQuery()
			subfields(subquery)

			addField(field: "sitemap", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a paginated list of
		/// [`UrlRedirect`](https://shopify.dev/docs/api/storefront/current/objects/UrlRedirect)
		/// objects configured for the shop. Each redirect maps an old path to a target
		/// location.
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - query: Apply one or multiple filters to the query.
		///        | name | description | acceptable_values | default_value | example_use |
		///        | ---- | ---- | ---- | ---- | ---- |
		///        | created_at |
		///        | path |
		///        | target |
		///        Refer to the detailed [search syntax](https://shopify.dev/api/usage/search-syntax) for more information about using filters.
		///
		@discardableResult
		open func urlRedirects(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, query: String? = nil, _ subfields: (UrlRedirectConnectionQuery) -> Void) -> QueryRootQuery {
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

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = UrlRedirectConnectionQuery()
			subfields(subquery)

			addField(field: "urlRedirects", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}
	}

	/// The entry point for all Storefront API queries. Provides access to shop
	/// resources including products, collections, carts, and customer data, as
	/// well as content like articles and pages. This query acts as the public,
	/// top-level type from which all queries must start. Use individual queries
	/// like
	/// [`product`](https://shopify.dev/docs/api/storefront/current/queries/product)
	/// or
	/// [`collection`](https://shopify.dev/docs/api/storefront/current/queries/collection)
	/// to fetch specific resources by ID or handle. Use plural queries like
	/// [`products`](https://shopify.dev/docs/api/storefront/current/queries/products)
	/// or
	/// [`collections`](https://shopify.dev/docs/api/storefront/current/queries/collections)
	/// to retrieve paginated lists with optional filtering and sorting. The
	/// [`search`](https://shopify.dev/docs/api/storefront/current/queries/search)
	/// and
	/// [`predictiveSearch`](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch)
	/// queries enable storefront search functionality. Explore queries
	/// interactively with the [GraphiQL explorer and sample query
	/// kit](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/api-exploration).
	open class QueryRoot: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = QueryRootQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "article":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Article(fields: value)

				case "articles":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try ArticleConnection(fields: value)

				case "blog":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Blog(fields: value)

				case "blogByHandle":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Blog(fields: value)

				case "blogs":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try BlogConnection(fields: value)

				case "cart":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Cart(fields: value)

				case "cartCompletionAttempt":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try UnknownCartCompletionAttemptResult.create(fields: value)

				case "collection":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Collection(fields: value)

				case "collectionByHandle":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Collection(fields: value)

				case "collections":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try CollectionConnection(fields: value)

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "localization":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Localization(fields: value)

				case "locations":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try LocationConnection(fields: value)

				case "menu":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Menu(fields: value)

				case "metaobject":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Metaobject(fields: value)

				case "metaobjects":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try MetaobjectConnection(fields: value)

				case "node":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try UnknownNode.create(fields: value)

				case "nodes":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try UnknownNode.create(fields: value) } as [Any?]

				case "page":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Page(fields: value)

				case "pageByHandle":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Page(fields: value)

				case "pages":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try PageConnection(fields: value)

				case "paymentSettings":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try PaymentSettings(fields: value)

				case "predictiveSearch":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try PredictiveSearchResult(fields: value)

				case "product":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				case "productByHandle":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				case "productRecommendations":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Product(fields: $0) }

				case "productTags":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try StringConnection(fields: value)

				case "productTypes":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try StringConnection(fields: value)

				case "products":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try ProductConnection(fields: value)

				case "publicApiVersions":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ApiVersion(fields: $0) }

				case "search":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try SearchResultItemConnection(fields: value)

				case "shop":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Shop(fields: value)

				case "sitemap":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try Sitemap(fields: value)

				case "urlRedirects":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
				}
				return try UrlRedirectConnection(fields: value)

				default:
				throw SchemaViolationError(type: QueryRoot.self, field: fieldName, value: fieldValue)
			}
		}

		/// Returns an
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// by its ID. Each article belongs to a
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog) and
		/// includes content in both plain text and HTML formats,
		/// [`ArticleAuthor`](https://shopify.dev/docs/api/storefront/current/objects/ArticleAuthor)
		/// information,
		/// [`Comment`](https://shopify.dev/docs/api/storefront/current/objects/Comment)
		/// objects, tags, and
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO) data.
		open var article: Storefront.Article? {
			return internalGetArticle()
		}

		open func aliasedArticle(alias: String) -> Storefront.Article? {
			return internalGetArticle(alias: alias)
		}

		func internalGetArticle(alias: String? = nil) -> Storefront.Article? {
			return field(field: "article", aliasSuffix: alias) as! Storefront.Article?
		}

		/// Returns a paginated list of
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects from the shop's
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog)
		/// objects. Each article is a blog post containing content, author
		/// information, tags, and optional images. Use the `query` argument to filter
		/// results by author, blog title, tags, or date fields. Sort results using the
		/// `sortKey` argument and reverse them with the `reverse` argument.
		open var articles: Storefront.ArticleConnection {
			return internalGetArticles()
		}

		open func aliasedArticles(alias: String) -> Storefront.ArticleConnection {
			return internalGetArticles(alias: alias)
		}

		func internalGetArticles(alias: String? = nil) -> Storefront.ArticleConnection {
			return field(field: "articles", aliasSuffix: alias) as! Storefront.ArticleConnection
		}

		/// Retrieves a
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog) by
		/// its handle or ID. A blog organizes
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects for the online store and includes author information,
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO)
		/// settings, and custom
		/// [`Metafield`](https://shopify.dev/docs/api/storefront/current/objects/Metafield)
		/// objects.
		open var blog: Storefront.Blog? {
			return internalGetBlog()
		}

		open func aliasedBlog(alias: String) -> Storefront.Blog? {
			return internalGetBlog(alias: alias)
		}

		func internalGetBlog(alias: String? = nil) -> Storefront.Blog? {
			return field(field: "blog", aliasSuffix: alias) as! Storefront.Blog?
		}

		/// Retrieves a
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog) by
		/// its handle. A blog organizes
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects for the online store and includes author information,
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO)
		/// settings, and custom
		/// [`Metafield`](https://shopify.dev/docs/api/storefront/current/objects/Metafield)
		/// objects.
		@available(*, deprecated, message: "Use `blog` instead.")
		open var blogByHandle: Storefront.Blog? {
			return internalGetBlogByHandle()
		}

		@available(*, deprecated, message: "Use `blog` instead.")

		open func aliasedBlogByHandle(alias: String) -> Storefront.Blog? {
			return internalGetBlogByHandle(alias: alias)
		}

		func internalGetBlogByHandle(alias: String? = nil) -> Storefront.Blog? {
			return field(field: "blogByHandle", aliasSuffix: alias) as! Storefront.Blog?
		}

		/// Returns a paginated list of the shop's
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog)
		/// objects. Each blog serves as a container for
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// objects.
		open var blogs: Storefront.BlogConnection {
			return internalGetBlogs()
		}

		open func aliasedBlogs(alias: String) -> Storefront.BlogConnection {
			return internalGetBlogs(alias: alias)
		}

		func internalGetBlogs(alias: String? = nil) -> Storefront.BlogConnection {
			return field(field: "blogs", aliasSuffix: alias) as! Storefront.BlogConnection
		}

		/// Returns a
		/// [`Cart`](https://shopify.dev/docs/api/storefront/current/objects/Cart) by
		/// its ID. The cart contains the merchandise lines a buyer intends to
		/// purchase, along with estimated costs, applied discounts, gift cards, and
		/// delivery options. Use the
		/// [`checkoutUrl`](https://shopify.dev/docs/api/storefront/latest/queries/cart#returns-Cart.fields.checkoutUrl)
		/// field to redirect buyers to Shopify's web checkout when they're ready to
		/// complete their purchase. For more information, refer to [Manage a cart with
		/// the Storefront
		/// API](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/cart/manage).
		open var cart: Storefront.Cart? {
			return internalGetCart()
		}

		open func aliasedCart(alias: String) -> Storefront.Cart? {
			return internalGetCart(alias: alias)
		}

		func internalGetCart(alias: String? = nil) -> Storefront.Cart? {
			return field(field: "cart", aliasSuffix: alias) as! Storefront.Cart?
		}

		/// A poll for the status of the cart checkout completion and order creation.
		open var cartCompletionAttempt: CartCompletionAttemptResult? {
			return internalGetCartCompletionAttempt()
		}

		open func aliasedCartCompletionAttempt(alias: String) -> CartCompletionAttemptResult? {
			return internalGetCartCompletionAttempt(alias: alias)
		}

		func internalGetCartCompletionAttempt(alias: String? = nil) -> CartCompletionAttemptResult? {
			return field(field: "cartCompletionAttempt", aliasSuffix: alias) as! CartCompletionAttemptResult?
		}

		/// Retrieves a single
		/// [`Collection`](https://shopify.dev/docs/api/storefront/current/objects/Collection)
		/// by its ID or handle. Use the
		/// [`products`](https://shopify.dev/docs/api/storefront/current/objects/Collection#field-Collection.fields.products)
		/// field to access items in the collection.
		open var collection: Storefront.Collection? {
			return internalGetCollection()
		}

		open func aliasedCollection(alias: String) -> Storefront.Collection? {
			return internalGetCollection(alias: alias)
		}

		func internalGetCollection(alias: String? = nil) -> Storefront.Collection? {
			return field(field: "collection", aliasSuffix: alias) as! Storefront.Collection?
		}

		/// Retrieves a
		/// [`Collection`](https://shopify.dev/docs/api/storefront/current/objects/Collection)
		/// by its URL-friendly handle. Handles are automatically generated from
		/// collection titles but merchants can customize them.
		@available(*, deprecated, message: "Use `collection` instead.")
		open var collectionByHandle: Storefront.Collection? {
			return internalGetCollectionByHandle()
		}

		@available(*, deprecated, message: "Use `collection` instead.")

		open func aliasedCollectionByHandle(alias: String) -> Storefront.Collection? {
			return internalGetCollectionByHandle(alias: alias)
		}

		func internalGetCollectionByHandle(alias: String? = nil) -> Storefront.Collection? {
			return field(field: "collectionByHandle", aliasSuffix: alias) as! Storefront.Collection?
		}

		/// Returns a paginated list of the shop's
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection).
		/// Each `Collection` object includes a nested connection to its
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Collection#field-Collection.fields.products).
		open var collections: Storefront.CollectionConnection {
			return internalGetCollections()
		}

		open func aliasedCollections(alias: String) -> Storefront.CollectionConnection {
			return internalGetCollections(alias: alias)
		}

		func internalGetCollections(alias: String? = nil) -> Storefront.CollectionConnection {
			return field(field: "collections", aliasSuffix: alias) as! Storefront.CollectionConnection
		}

		/// Retrieves the
		/// [`Customer`](https://shopify.dev/docs/api/storefront/current/objects/Customer)
		/// associated with the provided access token. Use the
		/// [`customerAccessTokenCreate`](https://shopify.dev/docs/api/storefront/current/mutations/customerAccessTokenCreate)
		/// mutation to obtain an access token using legacy customer account
		/// authentication (email and password). The returned customer includes data
		/// such as contact information,
		/// [addresses](https://shopify.dev/docs/api/storefront/current/objects/MailingAddress),
		/// [orders](https://shopify.dev/docs/api/storefront/current/objects/Order),
		/// and [custom data](https://shopify.dev/docs/apps/build/custom-data)
		/// associated with the customer.
		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		open func aliasedCustomer(alias: String) -> Storefront.Customer? {
			return internalGetCustomer(alias: alias)
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.Customer?
		}

		/// Returns the shop's localization settings. Use this query to build [country
		/// and language
		/// selectors](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/markets)
		/// for your storefront. The
		/// [`country`](https://shopify.dev/docs/api/storefront/latest/queries/localization#returns-Localization.fields.country)
		/// and
		/// [`language`](https://shopify.dev/docs/api/storefront/latest/queries/localization#returns-Localization.fields.language)
		/// fields reflect the active localized experience. To change the context, use
		/// the [`@inContext`](https://shopify.dev/docs/api/storefront#directives)
		/// directive with your desired country or language code.
		open var localization: Storefront.Localization {
			return internalGetLocalization()
		}

		func internalGetLocalization(alias: String? = nil) -> Storefront.Localization {
			return field(field: "localization", aliasSuffix: alias) as! Storefront.Localization
		}

		/// Returns shop locations that support in-store pickup. Use the `near`
		/// argument with
		/// [`GeoCoordinateInput`](https://shopify.dev/docs/api/storefront/current/input-objects/GeoCoordinateInput)
		/// to sort results by proximity to the customer's location. When sorting by
		/// distance, set `sortKey` to
		/// [`DISTANCE`](https://shopify.dev/docs/api/storefront/current/queries/locations#arguments-sortKey.enums.DISTANCE)
		/// and provide coordinates using the
		/// [`near`](https://shopify.dev/docs/api/storefront/current/queries/locations#arguments-near)
		/// argument. Learn more about [supporting local pickup on
		/// storefronts](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/local-pickup).
		open var locations: Storefront.LocationConnection {
			return internalGetLocations()
		}

		open func aliasedLocations(alias: String) -> Storefront.LocationConnection {
			return internalGetLocations(alias: alias)
		}

		func internalGetLocations(alias: String? = nil) -> Storefront.LocationConnection {
			return field(field: "locations", aliasSuffix: alias) as! Storefront.LocationConnection
		}

		/// Retrieves a
		/// [`Menu`](https://shopify.dev/docs/api/storefront/current/objects/Menu) by
		/// its handle. Menus are [hierarchical navigation
		/// structures](https://help.shopify.com/manual/online-store/menus-and-links)
		/// that merchants configure for their storefront, such as header and footer
		/// navigation. Each menu contains
		/// [`MenuItem`](https://shopify.dev/docs/api/storefront/current/objects/MenuItem)
		/// objects that can nest up to three levels deep, with each item linking to
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [pages](https://shopify.dev/docs/api/storefront/current/objects/Page),
		/// [blogs](https://shopify.dev/docs/api/storefront/current/objects/Blog), or
		/// external URLs.
		open var menu: Storefront.Menu? {
			return internalGetMenu()
		}

		open func aliasedMenu(alias: String) -> Storefront.Menu? {
			return internalGetMenu(alias: alias)
		}

		func internalGetMenu(alias: String? = nil) -> Storefront.Menu? {
			return field(field: "menu", aliasSuffix: alias) as! Storefront.Menu?
		}

		/// Retrieves a single
		/// [`Metaobject`](https://shopify.dev/docs/api/storefront/current/objects/Metaobject)
		/// by either its [`global
		/// ID`](https://shopify.dev/docs/api/storefront/current/queries/metaobject#arguments-id)
		/// or its
		/// [`handle`](https://shopify.dev/docs/api/storefront/current/queries/metaobject#arguments-handle).
		/// > Note: > When using the handle, you must also provide the metaobject type
		/// because handles are only unique within a type.
		open var metaobject: Storefront.Metaobject? {
			return internalGetMetaobject()
		}

		open func aliasedMetaobject(alias: String) -> Storefront.Metaobject? {
			return internalGetMetaobject(alias: alias)
		}

		func internalGetMetaobject(alias: String? = nil) -> Storefront.Metaobject? {
			return field(field: "metaobject", aliasSuffix: alias) as! Storefront.Metaobject?
		}

		/// Returns a paginated list of
		/// [`Metaobject`](https://shopify.dev/docs/api/storefront/current/objects/Metaobject)
		/// entries for a specific type. Metaobjects are [custom data
		/// structures](https://shopify.dev/docs/apps/build/metaobjects) that extend
		/// Shopify's data model with merchant-defined or app-defined content like size
		/// charts, product highlights, or custom sections. The required `type`
		/// argument specifies which metaobject type to retrieve. You can sort results
		/// by `id` or `updated_at` using the `sortKey` argument.
		open var metaobjects: Storefront.MetaobjectConnection {
			return internalGetMetaobjects()
		}

		open func aliasedMetaobjects(alias: String) -> Storefront.MetaobjectConnection {
			return internalGetMetaobjects(alias: alias)
		}

		func internalGetMetaobjects(alias: String? = nil) -> Storefront.MetaobjectConnection {
			return field(field: "metaobjects", aliasSuffix: alias) as! Storefront.MetaobjectConnection
		}

		/// Retrieves any object that implements the
		/// [`Node`](https://shopify.dev/docs/api/storefront/current/interfaces/Node)
		/// interface by its globally-unique ID. Use inline fragments to access
		/// type-specific fields on the returned object. This query follows the [Relay
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface)
		/// and is commonly used for refetching objects when you have their ID but need
		/// updated data.
		open var node: Node? {
			return internalGetNode()
		}

		open func aliasedNode(alias: String) -> Node? {
			return internalGetNode(alias: alias)
		}

		func internalGetNode(alias: String? = nil) -> Node? {
			return field(field: "node", aliasSuffix: alias) as! Node?
		}

		/// Retrieves multiple objects by their global IDs in a single request. Any
		/// object that implements the
		/// [`Node`](https://shopify.dev/docs/api/storefront/current/interfaces/Node)
		/// interface can be fetched, including
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// and [pages](https://shopify.dev/docs/api/storefront/current/objects/Page).
		/// Use inline fragments to access type-specific fields on the returned
		/// objects. The input accepts up to 250 IDs.
		open var nodes: [Node?] {
			return internalGetNodes()
		}

		open func aliasedNodes(alias: String) -> [Node?] {
			return internalGetNodes(alias: alias)
		}

		func internalGetNodes(alias: String? = nil) -> [Node?] {
			return field(field: "nodes", aliasSuffix: alias) as! [Node?]
		}

		/// Retrieves a
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page) by
		/// its
		/// [`handle`](https://shopify.dev/docs/api/storefront/current/queries/page#arguments-handle)
		/// or
		/// [`id`](https://shopify.dev/docs/api/storefront/current/queries/page#arguments-id).
		/// Pages are static content pages that merchants display outside their product
		/// catalog, such as "About Us," "Contact," or policy pages. The returned page
		/// includes information such as the [HTML body
		/// content](https://shopify.dev/docs/api/storefront/current/queries/page#returns-Page.fields.body),
		/// [`SEO`](https://shopify.dev/docs/api/storefront/current/objects/SEO)
		/// information, and any associated
		/// [`Metafield`](https://shopify.dev/docs/api/storefront/current/objects/Metafield)
		/// objects.
		open var page: Storefront.Page? {
			return internalGetPage()
		}

		open func aliasedPage(alias: String) -> Storefront.Page? {
			return internalGetPage(alias: alias)
		}

		func internalGetPage(alias: String? = nil) -> Storefront.Page? {
			return field(field: "page", aliasSuffix: alias) as! Storefront.Page?
		}

		/// Retrieves a
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page) by
		/// its handle.
		@available(*, deprecated, message: "Use `page` instead.")
		open var pageByHandle: Storefront.Page? {
			return internalGetPageByHandle()
		}

		@available(*, deprecated, message: "Use `page` instead.")

		open func aliasedPageByHandle(alias: String) -> Storefront.Page? {
			return internalGetPageByHandle(alias: alias)
		}

		func internalGetPageByHandle(alias: String? = nil) -> Storefront.Page? {
			return field(field: "pageByHandle", aliasSuffix: alias) as! Storefront.Page?
		}

		/// Returns a paginated list of the shop's content
		/// [pages](https://shopify.dev/docs/api/storefront/current/objects/Page).
		/// Pages are custom HTML content like "About Us", "Contact", or policy
		/// information that merchants display outside their product catalog.
		open var pages: Storefront.PageConnection {
			return internalGetPages()
		}

		open func aliasedPages(alias: String) -> Storefront.PageConnection {
			return internalGetPages(alias: alias)
		}

		func internalGetPages(alias: String? = nil) -> Storefront.PageConnection {
			return field(field: "pages", aliasSuffix: alias) as! Storefront.PageConnection
		}

		/// Settings related to payments.
		open var paymentSettings: Storefront.PaymentSettings {
			return internalGetPaymentSettings()
		}

		func internalGetPaymentSettings(alias: String? = nil) -> Storefront.PaymentSettings {
			return field(field: "paymentSettings", aliasSuffix: alias) as! Storefront.PaymentSettings
		}

		/// Returns suggested results as customers type in a search field, enabling
		/// type-ahead search experiences. The query matches
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [collections](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// [pages](https://shopify.dev/docs/api/storefront/current/objects/Page), and
		/// [articles](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// based on partial search terms, and also provides [search query
		/// suggestions](https://shopify.dev/docs/api/storefront/current/objects/SearchQuerySuggestion)
		/// to help customers refine their search. You can filter results by resource
		/// type and limit the quantity. The
		/// [`limitScope`](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch#arguments-limitScope)
		/// argument controls whether limits apply across all result types or per type.
		/// Use
		/// [`unavailableProducts`](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch#arguments-unavailableProducts)
		/// to control how out-of-stock products appear in results.
		open var predictiveSearch: Storefront.PredictiveSearchResult? {
			return internalGetPredictiveSearch()
		}

		open func aliasedPredictiveSearch(alias: String) -> Storefront.PredictiveSearchResult? {
			return internalGetPredictiveSearch(alias: alias)
		}

		func internalGetPredictiveSearch(alias: String? = nil) -> Storefront.PredictiveSearchResult? {
			return field(field: "predictiveSearch", aliasSuffix: alias) as! Storefront.PredictiveSearchResult?
		}

		/// Retrieves a single
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// by its ID or handle. Use this query to build product detail pages, access
		/// variant and pricing information, or fetch product media and
		/// [metafields](https://shopify.dev/docs/api/storefront/current/objects/Metafield).
		/// See some [examples of querying
		/// products](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/getting-started).
		open var product: Storefront.Product? {
			return internalGetProduct()
		}

		open func aliasedProduct(alias: String) -> Storefront.Product? {
			return internalGetProduct(alias: alias)
		}

		func internalGetProduct(alias: String? = nil) -> Storefront.Product? {
			return field(field: "product", aliasSuffix: alias) as! Storefront.Product?
		}

		/// Retrieves a
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// by its handle. The handle is a URL-friendly identifier that's automatically
		/// generated from the product's title. If no product exists with the specified
		/// handle, returns `null`.
		@available(*, deprecated, message: "Use `product` instead.")
		open var productByHandle: Storefront.Product? {
			return internalGetProductByHandle()
		}

		@available(*, deprecated, message: "Use `product` instead.")

		open func aliasedProductByHandle(alias: String) -> Storefront.Product? {
			return internalGetProductByHandle(alias: alias)
		}

		func internalGetProductByHandle(alias: String? = nil) -> Storefront.Product? {
			return field(field: "productByHandle", aliasSuffix: alias) as! Storefront.Product?
		}

		/// Returns recommended products for a given product, identified by either ID
		/// or handle. Use the
		/// [`intent`](https://shopify.dev/docs/api/storefront/current/enums/ProductRecommendationIntent)
		/// argument to control the recommendation strategy. Shopify [auto-generates
		/// related
		/// recommendations](https://shopify.dev/docs/storefronts/themes/product-merchandising/recommendations)
		/// based on sales data, product descriptions, and collection relationships.
		/// Complementary recommendations require [manual
		/// configuration](https://help.shopify.com/manual/online-store/storefront-search/search-and-discovery-recommendations)
		/// through the Shopify Search & Discovery app. Returns up to ten
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// objects.
		open var productRecommendations: [Storefront.Product]? {
			return internalGetProductRecommendations()
		}

		open func aliasedProductRecommendations(alias: String) -> [Storefront.Product]? {
			return internalGetProductRecommendations(alias: alias)
		}

		func internalGetProductRecommendations(alias: String? = nil) -> [Storefront.Product]? {
			return field(field: "productRecommendations", aliasSuffix: alias) as! [Storefront.Product]?
		}

		/// Returns a paginated list of all tags that have been added to
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// in the shop. Useful for building tag-based product filtering or navigation
		/// in a storefront.
		open var productTags: Storefront.StringConnection {
			return internalGetProductTags()
		}

		open func aliasedProductTags(alias: String) -> Storefront.StringConnection {
			return internalGetProductTags(alias: alias)
		}

		func internalGetProductTags(alias: String? = nil) -> Storefront.StringConnection {
			return field(field: "productTags", aliasSuffix: alias) as! Storefront.StringConnection
		}

		/// Returns a list of product types from the shop's
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product)
		/// objects that are published to your app. Use this query to build [filtering
		/// interfaces](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/filter-products)
		/// or navigation menus based on product categorization.
		open var productTypes: Storefront.StringConnection {
			return internalGetProductTypes()
		}

		open func aliasedProductTypes(alias: String) -> Storefront.StringConnection {
			return internalGetProductTypes(alias: alias)
		}

		func internalGetProductTypes(alias: String? = nil) -> Storefront.StringConnection {
			return field(field: "productTypes", aliasSuffix: alias) as! Storefront.StringConnection
		}

		/// Returns a paginated list of the shop's
		/// [products](https://shopify.dev/docs/api/storefront/current/objects/Product).
		/// For full-text storefront search, use the
		/// [`search`](https://shopify.dev/docs/api/storefront/current/queries/search)
		/// query instead.
		open var products: Storefront.ProductConnection {
			return internalGetProducts()
		}

		open func aliasedProducts(alias: String) -> Storefront.ProductConnection {
			return internalGetProducts(alias: alias)
		}

		func internalGetProducts(alias: String? = nil) -> Storefront.ProductConnection {
			return field(field: "products", aliasSuffix: alias) as! Storefront.ProductConnection
		}

		/// Returns all public Storefront [API
		/// versions](https://shopify.dev/docs/api/storefront/current/objects/ApiVersion),
		/// including supported, release candidate, and unstable versions.
		open var publicApiVersions: [Storefront.ApiVersion] {
			return internalGetPublicApiVersions()
		}

		func internalGetPublicApiVersions(alias: String? = nil) -> [Storefront.ApiVersion] {
			return field(field: "publicApiVersions", aliasSuffix: alias) as! [Storefront.ApiVersion]
		}

		/// Returns paginated search results for
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page), and
		/// [`Article`](https://shopify.dev/docs/api/storefront/current/objects/Article)
		/// resources based on a query string. Results are sorted by relevance by
		/// default. The response includes the total result count and available product
		/// filters for building [faceted search
		/// interfaces](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/products-collections/filter-products).
		/// Use the
		/// [`prefix`](https://shopify.dev/docs/api/storefront/current/enums/SearchPrefixQueryType)
		/// argument to enable partial word matching on the last search term, allowing
		/// queries like "winter snow" to match "snowboard" or "snowshoe".
		open var search: Storefront.SearchResultItemConnection {
			return internalGetSearch()
		}

		open func aliasedSearch(alias: String) -> Storefront.SearchResultItemConnection {
			return internalGetSearch(alias: alias)
		}

		func internalGetSearch(alias: String? = nil) -> Storefront.SearchResultItemConnection {
			return field(field: "search", aliasSuffix: alias) as! Storefront.SearchResultItemConnection
		}

		/// Returns the
		/// [`Shop`](https://shopify.dev/docs/api/storefront/current/objects/Shop)
		/// associated with the storefront access token. The `Shop` object provides
		/// general store information such as the shop name, description, and primary
		/// domain. Use this query to access data like store policies,
		/// [`PaymentSettings`](https://shopify.dev/docs/api/storefront/current/objects/PaymentSettings),
		/// [`Brand`](https://shopify.dev/docs/api/storefront/current/objects/Brand)
		/// configuration, and shipping destinations. It also exposes
		/// [`ShopPayInstallmentsPricing`](https://shopify.dev/docs/api/storefront/current/objects/ShopPayInstallmentsPricing)
		/// and
		/// [`SocialLoginProvider`](https://shopify.dev/docs/api/storefront/current/objects/SocialLoginProvider)
		/// options for customer accounts.
		open var shop: Storefront.Shop {
			return internalGetShop()
		}

		func internalGetShop(alias: String? = nil) -> Storefront.Shop {
			return field(field: "shop", aliasSuffix: alias) as! Storefront.Shop
		}

		/// Returns sitemap data for a specific resource type, enabling headless
		/// storefronts to generate XML sitemaps for search engine optimization. The
		/// query provides a page count and paginated access to resources like
		/// [`Product`](https://shopify.dev/docs/api/storefront/current/objects/Product),
		/// [`Collection`](https://shopify.dev/docs/api/storefront/current/objects/Collection),
		/// [`Page`](https://shopify.dev/docs/api/storefront/current/objects/Page), and
		/// [`Blog`](https://shopify.dev/docs/api/storefront/current/objects/Blog)
		/// objects. When paginating through resources, the number of items per page
		/// varies from 0 to 250, and empty pages can occur without indicating the end
		/// of results. Always check
		/// [`hasNextPage`](https://shopify.dev/docs/api/storefront/current/objects/PaginatedSitemapResources#field-PaginatedSitemapResources.fields.hasNextPage)
		/// to determine if more pages are available.
		open var sitemap: Storefront.Sitemap {
			return internalGetSitemap()
		}

		open func aliasedSitemap(alias: String) -> Storefront.Sitemap {
			return internalGetSitemap(alias: alias)
		}

		func internalGetSitemap(alias: String? = nil) -> Storefront.Sitemap {
			return field(field: "sitemap", aliasSuffix: alias) as! Storefront.Sitemap
		}

		/// Returns a paginated list of
		/// [`UrlRedirect`](https://shopify.dev/docs/api/storefront/current/objects/UrlRedirect)
		/// objects configured for the shop. Each redirect maps an old path to a target
		/// location.
		open var urlRedirects: Storefront.UrlRedirectConnection {
			return internalGetUrlRedirects()
		}

		open func aliasedUrlRedirects(alias: String) -> Storefront.UrlRedirectConnection {
			return internalGetUrlRedirects(alias: alias)
		}

		func internalGetUrlRedirects(alias: String? = nil) -> Storefront.UrlRedirectConnection {
			return field(field: "urlRedirects", aliasSuffix: alias) as! Storefront.UrlRedirectConnection
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "article":
					if let value = internalGetArticle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "articles":
					response.append(internalGetArticles())
					response.append(contentsOf: internalGetArticles().childResponseObjectMap())

					case "blog":
					if let value = internalGetBlog() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "blogByHandle":
					if let value = internalGetBlogByHandle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "blogs":
					response.append(internalGetBlogs())
					response.append(contentsOf: internalGetBlogs().childResponseObjectMap())

					case "cart":
					if let value = internalGetCart() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartCompletionAttempt":
					if let value = internalGetCartCompletionAttempt() {
						response.append((value as! GraphQL.AbstractResponse))
						response.append(contentsOf: (value as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

					case "collection":
					if let value = internalGetCollection() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "collectionByHandle":
					if let value = internalGetCollectionByHandle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "collections":
					response.append(internalGetCollections())
					response.append(contentsOf: internalGetCollections().childResponseObjectMap())

					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "localization":
					response.append(internalGetLocalization())
					response.append(contentsOf: internalGetLocalization().childResponseObjectMap())

					case "locations":
					response.append(internalGetLocations())
					response.append(contentsOf: internalGetLocations().childResponseObjectMap())

					case "menu":
					if let value = internalGetMenu() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metaobject":
					if let value = internalGetMetaobject() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metaobjects":
					response.append(internalGetMetaobjects())
					response.append(contentsOf: internalGetMetaobjects().childResponseObjectMap())

					case "node":
					if let value = internalGetNode() {
						response.append((value as! GraphQL.AbstractResponse))
						response.append(contentsOf: (value as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

					case "nodes":
					internalGetNodes().forEach {
						if let value = $0 {
							response.append((value as! GraphQL.AbstractResponse))
							response.append(contentsOf: (value as! GraphQL.AbstractResponse).childResponseObjectMap())
						}
					}

					case "page":
					if let value = internalGetPage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "pageByHandle":
					if let value = internalGetPageByHandle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "pages":
					response.append(internalGetPages())
					response.append(contentsOf: internalGetPages().childResponseObjectMap())

					case "paymentSettings":
					response.append(internalGetPaymentSettings())
					response.append(contentsOf: internalGetPaymentSettings().childResponseObjectMap())

					case "predictiveSearch":
					if let value = internalGetPredictiveSearch() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "product":
					if let value = internalGetProduct() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "productByHandle":
					if let value = internalGetProductByHandle() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "productRecommendations":
					if let value = internalGetProductRecommendations() {
						value.forEach {
							response.append($0)
							response.append(contentsOf: $0.childResponseObjectMap())
						}
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

					case "publicApiVersions":
					internalGetPublicApiVersions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "search":
					response.append(internalGetSearch())
					response.append(contentsOf: internalGetSearch().childResponseObjectMap())

					case "shop":
					response.append(internalGetShop())
					response.append(contentsOf: internalGetShop().childResponseObjectMap())

					case "sitemap":
					response.append(internalGetSitemap())
					response.append(contentsOf: internalGetSitemap().childResponseObjectMap())

					case "urlRedirects":
					response.append(internalGetUrlRedirects())
					response.append(contentsOf: internalGetUrlRedirects().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

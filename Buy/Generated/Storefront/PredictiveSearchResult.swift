//
//  PredictiveSearchResult.swift
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
	/// A predictive search result represents a list of products, collections, 
	/// pages, articles, and query suggestions that matches the predictive search 
	/// query. 
	open class PredictiveSearchResultQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PredictiveSearchResult

		/// The articles that match the search query. 
		@discardableResult
		open func articles(alias: String? = nil, _ subfields: (ArticleQuery) -> Void) -> PredictiveSearchResultQuery {
			let subquery = ArticleQuery()
			subfields(subquery)

			addField(field: "articles", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The articles that match the search query. 
		@discardableResult
		open func collections(alias: String? = nil, _ subfields: (CollectionQuery) -> Void) -> PredictiveSearchResultQuery {
			let subquery = CollectionQuery()
			subfields(subquery)

			addField(field: "collections", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The pages that match the search query. 
		@discardableResult
		open func pages(alias: String? = nil, _ subfields: (PageQuery) -> Void) -> PredictiveSearchResultQuery {
			let subquery = PageQuery()
			subfields(subquery)

			addField(field: "pages", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The products that match the search query. 
		@discardableResult
		open func products(alias: String? = nil, _ subfields: (ProductQuery) -> Void) -> PredictiveSearchResultQuery {
			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "products", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The query suggestions that are relevant to the search query. 
		@discardableResult
		open func queries(alias: String? = nil, _ subfields: (SearchQuerySuggestionQuery) -> Void) -> PredictiveSearchResultQuery {
			let subquery = SearchQuerySuggestionQuery()
			subfields(subquery)

			addField(field: "queries", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// A predictive search result represents a list of products, collections, 
	/// pages, articles, and query suggestions that matches the predictive search 
	/// query. 
	open class PredictiveSearchResult: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = PredictiveSearchResultQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "articles":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: PredictiveSearchResult.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Article(fields: $0) }

				case "collections":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: PredictiveSearchResult.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Collection(fields: $0) }

				case "pages":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: PredictiveSearchResult.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Page(fields: $0) }

				case "products":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: PredictiveSearchResult.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Product(fields: $0) }

				case "queries":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: PredictiveSearchResult.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SearchQuerySuggestion(fields: $0) }

				default:
				throw SchemaViolationError(type: PredictiveSearchResult.self, field: fieldName, value: fieldValue)
			}
		}

		/// The articles that match the search query. 
		open var articles: [Storefront.Article] {
			return internalGetArticles()
		}

		func internalGetArticles(alias: String? = nil) -> [Storefront.Article] {
			return field(field: "articles", aliasSuffix: alias) as! [Storefront.Article]
		}

		/// The articles that match the search query. 
		open var collections: [Storefront.Collection] {
			return internalGetCollections()
		}

		func internalGetCollections(alias: String? = nil) -> [Storefront.Collection] {
			return field(field: "collections", aliasSuffix: alias) as! [Storefront.Collection]
		}

		/// The pages that match the search query. 
		open var pages: [Storefront.Page] {
			return internalGetPages()
		}

		func internalGetPages(alias: String? = nil) -> [Storefront.Page] {
			return field(field: "pages", aliasSuffix: alias) as! [Storefront.Page]
		}

		/// The products that match the search query. 
		open var products: [Storefront.Product] {
			return internalGetProducts()
		}

		func internalGetProducts(alias: String? = nil) -> [Storefront.Product] {
			return field(field: "products", aliasSuffix: alias) as! [Storefront.Product]
		}

		/// The query suggestions that are relevant to the search query. 
		open var queries: [Storefront.SearchQuerySuggestion] {
			return internalGetQueries()
		}

		func internalGetQueries(alias: String? = nil) -> [Storefront.SearchQuerySuggestion] {
			return field(field: "queries", aliasSuffix: alias) as! [Storefront.SearchQuerySuggestion]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

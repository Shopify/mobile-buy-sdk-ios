//
//  SearchResultItem.swift
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

/// A search result that matches the search query. 
public protocol SearchResultItem {
}

extension Storefront {
	/// A search result that matches the search query. 
	open class SearchResultItemQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SearchResultItem

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// A search result that matches the search query. 
		@discardableResult
		open func onArticle(subfields: (ArticleQuery) -> Void) -> SearchResultItemQuery {
			let subquery = ArticleQuery()
			subfields(subquery)
			addInlineFragment(on: "Article", subfields: subquery)
			return self
		}

		/// A search result that matches the search query. 
		@discardableResult
		open func onPage(subfields: (PageQuery) -> Void) -> SearchResultItemQuery {
			let subquery = PageQuery()
			subfields(subquery)
			addInlineFragment(on: "Page", subfields: subquery)
			return self
		}

		/// A search result that matches the search query. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> SearchResultItemQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}
	}

	/// A search result that matches the search query. 
	open class UnknownSearchResultItem: GraphQL.AbstractResponse, GraphQLObject, SearchResultItem {
		public typealias Query = SearchResultItemQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownSearchResultItem.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> SearchResultItem {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownSearchResultItem.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Article": return try Article.init(fields: fields)

				case "Page": return try Page.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				default:
				return try UnknownSearchResultItem.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

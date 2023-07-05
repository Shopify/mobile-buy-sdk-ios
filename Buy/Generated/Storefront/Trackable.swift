//
//  Trackable.swift
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

/// Represents a resource that you can track the origin of the search traffic. 
public protocol Trackable {
	var trackingParameters: String? { get }
}

extension Storefront {
	/// Represents a resource that you can track the origin of the search traffic. 
	open class TrackableQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Trackable

		/// A URL parameters to be added to a page URL when it is linked from a GraphQL 
		/// result. This allows for tracking the origin of the traffic. 
		@discardableResult
		open func trackingParameters(alias: String? = nil) -> TrackableQuery {
			addField(field: "trackingParameters", aliasSuffix: alias)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents a resource that you can track the origin of the search traffic. 
		@discardableResult
		open func onArticle(subfields: (ArticleQuery) -> Void) -> TrackableQuery {
			let subquery = ArticleQuery()
			subfields(subquery)
			addInlineFragment(on: "Article", subfields: subquery)
			return self
		}

		/// Represents a resource that you can track the origin of the search traffic. 
		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> TrackableQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		/// Represents a resource that you can track the origin of the search traffic. 
		@discardableResult
		open func onPage(subfields: (PageQuery) -> Void) -> TrackableQuery {
			let subquery = PageQuery()
			subfields(subquery)
			addInlineFragment(on: "Page", subfields: subquery)
			return self
		}

		/// Represents a resource that you can track the origin of the search traffic. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> TrackableQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		/// Represents a resource that you can track the origin of the search traffic. 
		@discardableResult
		open func onSearchQuerySuggestion(subfields: (SearchQuerySuggestionQuery) -> Void) -> TrackableQuery {
			let subquery = SearchQuerySuggestionQuery()
			subfields(subquery)
			addInlineFragment(on: "SearchQuerySuggestion", subfields: subquery)
			return self
		}
	}

	/// Represents a resource that you can track the origin of the search traffic. 
	open class UnknownTrackable: GraphQL.AbstractResponse, GraphQLObject, Trackable {
		public typealias Query = TrackableQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "trackingParameters":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownTrackable.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: UnknownTrackable.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> Trackable {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownTrackable.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Article": return try Article.init(fields: fields)

				case "Collection": return try Collection.init(fields: fields)

				case "Page": return try Page.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				case "SearchQuerySuggestion": return try SearchQuerySuggestion.init(fields: fields)

				default:
				return try UnknownTrackable.init(fields: fields)
			}
		}

		/// A URL parameters to be added to a page URL when it is linked from a GraphQL 
		/// result. This allows for tracking the origin of the traffic. 
		open var trackingParameters: String? {
			return internalGetTrackingParameters()
		}

		func internalGetTrackingParameters(alias: String? = nil) -> String? {
			return field(field: "trackingParameters", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

//
//  SearchQuerySuggestion.swift
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
	/// A search query suggestion. 
	open class SearchQuerySuggestionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SearchQuerySuggestion

		/// The text of the search query suggestion with highlighted HTML tags. 
		@discardableResult
		open func styledText(alias: String? = nil) -> SearchQuerySuggestionQuery {
			addField(field: "styledText", aliasSuffix: alias)
			return self
		}

		/// The text of the search query suggestion. 
		@discardableResult
		open func text(alias: String? = nil) -> SearchQuerySuggestionQuery {
			addField(field: "text", aliasSuffix: alias)
			return self
		}

		/// URL parameters to be added to a page URL to track the origin of on-site 
		/// search traffic for [analytics 
		/// reporting](https://help.shopify.com/manual/reports-and-analytics/shopify-reports/report-types/default-reports/behaviour-reports). 
		/// Returns a result when accessed through the 
		/// [search](https://shopify.dev/docs/api/storefront/current/queries/search) or 
		/// [predictiveSearch](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch) 
		/// queries, otherwise returns null. 
		@discardableResult
		open func trackingParameters(alias: String? = nil) -> SearchQuerySuggestionQuery {
			addField(field: "trackingParameters", aliasSuffix: alias)
			return self
		}
	}

	/// A search query suggestion. 
	open class SearchQuerySuggestion: GraphQL.AbstractResponse, GraphQLObject, Trackable {
		public typealias Query = SearchQuerySuggestionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "styledText":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SearchQuerySuggestion.self, field: fieldName, value: fieldValue)
				}
				return value

				case "text":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SearchQuerySuggestion.self, field: fieldName, value: fieldValue)
				}
				return value

				case "trackingParameters":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SearchQuerySuggestion.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: SearchQuerySuggestion.self, field: fieldName, value: fieldValue)
			}
		}

		/// The text of the search query suggestion with highlighted HTML tags. 
		open var styledText: String {
			return internalGetStyledText()
		}

		func internalGetStyledText(alias: String? = nil) -> String {
			return field(field: "styledText", aliasSuffix: alias) as! String
		}

		/// The text of the search query suggestion. 
		open var text: String {
			return internalGetText()
		}

		func internalGetText(alias: String? = nil) -> String {
			return field(field: "text", aliasSuffix: alias) as! String
		}

		/// URL parameters to be added to a page URL to track the origin of on-site 
		/// search traffic for [analytics 
		/// reporting](https://help.shopify.com/manual/reports-and-analytics/shopify-reports/report-types/default-reports/behaviour-reports). 
		/// Returns a result when accessed through the 
		/// [search](https://shopify.dev/docs/api/storefront/current/queries/search) or 
		/// [predictiveSearch](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch) 
		/// queries, otherwise returns null. 
		open var trackingParameters: String? {
			return internalGetTrackingParameters()
		}

		func internalGetTrackingParameters(alias: String? = nil) -> String? {
			return field(field: "trackingParameters", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

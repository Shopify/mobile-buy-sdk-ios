//
//  MediaEdge.swift
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
	/// An auto-generated type which holds one Media and a cursor during 
	/// pagination. 
	open class MediaEdgeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MediaEdge

		/// A cursor for use in pagination. 
		@discardableResult
		open func cursor(alias: String? = nil) -> MediaEdgeQuery {
			addField(field: "cursor", aliasSuffix: alias)
			return self
		}

		/// The item at the end of MediaEdge. 
		@discardableResult
		open func node(alias: String? = nil, _ subfields: (MediaQuery) -> Void) -> MediaEdgeQuery {
			let subquery = MediaQuery()
			subfields(subquery)

			addField(field: "node", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// An auto-generated type which holds one Media and a cursor during 
	/// pagination. 
	open class MediaEdge: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = MediaEdgeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cursor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MediaEdge.self, field: fieldName, value: fieldValue)
				}
				return value

				case "node":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MediaEdge.self, field: fieldName, value: fieldValue)
				}
				return try UnknownMedia.create(fields: value)

				default:
				throw SchemaViolationError(type: MediaEdge.self, field: fieldName, value: fieldValue)
			}
		}

		/// A cursor for use in pagination. 
		open var cursor: String {
			return internalGetCursor()
		}

		func internalGetCursor(alias: String? = nil) -> String {
			return field(field: "cursor", aliasSuffix: alias) as! String
		}

		/// The item at the end of MediaEdge. 
		open var node: Media {
			return internalGetNode()
		}

		func internalGetNode(alias: String? = nil) -> Media {
			return field(field: "node", aliasSuffix: alias) as! Media
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "node":
					response.append((internalGetNode() as! GraphQL.AbstractResponse))
					response.append(contentsOf: (internalGetNode() as! GraphQL.AbstractResponse).childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

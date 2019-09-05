//
//  DiscountApplicationEdge.swift
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
	open class DiscountApplicationEdgeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = DiscountApplicationEdge

		/// A cursor for use in pagination. 
		@discardableResult
		open func cursor(alias: String? = nil) -> DiscountApplicationEdgeQuery {
			addField(field: "cursor", aliasSuffix: alias)
			return self
		}

		/// The item at the end of DiscountApplicationEdge. 
		@discardableResult
		open func node(alias: String? = nil, _ subfields: (DiscountApplicationQuery) -> Void) -> DiscountApplicationEdgeQuery {
			let subquery = DiscountApplicationQuery()
			subfields(subquery)

			addField(field: "node", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	open class DiscountApplicationEdge: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = DiscountApplicationEdgeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cursor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: DiscountApplicationEdge.self, field: fieldName, value: fieldValue)
				}
				return value

				case "node":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: DiscountApplicationEdge.self, field: fieldName, value: fieldValue)
				}
				return try UnknownDiscountApplication.create(fields: value)

				default:
				throw SchemaViolationError(type: DiscountApplicationEdge.self, field: fieldName, value: fieldValue)
			}
		}

		/// A cursor for use in pagination. 
		open var cursor: String {
			return internalGetCursor()
		}

		func internalGetCursor(alias: String? = nil) -> String {
			return field(field: "cursor", aliasSuffix: alias) as! String
		}

		/// The item at the end of DiscountApplicationEdge. 
		open var node: DiscountApplication {
			return internalGetNode()
		}

		func internalGetNode(alias: String? = nil) -> DiscountApplication {
			return field(field: "node", aliasSuffix: alias) as! DiscountApplication
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
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

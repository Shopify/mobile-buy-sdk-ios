//
//  Count.swift
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
	/// Details for count of elements. 
	open class CountQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Count

		/// Count of elements. 
		@discardableResult
		open func count(alias: String? = nil) -> CountQuery {
			addField(field: "count", aliasSuffix: alias)
			return self
		}

		/// Precision of count, how exact is the value. 
		@discardableResult
		open func precision(alias: String? = nil) -> CountQuery {
			addField(field: "precision", aliasSuffix: alias)
			return self
		}
	}

	/// Details for count of elements. 
	open class Count: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CountQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "count":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: Count.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "precision":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Count.self, field: fieldName, value: fieldValue)
				}
				return CountPrecision(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: Count.self, field: fieldName, value: fieldValue)
			}
		}

		/// Count of elements. 
		open var count: Int32 {
			return internalGetCount()
		}

		func internalGetCount(alias: String? = nil) -> Int32 {
			return field(field: "count", aliasSuffix: alias) as! Int32
		}

		/// Precision of count, how exact is the value. 
		open var precision: Storefront.CountPrecision {
			return internalGetPrecision()
		}

		func internalGetPrecision(alias: String? = nil) -> Storefront.CountPrecision {
			return field(field: "precision", aliasSuffix: alias) as! Storefront.CountPrecision
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

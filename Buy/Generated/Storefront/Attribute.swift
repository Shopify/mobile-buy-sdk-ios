//
//  Attribute.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// Represents a generic custom attribute, such as whether an order is a 
	/// customer's first. 
	open class AttributeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Attribute

		/// The key or name of the attribute. For example, `"customersFirstOrder"`. 
		@discardableResult
		open func key(alias: String? = nil) -> AttributeQuery {
			addField(field: "key", aliasSuffix: alias)
			return self
		}

		/// The value of the attribute. For example, `"true"`. 
		@discardableResult
		open func value(alias: String? = nil) -> AttributeQuery {
			addField(field: "value", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a generic custom attribute, such as whether an order is a 
	/// customer's first. 
	open class Attribute: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = AttributeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "key":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Attribute.self, field: fieldName, value: fieldValue)
				}
				return value

				case "value":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Attribute.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Attribute.self, field: fieldName, value: fieldValue)
			}
		}

		/// The key or name of the attribute. For example, `"customersFirstOrder"`. 
		open var key: String {
			return internalGetKey()
		}

		func internalGetKey(alias: String? = nil) -> String {
			return field(field: "key", aliasSuffix: alias) as! String
		}

		/// The value of the attribute. For example, `"true"`. 
		open var value: String? {
			return internalGetValue()
		}

		func internalGetValue(alias: String? = nil) -> String? {
			return field(field: "value", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

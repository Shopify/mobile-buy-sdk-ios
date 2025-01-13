//
//  CartWarning.swift
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
	/// A warning that occurred during a cart mutation. 
	open class CartWarningQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartWarning

		/// The code of the warning. 
		@discardableResult
		open func code(alias: String? = nil) -> CartWarningQuery {
			addField(field: "code", aliasSuffix: alias)
			return self
		}

		/// The message text of the warning. 
		@discardableResult
		open func message(alias: String? = nil) -> CartWarningQuery {
			addField(field: "message", aliasSuffix: alias)
			return self
		}

		/// The target of the warning. 
		@discardableResult
		open func target(alias: String? = nil) -> CartWarningQuery {
			addField(field: "target", aliasSuffix: alias)
			return self
		}
	}

	/// A warning that occurred during a cart mutation. 
	open class CartWarning: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartWarningQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "code":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartWarning.self, field: fieldName, value: fieldValue)
				}
				return CartWarningCode(rawValue: value) ?? .unknownValue

				case "message":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartWarning.self, field: fieldName, value: fieldValue)
				}
				return value

				case "target":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartWarning.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				default:
				throw SchemaViolationError(type: CartWarning.self, field: fieldName, value: fieldValue)
			}
		}

		/// The code of the warning. 
		open var code: Storefront.CartWarningCode {
			return internalGetCode()
		}

		func internalGetCode(alias: String? = nil) -> Storefront.CartWarningCode {
			return field(field: "code", aliasSuffix: alias) as! Storefront.CartWarningCode
		}

		/// The message text of the warning. 
		open var message: String {
			return internalGetMessage()
		}

		func internalGetMessage(alias: String? = nil) -> String {
			return field(field: "message", aliasSuffix: alias) as! String
		}

		/// The target of the warning. 
		open var target: GraphQL.ID {
			return internalGetTarget()
		}

		func internalGetTarget(alias: String? = nil) -> GraphQL.ID {
			return field(field: "target", aliasSuffix: alias) as! GraphQL.ID
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}

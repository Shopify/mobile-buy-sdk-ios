//
//  QuantityRule.swift
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
	/// The quantity rule for the product variant in a given context. 
	open class QuantityRuleQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = QuantityRule

		/// The value that specifies the quantity increment between minimum and maximum 
		/// of the rule. Only quantities divisible by this value will be considered 
		/// valid. The increment must be lower than or equal to the minimum and the 
		/// maximum, and both minimum and maximum must be divisible by this value. 
		@discardableResult
		open func increment(alias: String? = nil) -> QuantityRuleQuery {
			addField(field: "increment", aliasSuffix: alias)
			return self
		}

		/// An optional value that defines the highest allowed quantity purchased by 
		/// the customer. If defined, maximum must be lower than or equal to the 
		/// minimum and must be a multiple of the increment. 
		@discardableResult
		open func maximum(alias: String? = nil) -> QuantityRuleQuery {
			addField(field: "maximum", aliasSuffix: alias)
			return self
		}

		/// The value that defines the lowest allowed quantity purchased by the 
		/// customer. The minimum must be a multiple of the quantity rule's increment. 
		@discardableResult
		open func minimum(alias: String? = nil) -> QuantityRuleQuery {
			addField(field: "minimum", aliasSuffix: alias)
			return self
		}
	}

	/// The quantity rule for the product variant in a given context. 
	open class QuantityRule: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = QuantityRuleQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "increment":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: QuantityRule.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "maximum":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: QuantityRule.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "minimum":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: QuantityRule.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: QuantityRule.self, field: fieldName, value: fieldValue)
			}
		}

		/// The value that specifies the quantity increment between minimum and maximum 
		/// of the rule. Only quantities divisible by this value will be considered 
		/// valid. The increment must be lower than or equal to the minimum and the 
		/// maximum, and both minimum and maximum must be divisible by this value. 
		open var increment: Int32 {
			return internalGetIncrement()
		}

		func internalGetIncrement(alias: String? = nil) -> Int32 {
			return field(field: "increment", aliasSuffix: alias) as! Int32
		}

		/// An optional value that defines the highest allowed quantity purchased by 
		/// the customer. If defined, maximum must be lower than or equal to the 
		/// minimum and must be a multiple of the increment. 
		open var maximum: Int32? {
			return internalGetMaximum()
		}

		func internalGetMaximum(alias: String? = nil) -> Int32? {
			return field(field: "maximum", aliasSuffix: alias) as! Int32?
		}

		/// The value that defines the lowest allowed quantity purchased by the 
		/// customer. The minimum must be a multiple of the quantity rule's increment. 
		open var minimum: Int32 {
			return internalGetMinimum()
		}

		func internalGetMinimum(alias: String? = nil) -> Int32 {
			return field(field: "minimum", aliasSuffix: alias) as! Int32
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

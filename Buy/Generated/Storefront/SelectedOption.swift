//
//  SelectedOption.swift
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
	/// Custom properties that a shop owner can use to define product variants. 
	/// Multiple options can exist. Options are represented as: option1, option2, 
	/// option3, etc. 
	open class SelectedOptionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SelectedOption

		/// The product option’s name. 
		@discardableResult
		open func name(alias: String? = nil) -> SelectedOptionQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// The product option’s value. 
		@discardableResult
		open func value(alias: String? = nil) -> SelectedOptionQuery {
			addField(field: "value", aliasSuffix: alias)
			return self
		}
	}

	/// Custom properties that a shop owner can use to define product variants. 
	/// Multiple options can exist. Options are represented as: option1, option2, 
	/// option3, etc. 
	open class SelectedOption: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SelectedOptionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "value":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The product option’s name. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// The product option’s value. 
		open var value: String {
			return internalGetValue()
		}

		func internalGetValue(alias: String? = nil) -> String {
			return field(field: "value", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

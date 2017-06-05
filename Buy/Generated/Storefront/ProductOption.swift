//
//  ProductOption.swift
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
	/// Custom product property names like "Size", "Color", and "Material". 
	/// Products are based on permutations of these options. A product may have a 
	/// maximum of 3 options. 255 characters limit each. 
	open class ProductOptionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ProductOption

		@discardableResult
		open func id(alias: String? = nil) -> ProductOptionQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The product option’s name. 
		@discardableResult
		open func name(alias: String? = nil) -> ProductOptionQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// The corresponding value to the product option name. 
		@discardableResult
		open func values(alias: String? = nil) -> ProductOptionQuery {
			addField(field: "values", aliasSuffix: alias)
			return self
		}
	}

	/// Custom product property names like "Size", "Color", and "Material". 
	/// Products are based on permutations of these options. A product may have a 
	/// maximum of 3 options. 255 characters limit each. 
	open class ProductOption: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = ProductOptionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "values":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The product option’s name. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// The corresponding value to the product option name. 
		open var values: [String] {
			return internalGetValues()
		}

		func internalGetValues(alias: String? = nil) -> [String] {
			return field(field: "values", aliasSuffix: alias) as! [String]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

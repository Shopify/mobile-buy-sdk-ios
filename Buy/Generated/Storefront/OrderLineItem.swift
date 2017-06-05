//
//  OrderLineItem.swift
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
	/// Represents a single line in an order. There is one line item for each 
	/// distinct product variant. 
	open class OrderLineItemQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = OrderLineItem

		/// List of custom attributes associated to the line item. 
		@discardableResult
		open func customAttributes(alias: String? = nil, _ subfields: (AttributeQuery) -> Void) -> OrderLineItemQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "customAttributes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The number of products variants associated to the line item. 
		@discardableResult
		open func quantity(alias: String? = nil) -> OrderLineItemQuery {
			addField(field: "quantity", aliasSuffix: alias)
			return self
		}

		/// The title of the product combined with title of the variant. 
		@discardableResult
		open func title(alias: String? = nil) -> OrderLineItemQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The product variant object associated to the line item. 
		@discardableResult
		open func variant(alias: String? = nil, _ subfields: (ProductVariantQuery) -> Void) -> OrderLineItemQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "variant", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents a single line in an order. There is one line item for each 
	/// distinct product variant. 
	open class OrderLineItem: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = OrderLineItemQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "quantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "variant":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ProductVariant(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// List of custom attributes associated to the line item. 
		open var customAttributes: [Storefront.Attribute] {
			return internalGetCustomAttributes()
		}

		func internalGetCustomAttributes(alias: String? = nil) -> [Storefront.Attribute] {
			return field(field: "customAttributes", aliasSuffix: alias) as! [Storefront.Attribute]
		}

		/// The number of products variants associated to the line item. 
		open var quantity: Int32 {
			return internalGetQuantity()
		}

		func internalGetQuantity(alias: String? = nil) -> Int32 {
			return field(field: "quantity", aliasSuffix: alias) as! Int32
		}

		/// The title of the product combined with title of the variant. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The product variant object associated to the line item. 
		open var variant: Storefront.ProductVariant? {
			return internalGetVariant()
		}

		func internalGetVariant(alias: String? = nil) -> Storefront.ProductVariant? {
			return field(field: "variant", aliasSuffix: alias) as! Storefront.ProductVariant?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "customAttributes":
					internalGetCustomAttributes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "variant":
					if let value = internalGetVariant() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}

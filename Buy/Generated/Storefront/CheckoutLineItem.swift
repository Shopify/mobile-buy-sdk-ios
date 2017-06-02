//
//  CheckoutLineItem.swift
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
	/// A single line item in the checkout, grouped by variant and attributes. 
	open class CheckoutLineItemQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CheckoutLineItem

		/// Extra information in the form of an array of Key-Value pairs about the line 
		/// item. 
		@discardableResult
		open func customAttributes(alias: String? = nil, _ subfields: (AttributeQuery) -> Void) -> CheckoutLineItemQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "customAttributes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		@discardableResult
		open func id(alias: String? = nil) -> CheckoutLineItemQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The quantity of the line item. 
		@discardableResult
		open func quantity(alias: String? = nil) -> CheckoutLineItemQuery {
			addField(field: "quantity", aliasSuffix: alias)
			return self
		}

		/// Title of the line item. Defaults to the product's title. 
		@discardableResult
		open func title(alias: String? = nil) -> CheckoutLineItemQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// Product variant of the line item. 
		@discardableResult
		open func variant(alias: String? = nil, _ subfields: (ProductVariantQuery) -> Void) -> CheckoutLineItemQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "variant", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// A single line item in the checkout, grouped by variant and attributes. 
	open class CheckoutLineItem: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CheckoutLineItemQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

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

		/// Extra information in the form of an array of Key-Value pairs about the line 
		/// item. 
		open var customAttributes: [Storefront.Attribute] {
			return internalGetCustomAttributes()
		}

		func internalGetCustomAttributes(alias: String? = nil) -> [Storefront.Attribute] {
			return field(field: "customAttributes", aliasSuffix: alias) as! [Storefront.Attribute]
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The quantity of the line item. 
		open var quantity: Int32 {
			return internalGetQuantity()
		}

		func internalGetQuantity(alias: String? = nil) -> Int32 {
			return field(field: "quantity", aliasSuffix: alias) as! Int32
		}

		/// Title of the line item. Defaults to the product's title. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// Product variant of the line item. 
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

//
//  CartDeliveryOption.swift
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
	/// Information about a delivery option. 
	open class CartDeliveryOptionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartDeliveryOption

		/// The code of the delivery option. 
		@discardableResult
		open func code(alias: String? = nil) -> CartDeliveryOptionQuery {
			addField(field: "code", aliasSuffix: alias)
			return self
		}

		/// The method for the delivery option. 
		@discardableResult
		open func deliveryMethodType(alias: String? = nil) -> CartDeliveryOptionQuery {
			addField(field: "deliveryMethodType", aliasSuffix: alias)
			return self
		}

		/// The description of the delivery option. 
		@discardableResult
		open func description(alias: String? = nil) -> CartDeliveryOptionQuery {
			addField(field: "description", aliasSuffix: alias)
			return self
		}

		/// The estimated cost for the delivery option. 
		@discardableResult
		open func estimatedCost(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartDeliveryOptionQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "estimatedCost", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The unique identifier of the delivery option. 
		@discardableResult
		open func handle(alias: String? = nil) -> CartDeliveryOptionQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// The title of the delivery option. 
		@discardableResult
		open func title(alias: String? = nil) -> CartDeliveryOptionQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}
	}

	/// Information about a delivery option. 
	open class CartDeliveryOption: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartDeliveryOptionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "code":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartDeliveryOption.self, field: fieldName, value: fieldValue)
				}
				return value

				case "deliveryMethodType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartDeliveryOption.self, field: fieldName, value: fieldValue)
				}
				return DeliveryMethodType(rawValue: value) ?? .unknownValue

				case "description":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartDeliveryOption.self, field: fieldName, value: fieldValue)
				}
				return value

				case "estimatedCost":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartDeliveryOption.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartDeliveryOption.self, field: fieldName, value: fieldValue)
				}
				return value

				case "title":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartDeliveryOption.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartDeliveryOption.self, field: fieldName, value: fieldValue)
			}
		}

		/// The code of the delivery option. 
		open var code: String? {
			return internalGetCode()
		}

		func internalGetCode(alias: String? = nil) -> String? {
			return field(field: "code", aliasSuffix: alias) as! String?
		}

		/// The method for the delivery option. 
		open var deliveryMethodType: Storefront.DeliveryMethodType {
			return internalGetDeliveryMethodType()
		}

		func internalGetDeliveryMethodType(alias: String? = nil) -> Storefront.DeliveryMethodType {
			return field(field: "deliveryMethodType", aliasSuffix: alias) as! Storefront.DeliveryMethodType
		}

		/// The description of the delivery option. 
		open var description: String? {
			return internalGetDescription()
		}

		func internalGetDescription(alias: String? = nil) -> String? {
			return field(field: "description", aliasSuffix: alias) as! String?
		}

		/// The estimated cost for the delivery option. 
		open var estimatedCost: Storefront.MoneyV2 {
			return internalGetEstimatedCost()
		}

		func internalGetEstimatedCost(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "estimatedCost", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The unique identifier of the delivery option. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// The title of the delivery option. 
		open var title: String? {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String? {
			return field(field: "title", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "estimatedCost":
					response.append(internalGetEstimatedCost())
					response.append(contentsOf: internalGetEstimatedCost().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}

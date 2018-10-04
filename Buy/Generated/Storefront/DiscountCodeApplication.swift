//
//  DiscountCodeApplication.swift
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
	/// Discount code applications capture the intentions of a discount code at the 
	/// time that it is applied. 
	open class DiscountCodeApplicationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = DiscountCodeApplication

		/// The method by which the discount's value is allocated to its entitled 
		/// items. 
		@discardableResult
		open func allocationMethod(alias: String? = nil) -> DiscountCodeApplicationQuery {
			addField(field: "allocationMethod", aliasSuffix: alias)
			return self
		}

		/// Specifies whether the discount code was applied successfully. 
		@discardableResult
		open func applicable(alias: String? = nil) -> DiscountCodeApplicationQuery {
			addField(field: "applicable", aliasSuffix: alias)
			return self
		}

		/// The string identifying the discount code that was used at the time of 
		/// application. 
		@discardableResult
		open func code(alias: String? = nil) -> DiscountCodeApplicationQuery {
			addField(field: "code", aliasSuffix: alias)
			return self
		}

		/// Which lines of targetType that the discount is allocated over. 
		@discardableResult
		open func targetSelection(alias: String? = nil) -> DiscountCodeApplicationQuery {
			addField(field: "targetSelection", aliasSuffix: alias)
			return self
		}

		/// The type of line that the discount is applicable towards. 
		@discardableResult
		open func targetType(alias: String? = nil) -> DiscountCodeApplicationQuery {
			addField(field: "targetType", aliasSuffix: alias)
			return self
		}

		/// The value of the discount application. 
		@discardableResult
		open func value(alias: String? = nil, _ subfields: (PricingValueQuery) -> Void) -> DiscountCodeApplicationQuery {
			let subquery = PricingValueQuery()
			subfields(subquery)

			addField(field: "value", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Discount code applications capture the intentions of a discount code at the 
	/// time that it is applied. 
	open class DiscountCodeApplication: GraphQL.AbstractResponse, GraphQLObject, DiscountApplication {
		public typealias Query = DiscountCodeApplicationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "allocationMethod":
				guard let value = value as? String else {
					throw SchemaViolationError(type: DiscountCodeApplication.self, field: fieldName, value: fieldValue)
				}
				return DiscountApplicationAllocationMethod(rawValue: value) ?? .unknownValue

				case "applicable":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: DiscountCodeApplication.self, field: fieldName, value: fieldValue)
				}
				return value

				case "code":
				guard let value = value as? String else {
					throw SchemaViolationError(type: DiscountCodeApplication.self, field: fieldName, value: fieldValue)
				}
				return value

				case "targetSelection":
				guard let value = value as? String else {
					throw SchemaViolationError(type: DiscountCodeApplication.self, field: fieldName, value: fieldValue)
				}
				return DiscountApplicationTargetSelection(rawValue: value) ?? .unknownValue

				case "targetType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: DiscountCodeApplication.self, field: fieldName, value: fieldValue)
				}
				return DiscountApplicationTargetType(rawValue: value) ?? .unknownValue

				case "value":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: DiscountCodeApplication.self, field: fieldName, value: fieldValue)
				}
				return try UnknownPricingValue.create(fields: value)

				default:
				throw SchemaViolationError(type: DiscountCodeApplication.self, field: fieldName, value: fieldValue)
			}
		}

		/// The method by which the discount's value is allocated to its entitled 
		/// items. 
		open var allocationMethod: Storefront.DiscountApplicationAllocationMethod {
			return internalGetAllocationMethod()
		}

		func internalGetAllocationMethod(alias: String? = nil) -> Storefront.DiscountApplicationAllocationMethod {
			return field(field: "allocationMethod", aliasSuffix: alias) as! Storefront.DiscountApplicationAllocationMethod
		}

		/// Specifies whether the discount code was applied successfully. 
		open var applicable: Bool {
			return internalGetApplicable()
		}

		func internalGetApplicable(alias: String? = nil) -> Bool {
			return field(field: "applicable", aliasSuffix: alias) as! Bool
		}

		/// The string identifying the discount code that was used at the time of 
		/// application. 
		open var code: String {
			return internalGetCode()
		}

		func internalGetCode(alias: String? = nil) -> String {
			return field(field: "code", aliasSuffix: alias) as! String
		}

		/// Which lines of targetType that the discount is allocated over. 
		open var targetSelection: Storefront.DiscountApplicationTargetSelection {
			return internalGetTargetSelection()
		}

		func internalGetTargetSelection(alias: String? = nil) -> Storefront.DiscountApplicationTargetSelection {
			return field(field: "targetSelection", aliasSuffix: alias) as! Storefront.DiscountApplicationTargetSelection
		}

		/// The type of line that the discount is applicable towards. 
		open var targetType: Storefront.DiscountApplicationTargetType {
			return internalGetTargetType()
		}

		func internalGetTargetType(alias: String? = nil) -> Storefront.DiscountApplicationTargetType {
			return field(field: "targetType", aliasSuffix: alias) as! Storefront.DiscountApplicationTargetType
		}

		/// The value of the discount application. 
		open var value: PricingValue {
			return internalGetValue()
		}

		func internalGetValue(alias: String? = nil) -> PricingValue {
			return field(field: "value", aliasSuffix: alias) as! PricingValue
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

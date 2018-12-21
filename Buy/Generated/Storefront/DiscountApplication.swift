//
//  DiscountApplication.swift
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

/// Discount applications capture the intentions of a discount source at the 
/// time of application. 
public protocol DiscountApplication {
	var allocationMethod: Storefront.DiscountApplicationAllocationMethod { get }

	var targetSelection: Storefront.DiscountApplicationTargetSelection { get }

	var targetType: Storefront.DiscountApplicationTargetType { get }

	var value: PricingValue { get }
}

extension Storefront {
	/// Discount applications capture the intentions of a discount source at the 
	/// time of application. 
	open class DiscountApplicationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = DiscountApplication

		/// The method by which the discount's value is allocated to its entitled 
		/// items. 
		@discardableResult
		open func allocationMethod(alias: String? = nil) -> DiscountApplicationQuery {
			addField(field: "allocationMethod", aliasSuffix: alias)
			return self
		}

		/// Which lines of targetType that the discount is allocated over. 
		@discardableResult
		open func targetSelection(alias: String? = nil) -> DiscountApplicationQuery {
			addField(field: "targetSelection", aliasSuffix: alias)
			return self
		}

		/// The type of line that the discount is applicable towards. 
		@discardableResult
		open func targetType(alias: String? = nil) -> DiscountApplicationQuery {
			addField(field: "targetType", aliasSuffix: alias)
			return self
		}

		/// The value of the discount application. 
		@discardableResult
		open func value(alias: String? = nil, _ subfields: (PricingValueQuery) -> Void) -> DiscountApplicationQuery {
			let subquery = PricingValueQuery()
			subfields(subquery)

			addField(field: "value", aliasSuffix: alias, subfields: subquery)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Discount applications capture the intentions of a discount source at the 
		/// time of application. 
		@discardableResult
		open func onAutomaticDiscountApplication(subfields: (AutomaticDiscountApplicationQuery) -> Void) -> DiscountApplicationQuery {
			let subquery = AutomaticDiscountApplicationQuery()
			subfields(subquery)
			addInlineFragment(on: "AutomaticDiscountApplication", subfields: subquery)
			return self
		}

		/// Discount applications capture the intentions of a discount source at the 
		/// time of application. 
		@discardableResult
		open func onDiscountCodeApplication(subfields: (DiscountCodeApplicationQuery) -> Void) -> DiscountApplicationQuery {
			let subquery = DiscountCodeApplicationQuery()
			subfields(subquery)
			addInlineFragment(on: "DiscountCodeApplication", subfields: subquery)
			return self
		}

		/// Discount applications capture the intentions of a discount source at the 
		/// time of application. 
		@discardableResult
		open func onManualDiscountApplication(subfields: (ManualDiscountApplicationQuery) -> Void) -> DiscountApplicationQuery {
			let subquery = ManualDiscountApplicationQuery()
			subfields(subquery)
			addInlineFragment(on: "ManualDiscountApplication", subfields: subquery)
			return self
		}

		/// Discount applications capture the intentions of a discount source at the 
		/// time of application. 
		@discardableResult
		open func onScriptDiscountApplication(subfields: (ScriptDiscountApplicationQuery) -> Void) -> DiscountApplicationQuery {
			let subquery = ScriptDiscountApplicationQuery()
			subfields(subquery)
			addInlineFragment(on: "ScriptDiscountApplication", subfields: subquery)
			return self
		}
	}

	/// Discount applications capture the intentions of a discount source at the 
	/// time of application. 
	open class UnknownDiscountApplication: GraphQL.AbstractResponse, GraphQLObject, DiscountApplication {
		public typealias Query = DiscountApplicationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "allocationMethod":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownDiscountApplication.self, field: fieldName, value: fieldValue)
				}
				return DiscountApplicationAllocationMethod(rawValue: value) ?? .unknownValue

				case "targetSelection":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownDiscountApplication.self, field: fieldName, value: fieldValue)
				}
				return DiscountApplicationTargetSelection(rawValue: value) ?? .unknownValue

				case "targetType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownDiscountApplication.self, field: fieldName, value: fieldValue)
				}
				return DiscountApplicationTargetType(rawValue: value) ?? .unknownValue

				case "value":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: UnknownDiscountApplication.self, field: fieldName, value: fieldValue)
				}
				return try UnknownPricingValue.create(fields: value)

				default:
				throw SchemaViolationError(type: UnknownDiscountApplication.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> DiscountApplication {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownDiscountApplication.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "AutomaticDiscountApplication": return try AutomaticDiscountApplication.init(fields: fields)

				case "DiscountCodeApplication": return try DiscountCodeApplication.init(fields: fields)

				case "ManualDiscountApplication": return try ManualDiscountApplication.init(fields: fields)

				case "ScriptDiscountApplication": return try ScriptDiscountApplication.init(fields: fields)

				default:
				return try UnknownDiscountApplication.init(fields: fields)
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

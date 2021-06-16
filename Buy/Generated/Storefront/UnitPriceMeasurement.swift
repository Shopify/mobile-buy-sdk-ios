//
//  UnitPriceMeasurement.swift
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
	/// The measurement used to calculate a unit price for a product variant (e.g. 
	/// $9.99 / 100ml). 
	open class UnitPriceMeasurementQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = UnitPriceMeasurement

		/// The type of unit of measurement for the unit price measurement. 
		@discardableResult
		open func measuredType(alias: String? = nil) -> UnitPriceMeasurementQuery {
			addField(field: "measuredType", aliasSuffix: alias)
			return self
		}

		/// The quantity unit for the unit price measurement. 
		@discardableResult
		open func quantityUnit(alias: String? = nil) -> UnitPriceMeasurementQuery {
			addField(field: "quantityUnit", aliasSuffix: alias)
			return self
		}

		/// The quantity value for the unit price measurement. 
		@discardableResult
		open func quantityValue(alias: String? = nil) -> UnitPriceMeasurementQuery {
			addField(field: "quantityValue", aliasSuffix: alias)
			return self
		}

		/// The reference unit for the unit price measurement. 
		@discardableResult
		open func referenceUnit(alias: String? = nil) -> UnitPriceMeasurementQuery {
			addField(field: "referenceUnit", aliasSuffix: alias)
			return self
		}

		/// The reference value for the unit price measurement. 
		@discardableResult
		open func referenceValue(alias: String? = nil) -> UnitPriceMeasurementQuery {
			addField(field: "referenceValue", aliasSuffix: alias)
			return self
		}
	}

	/// The measurement used to calculate a unit price for a product variant (e.g. 
	/// $9.99 / 100ml). 
	open class UnitPriceMeasurement: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = UnitPriceMeasurementQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "measuredType":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnitPriceMeasurement.self, field: fieldName, value: fieldValue)
				}
				return UnitPriceMeasurementMeasuredType(rawValue: value) ?? .unknownValue

				case "quantityUnit":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnitPriceMeasurement.self, field: fieldName, value: fieldValue)
				}
				return UnitPriceMeasurementMeasuredUnit(rawValue: value) ?? .unknownValue

				case "quantityValue":
				guard let value = value as? Double else {
					throw SchemaViolationError(type: UnitPriceMeasurement.self, field: fieldName, value: fieldValue)
				}
				return value

				case "referenceUnit":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnitPriceMeasurement.self, field: fieldName, value: fieldValue)
				}
				return UnitPriceMeasurementMeasuredUnit(rawValue: value) ?? .unknownValue

				case "referenceValue":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: UnitPriceMeasurement.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: UnitPriceMeasurement.self, field: fieldName, value: fieldValue)
			}
		}

		/// The type of unit of measurement for the unit price measurement. 
		open var measuredType: Storefront.UnitPriceMeasurementMeasuredType? {
			return internalGetMeasuredType()
		}

		func internalGetMeasuredType(alias: String? = nil) -> Storefront.UnitPriceMeasurementMeasuredType? {
			return field(field: "measuredType", aliasSuffix: alias) as! Storefront.UnitPriceMeasurementMeasuredType?
		}

		/// The quantity unit for the unit price measurement. 
		open var quantityUnit: Storefront.UnitPriceMeasurementMeasuredUnit? {
			return internalGetQuantityUnit()
		}

		func internalGetQuantityUnit(alias: String? = nil) -> Storefront.UnitPriceMeasurementMeasuredUnit? {
			return field(field: "quantityUnit", aliasSuffix: alias) as! Storefront.UnitPriceMeasurementMeasuredUnit?
		}

		/// The quantity value for the unit price measurement. 
		open var quantityValue: Double {
			return internalGetQuantityValue()
		}

		func internalGetQuantityValue(alias: String? = nil) -> Double {
			return field(field: "quantityValue", aliasSuffix: alias) as! Double
		}

		/// The reference unit for the unit price measurement. 
		open var referenceUnit: Storefront.UnitPriceMeasurementMeasuredUnit? {
			return internalGetReferenceUnit()
		}

		func internalGetReferenceUnit(alias: String? = nil) -> Storefront.UnitPriceMeasurementMeasuredUnit? {
			return field(field: "referenceUnit", aliasSuffix: alias) as! Storefront.UnitPriceMeasurementMeasuredUnit?
		}

		/// The reference value for the unit price measurement. 
		open var referenceValue: Int32 {
			return internalGetReferenceValue()
		}

		func internalGetReferenceValue(alias: String? = nil) -> Int32 {
			return field(field: "referenceValue", aliasSuffix: alias) as! Int32
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

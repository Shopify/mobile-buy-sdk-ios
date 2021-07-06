//
//  LocationAddress.swift
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
	/// Represents the address of the location. 
	open class LocationAddressQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = LocationAddress

		/// The first line of the address for the location. 
		@discardableResult
		open func address1(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "address1", aliasSuffix: alias)
			return self
		}

		/// The second line of the address for the location. 
		@discardableResult
		open func address2(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "address2", aliasSuffix: alias)
			return self
		}

		/// The city of the location. 
		@discardableResult
		open func city(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "city", aliasSuffix: alias)
			return self
		}

		/// The country of the location. 
		@discardableResult
		open func country(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "country", aliasSuffix: alias)
			return self
		}

		/// The two-letter country code of the location. 
		@discardableResult
		open func countryCode(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// A formatted version of the location address. 
		@discardableResult
		open func formatted(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "formatted", aliasSuffix: alias)
			return self
		}

		/// The latitude coordinates of the location. 
		@discardableResult
		open func latitude(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "latitude", aliasSuffix: alias)
			return self
		}

		/// The longitude coordinates of the location. 
		@discardableResult
		open func longitude(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "longitude", aliasSuffix: alias)
			return self
		}

		/// The phone number of the location. 
		@discardableResult
		open func phone(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}

		/// The province of the location. 
		@discardableResult
		open func province(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "province", aliasSuffix: alias)
			return self
		}

		/// The code for the region of the address, such as the province, state, or 
		/// district. For example QC for Quebec, Canada. 
		@discardableResult
		open func provinceCode(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "provinceCode", aliasSuffix: alias)
			return self
		}

		/// The ZIP code of the location. 
		@discardableResult
		open func zip(alias: String? = nil) -> LocationAddressQuery {
			addField(field: "zip", aliasSuffix: alias)
			return self
		}
	}

	/// Represents the address of the location. 
	open class LocationAddress: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = LocationAddressQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "address1":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "address2":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "city":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "country":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "countryCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "formatted":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "latitude":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "longitude":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "province":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "provinceCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "zip":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: LocationAddress.self, field: fieldName, value: fieldValue)
			}
		}

		/// The first line of the address for the location. 
		open var address1: String? {
			return internalGetAddress1()
		}

		func internalGetAddress1(alias: String? = nil) -> String? {
			return field(field: "address1", aliasSuffix: alias) as! String?
		}

		/// The second line of the address for the location. 
		open var address2: String? {
			return internalGetAddress2()
		}

		func internalGetAddress2(alias: String? = nil) -> String? {
			return field(field: "address2", aliasSuffix: alias) as! String?
		}

		/// The city of the location. 
		open var city: String? {
			return internalGetCity()
		}

		func internalGetCity(alias: String? = nil) -> String? {
			return field(field: "city", aliasSuffix: alias) as! String?
		}

		/// The country of the location. 
		open var country: String? {
			return internalGetCountry()
		}

		func internalGetCountry(alias: String? = nil) -> String? {
			return field(field: "country", aliasSuffix: alias) as! String?
		}

		/// The two-letter country code of the location. 
		open var countryCode: String? {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> String? {
			return field(field: "countryCode", aliasSuffix: alias) as! String?
		}

		/// A formatted version of the location address. 
		open var formatted: [String] {
			return internalGetFormatted()
		}

		func internalGetFormatted(alias: String? = nil) -> [String] {
			return field(field: "formatted", aliasSuffix: alias) as! [String]
		}

		/// The latitude coordinates of the location. 
		open var latitude: Double? {
			return internalGetLatitude()
		}

		func internalGetLatitude(alias: String? = nil) -> Double? {
			return field(field: "latitude", aliasSuffix: alias) as! Double?
		}

		/// The longitude coordinates of the location. 
		open var longitude: Double? {
			return internalGetLongitude()
		}

		func internalGetLongitude(alias: String? = nil) -> Double? {
			return field(field: "longitude", aliasSuffix: alias) as! Double?
		}

		/// The phone number of the location. 
		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
		}

		/// The province of the location. 
		open var province: String? {
			return internalGetProvince()
		}

		func internalGetProvince(alias: String? = nil) -> String? {
			return field(field: "province", aliasSuffix: alias) as! String?
		}

		/// The code for the region of the address, such as the province, state, or 
		/// district. For example QC for Quebec, Canada. 
		open var provinceCode: String? {
			return internalGetProvinceCode()
		}

		func internalGetProvinceCode(alias: String? = nil) -> String? {
			return field(field: "provinceCode", aliasSuffix: alias) as! String?
		}

		/// The ZIP code of the location. 
		open var zip: String? {
			return internalGetZip()
		}

		func internalGetZip(alias: String? = nil) -> String? {
			return field(field: "zip", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}

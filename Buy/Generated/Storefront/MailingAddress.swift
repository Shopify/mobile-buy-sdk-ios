//
//  MailingAddress.swift
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
	/// Represents a mailing address for customers and shipping. 
	open class MailingAddressQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MailingAddress

		@discardableResult
		open func address1(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "address1", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func address2(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "address2", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func city(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "city", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func company(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "company", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func country(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "country", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func countryCode(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func firstName(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "firstName", aliasSuffix: alias)
			return self
		}

		///
		/// - parameters:
		///     - withName: No description
		///     - withCompany: No description
		///
		@discardableResult
		open func formatted(alias: String? = nil, withName: Bool? = nil, withCompany: Bool? = nil) -> MailingAddressQuery {
			var args: [String] = []

			if let withName = withName {
				args.append("withName:\(withName)")
			}

			if let withCompany = withCompany {
				args.append("withCompany:\(withCompany)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "formatted", aliasSuffix: alias, args: argsString)
			return self
		}

		@discardableResult
		open func formattedArea(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "formattedArea", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func id(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func lastName(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "lastName", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func latitude(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "latitude", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func longitude(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "longitude", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func name(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func phone(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func province(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "province", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func provinceCode(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "provinceCode", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func zip(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "zip", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a mailing address for customers and shipping. 
	open class MailingAddress: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = MailingAddressQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "address1":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "address2":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "city":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "company":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "country":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "countryCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "firstName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "formatted":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "formattedArea":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lastName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "latitude":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "longitude":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "name":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "province":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "provinceCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "zip":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var address1: String? {
			return internalGetAddress1()
		}

		func internalGetAddress1(alias: String? = nil) -> String? {
			return field(field: "address1", aliasSuffix: alias) as! String?
		}

		open var address2: String? {
			return internalGetAddress2()
		}

		func internalGetAddress2(alias: String? = nil) -> String? {
			return field(field: "address2", aliasSuffix: alias) as! String?
		}

		open var city: String? {
			return internalGetCity()
		}

		func internalGetCity(alias: String? = nil) -> String? {
			return field(field: "city", aliasSuffix: alias) as! String?
		}

		open var company: String? {
			return internalGetCompany()
		}

		func internalGetCompany(alias: String? = nil) -> String? {
			return field(field: "company", aliasSuffix: alias) as! String?
		}

		open var country: String? {
			return internalGetCountry()
		}

		func internalGetCountry(alias: String? = nil) -> String? {
			return field(field: "country", aliasSuffix: alias) as! String?
		}

		open var countryCode: String? {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> String? {
			return field(field: "countryCode", aliasSuffix: alias) as! String?
		}

		open var firstName: String? {
			return internalGetFirstName()
		}

		func internalGetFirstName(alias: String? = nil) -> String? {
			return field(field: "firstName", aliasSuffix: alias) as! String?
		}

		open var formatted: [String] {
			return internalGetFormatted()
		}

		open func aliasedFormatted(alias: String) -> [String] {
			return internalGetFormatted(alias: alias)
		}

		func internalGetFormatted(alias: String? = nil) -> [String] {
			return field(field: "formatted", aliasSuffix: alias) as! [String]
		}

		open var formattedArea: String? {
			return internalGetFormattedArea()
		}

		func internalGetFormattedArea(alias: String? = nil) -> String? {
			return field(field: "formattedArea", aliasSuffix: alias) as! String?
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		open var lastName: String? {
			return internalGetLastName()
		}

		func internalGetLastName(alias: String? = nil) -> String? {
			return field(field: "lastName", aliasSuffix: alias) as! String?
		}

		open var latitude: Double? {
			return internalGetLatitude()
		}

		func internalGetLatitude(alias: String? = nil) -> Double? {
			return field(field: "latitude", aliasSuffix: alias) as! Double?
		}

		open var longitude: Double? {
			return internalGetLongitude()
		}

		func internalGetLongitude(alias: String? = nil) -> Double? {
			return field(field: "longitude", aliasSuffix: alias) as! Double?
		}

		open var name: String? {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String? {
			return field(field: "name", aliasSuffix: alias) as! String?
		}

		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
		}

		open var province: String? {
			return internalGetProvince()
		}

		func internalGetProvince(alias: String? = nil) -> String? {
			return field(field: "province", aliasSuffix: alias) as! String?
		}

		open var provinceCode: String? {
			return internalGetProvinceCode()
		}

		func internalGetProvinceCode(alias: String? = nil) -> String? {
			return field(field: "provinceCode", aliasSuffix: alias) as! String?
		}

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

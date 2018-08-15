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

		/// The first line of the address. Typically the street address or PO Box 
		/// number. 
		@discardableResult
		open func address1(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "address1", aliasSuffix: alias)
			return self
		}

		/// The second line of the address. Typically the number of the apartment, 
		/// suite, or unit. 
		@discardableResult
		open func address2(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "address2", aliasSuffix: alias)
			return self
		}

		/// The name of the city, district, village, or town. 
		@discardableResult
		open func city(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "city", aliasSuffix: alias)
			return self
		}

		/// The name of the customer's company or organization. 
		@discardableResult
		open func company(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "company", aliasSuffix: alias)
			return self
		}

		/// The name of the country. 
		@discardableResult
		open func country(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "country", aliasSuffix: alias)
			return self
		}

		/// The two-letter code for the country of the address. For example, US. 
		@available(*, deprecated, message:"Use `countryCodeV2` instead")
		@discardableResult
		open func countryCode(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// The two-letter code for the country of the address. For example, US. 
		@discardableResult
		open func countryCodeV2(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "countryCodeV2", aliasSuffix: alias)
			return self
		}

		/// The first name of the customer. 
		@discardableResult
		open func firstName(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "firstName", aliasSuffix: alias)
			return self
		}

		/// A formatted version of the address, customized by the provided arguments. 
		///
		/// - parameters:
		///     - withName: Whether to include the customer's name in the formatted address.
		///     - withCompany: Whether to include the customer's company in the formatted address.
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

		/// A comma-separated list of the values for city, province, and country. 
		@discardableResult
		open func formattedArea(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "formattedArea", aliasSuffix: alias)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The last name of the customer. 
		@discardableResult
		open func lastName(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "lastName", aliasSuffix: alias)
			return self
		}

		/// The latitude coordinate of the customer address. 
		@discardableResult
		open func latitude(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "latitude", aliasSuffix: alias)
			return self
		}

		/// The longitude coordinate of the customer address. 
		@discardableResult
		open func longitude(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "longitude", aliasSuffix: alias)
			return self
		}

		/// The full name of the customer, based on firstName and lastName. 
		@discardableResult
		open func name(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// A unique phone number for the customer. Formatted using E.164 standard. For 
		/// example, _+16135551111_. 
		@discardableResult
		open func phone(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}

		/// The region of the address, such as the province, state, or district. 
		@discardableResult
		open func province(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "province", aliasSuffix: alias)
			return self
		}

		/// The two-letter code for the region. For example, ON. 
		@discardableResult
		open func provinceCode(alias: String? = nil) -> MailingAddressQuery {
			addField(field: "provinceCode", aliasSuffix: alias)
			return self
		}

		/// The zip or postal code of the address. 
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
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "address2":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "city":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "company":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "country":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "countryCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "countryCodeV2":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return CountryCode(rawValue: value) ?? .unknownValue

				case "firstName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "formatted":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "formattedArea":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lastName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "latitude":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "longitude":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "name":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "province":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "provinceCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "zip":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: MailingAddress.self, field: fieldName, value: fieldValue)
			}
		}

		/// The first line of the address. Typically the street address or PO Box 
		/// number. 
		open var address1: String? {
			return internalGetAddress1()
		}

		func internalGetAddress1(alias: String? = nil) -> String? {
			return field(field: "address1", aliasSuffix: alias) as! String?
		}

		/// The second line of the address. Typically the number of the apartment, 
		/// suite, or unit. 
		open var address2: String? {
			return internalGetAddress2()
		}

		func internalGetAddress2(alias: String? = nil) -> String? {
			return field(field: "address2", aliasSuffix: alias) as! String?
		}

		/// The name of the city, district, village, or town. 
		open var city: String? {
			return internalGetCity()
		}

		func internalGetCity(alias: String? = nil) -> String? {
			return field(field: "city", aliasSuffix: alias) as! String?
		}

		/// The name of the customer's company or organization. 
		open var company: String? {
			return internalGetCompany()
		}

		func internalGetCompany(alias: String? = nil) -> String? {
			return field(field: "company", aliasSuffix: alias) as! String?
		}

		/// The name of the country. 
		open var country: String? {
			return internalGetCountry()
		}

		func internalGetCountry(alias: String? = nil) -> String? {
			return field(field: "country", aliasSuffix: alias) as! String?
		}

		/// The two-letter code for the country of the address. For example, US. 
		@available(*, deprecated, message:"Use `countryCodeV2` instead")
		open var countryCode: String? {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> String? {
			return field(field: "countryCode", aliasSuffix: alias) as! String?
		}

		/// The two-letter code for the country of the address. For example, US. 
		open var countryCodeV2: Storefront.CountryCode? {
			return internalGetCountryCodeV2()
		}

		func internalGetCountryCodeV2(alias: String? = nil) -> Storefront.CountryCode? {
			return field(field: "countryCodeV2", aliasSuffix: alias) as! Storefront.CountryCode?
		}

		/// The first name of the customer. 
		open var firstName: String? {
			return internalGetFirstName()
		}

		func internalGetFirstName(alias: String? = nil) -> String? {
			return field(field: "firstName", aliasSuffix: alias) as! String?
		}

		/// A formatted version of the address, customized by the provided arguments. 
		open var formatted: [String] {
			return internalGetFormatted()
		}

		open func aliasedFormatted(alias: String) -> [String] {
			return internalGetFormatted(alias: alias)
		}

		func internalGetFormatted(alias: String? = nil) -> [String] {
			return field(field: "formatted", aliasSuffix: alias) as! [String]
		}

		/// A comma-separated list of the values for city, province, and country. 
		open var formattedArea: String? {
			return internalGetFormattedArea()
		}

		func internalGetFormattedArea(alias: String? = nil) -> String? {
			return field(field: "formattedArea", aliasSuffix: alias) as! String?
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The last name of the customer. 
		open var lastName: String? {
			return internalGetLastName()
		}

		func internalGetLastName(alias: String? = nil) -> String? {
			return field(field: "lastName", aliasSuffix: alias) as! String?
		}

		/// The latitude coordinate of the customer address. 
		open var latitude: Double? {
			return internalGetLatitude()
		}

		func internalGetLatitude(alias: String? = nil) -> Double? {
			return field(field: "latitude", aliasSuffix: alias) as! Double?
		}

		/// The longitude coordinate of the customer address. 
		open var longitude: Double? {
			return internalGetLongitude()
		}

		func internalGetLongitude(alias: String? = nil) -> Double? {
			return field(field: "longitude", aliasSuffix: alias) as! Double?
		}

		/// The full name of the customer, based on firstName and lastName. 
		open var name: String? {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String? {
			return field(field: "name", aliasSuffix: alias) as! String?
		}

		/// A unique phone number for the customer. Formatted using E.164 standard. For 
		/// example, _+16135551111_. 
		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
		}

		/// The region of the address, such as the province, state, or district. 
		open var province: String? {
			return internalGetProvince()
		}

		func internalGetProvince(alias: String? = nil) -> String? {
			return field(field: "province", aliasSuffix: alias) as! String?
		}

		/// The two-letter code for the region. For example, ON. 
		open var provinceCode: String? {
			return internalGetProvinceCode()
		}

		func internalGetProvinceCode(alias: String? = nil) -> String? {
			return field(field: "provinceCode", aliasSuffix: alias) as! String?
		}

		/// The zip or postal code of the address. 
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

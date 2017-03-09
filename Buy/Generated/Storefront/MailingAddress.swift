// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class MailingAddressQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func address1(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "address1", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func address2(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "address2", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func city(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "city", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func company(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "company", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func country(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "country", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func countryCode(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "countryCode", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func firstName(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "firstName", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func formatted(aliasSuffix: String? = nil, withName: Bool? = nil, withCompany: Bool? = nil) -> MailingAddressQuery {
			var args: [String] = []

			if let withName = withName {
				args.append("withName:\(withName)")
			}

			if let withCompany = withCompany {
				args.append("withCompany:\(withCompany)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "formatted", aliasSuffix: aliasSuffix, args: argsString)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func lastName(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "lastName", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func latitude(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "latitude", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func longitude(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "longitude", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func name(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "name", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func phone(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "phone", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func province(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "province", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func provinceCode(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "provinceCode", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func zip(aliasSuffix: String? = nil) -> MailingAddressQuery {
			addField(field: "zip", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class MailingAddress: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
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

		open var typeName: String { return "MailingAddress" }

		open var address1: String? {
			return internalGetAddress1()
		}

		func internalGetAddress1(aliasSuffix: String? = nil) -> String? {
			return field(field: "address1", aliasSuffix: aliasSuffix) as! String?
		}

		open var address2: String? {
			return internalGetAddress2()
		}

		func internalGetAddress2(aliasSuffix: String? = nil) -> String? {
			return field(field: "address2", aliasSuffix: aliasSuffix) as! String?
		}

		open var city: String? {
			return internalGetCity()
		}

		func internalGetCity(aliasSuffix: String? = nil) -> String? {
			return field(field: "city", aliasSuffix: aliasSuffix) as! String?
		}

		open var company: String? {
			return internalGetCompany()
		}

		func internalGetCompany(aliasSuffix: String? = nil) -> String? {
			return field(field: "company", aliasSuffix: aliasSuffix) as! String?
		}

		open var country: String? {
			return internalGetCountry()
		}

		func internalGetCountry(aliasSuffix: String? = nil) -> String? {
			return field(field: "country", aliasSuffix: aliasSuffix) as! String?
		}

		open var countryCode: String? {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(aliasSuffix: String? = nil) -> String? {
			return field(field: "countryCode", aliasSuffix: aliasSuffix) as! String?
		}

		open var firstName: String? {
			return internalGetFirstName()
		}

		func internalGetFirstName(aliasSuffix: String? = nil) -> String? {
			return field(field: "firstName", aliasSuffix: aliasSuffix) as! String?
		}

		open var formatted: [String] {
			return internalGetFormatted()
		}

		open func aliasedFormatted(aliasSuffix: String) -> [String] {
			return internalGetFormatted(aliasSuffix: aliasSuffix)
		}

		func internalGetFormatted(aliasSuffix: String? = nil) -> [String] {
			return field(field: "formatted", aliasSuffix: aliasSuffix) as! [String]
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var lastName: String? {
			return internalGetLastName()
		}

		func internalGetLastName(aliasSuffix: String? = nil) -> String? {
			return field(field: "lastName", aliasSuffix: aliasSuffix) as! String?
		}

		open var latitude: Double? {
			return internalGetLatitude()
		}

		func internalGetLatitude(aliasSuffix: String? = nil) -> Double? {
			return field(field: "latitude", aliasSuffix: aliasSuffix) as! Double?
		}

		open var longitude: Double? {
			return internalGetLongitude()
		}

		func internalGetLongitude(aliasSuffix: String? = nil) -> Double? {
			return field(field: "longitude", aliasSuffix: aliasSuffix) as! Double?
		}

		open var name: String? {
			return internalGetName()
		}

		func internalGetName(aliasSuffix: String? = nil) -> String? {
			return field(field: "name", aliasSuffix: aliasSuffix) as! String?
		}

		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(aliasSuffix: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: aliasSuffix) as! String?
		}

		open var province: String? {
			return internalGetProvince()
		}

		func internalGetProvince(aliasSuffix: String? = nil) -> String? {
			return field(field: "province", aliasSuffix: aliasSuffix) as! String?
		}

		open var provinceCode: String? {
			return internalGetProvinceCode()
		}

		func internalGetProvinceCode(aliasSuffix: String? = nil) -> String? {
			return field(field: "provinceCode", aliasSuffix: aliasSuffix) as! String?
		}

		open var zip: String? {
			return internalGetZip()
		}

		func internalGetZip(aliasSuffix: String? = nil) -> String? {
			return field(field: "zip", aliasSuffix: aliasSuffix) as! String?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "address1":

				return .Scalar

				case "address2":

				return .Scalar

				case "city":

				return .Scalar

				case "company":

				return .Scalar

				case "country":

				return .Scalar

				case "countryCode":

				return .Scalar

				case "firstName":

				return .Scalar

				case "formatted":

				return .ScalarList

				case "id":

				return .Scalar

				case "lastName":

				return .Scalar

				case "latitude":

				return .Scalar

				case "longitude":

				return .Scalar

				case "name":

				return .Scalar

				case "phone":

				return .Scalar

				case "province":

				return .Scalar

				case "provinceCode":

				return .Scalar

				case "zip":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}

		open func responseObject() -> GraphQL.AbstractResponse {
			return self as GraphQL.AbstractResponse
		}
	}
}

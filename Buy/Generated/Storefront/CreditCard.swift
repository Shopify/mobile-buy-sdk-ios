// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CreditCardQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func brand(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "brand", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func expiryMonth(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "expiryMonth", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func expiryYear(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "expiryYear", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func firstDigits(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "firstDigits", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func firstName(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "firstName", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func lastDigits(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "lastDigits", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func lastName(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "lastName", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func maskedNumber(aliasSuffix: String? = nil) -> CreditCardQuery {
			addField(field: "maskedNumber", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class CreditCard: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "brand":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "expiryMonth":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "expiryYear":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "firstDigits":
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

				case "lastDigits":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "lastName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "maskedNumber":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CreditCard" }

		open var brand: String? {
			return internalGetBrand()
		}

		func internalGetBrand(aliasSuffix: String? = nil) -> String? {
			return field(field: "brand", aliasSuffix: aliasSuffix) as! String?
		}

		open var expiryMonth: Int32? {
			return internalGetExpiryMonth()
		}

		func internalGetExpiryMonth(aliasSuffix: String? = nil) -> Int32? {
			return field(field: "expiryMonth", aliasSuffix: aliasSuffix) as! Int32?
		}

		open var expiryYear: Int32? {
			return internalGetExpiryYear()
		}

		func internalGetExpiryYear(aliasSuffix: String? = nil) -> Int32? {
			return field(field: "expiryYear", aliasSuffix: aliasSuffix) as! Int32?
		}

		open var firstDigits: String? {
			return internalGetFirstDigits()
		}

		func internalGetFirstDigits(aliasSuffix: String? = nil) -> String? {
			return field(field: "firstDigits", aliasSuffix: aliasSuffix) as! String?
		}

		open var firstName: String? {
			return internalGetFirstName()
		}

		func internalGetFirstName(aliasSuffix: String? = nil) -> String? {
			return field(field: "firstName", aliasSuffix: aliasSuffix) as! String?
		}

		open var lastDigits: String? {
			return internalGetLastDigits()
		}

		func internalGetLastDigits(aliasSuffix: String? = nil) -> String? {
			return field(field: "lastDigits", aliasSuffix: aliasSuffix) as! String?
		}

		open var lastName: String? {
			return internalGetLastName()
		}

		func internalGetLastName(aliasSuffix: String? = nil) -> String? {
			return field(field: "lastName", aliasSuffix: aliasSuffix) as! String?
		}

		open var maskedNumber: String? {
			return internalGetMaskedNumber()
		}

		func internalGetMaskedNumber(aliasSuffix: String? = nil) -> String? {
			return field(field: "maskedNumber", aliasSuffix: aliasSuffix) as! String?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "brand":

				return .Scalar

				case "expiryMonth":

				return .Scalar

				case "expiryYear":

				return .Scalar

				case "firstDigits":

				return .Scalar

				case "firstName":

				return .Scalar

				case "lastDigits":

				return .Scalar

				case "lastName":

				return .Scalar

				case "maskedNumber":

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

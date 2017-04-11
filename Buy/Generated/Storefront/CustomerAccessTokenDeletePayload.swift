// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAccessTokenDeletePayloadQuery: GraphQL.AbstractQuery {
		@available(*, deprecated, message:"Relay is moving away from requiring this field")
		@discardableResult
		open func clientMutationId(aliasSuffix: String? = nil) -> CustomerAccessTokenDeletePayloadQuery {
			addField(field: "clientMutationId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func deletedAccessToken(aliasSuffix: String? = nil) -> CustomerAccessTokenDeletePayloadQuery {
			addField(field: "deletedAccessToken", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func deletedCustomerAccessTokenId(aliasSuffix: String? = nil) -> CustomerAccessTokenDeletePayloadQuery {
			addField(field: "deletedCustomerAccessTokenId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CustomerAccessTokenDeletePayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class CustomerAccessTokenDeletePayload: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "clientMutationId":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "deletedAccessToken":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "deletedCustomerAccessTokenId":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CustomerAccessTokenDeletePayload" }

		@available(*, deprecated, message:"Relay is moving away from requiring this field")
		open var clientMutationId: String? {
			return internalGetClientMutationId()
		}

		func internalGetClientMutationId(aliasSuffix: String? = nil) -> String? {
			return field(field: "clientMutationId", aliasSuffix: aliasSuffix) as! String?
		}

		open var deletedAccessToken: String? {
			return internalGetDeletedAccessToken()
		}

		func internalGetDeletedAccessToken(aliasSuffix: String? = nil) -> String? {
			return field(field: "deletedAccessToken", aliasSuffix: aliasSuffix) as! String?
		}

		open var deletedCustomerAccessTokenId: String? {
			return internalGetDeletedCustomerAccessTokenId()
		}

		func internalGetDeletedCustomerAccessTokenId(aliasSuffix: String? = nil) -> String? {
			return field(field: "deletedCustomerAccessTokenId", aliasSuffix: aliasSuffix) as! String?
		}

		open var userErrors: [Storefront.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(aliasSuffix: String? = nil) -> [Storefront.UserError] {
			return field(field: "userErrors", aliasSuffix: aliasSuffix) as! [Storefront.UserError]
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "clientMutationId":

				return .Scalar

				case "deletedAccessToken":

				return .Scalar

				case "deletedCustomerAccessTokenId":

				return .Scalar

				case "userErrors":

				return .ObjectList

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
				case "userErrors":
				return internalGetUserErrors()

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

// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class CustomerRecoverPayloadQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func clientMutationId(aliasSuffix: String? = nil) -> CustomerRecoverPayloadQuery {
			addField(field: "clientMutationId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CustomerRecoverPayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class CustomerRecoverPayload: GraphQL.AbstractResponse
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

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CustomerRecoverPayload" }

		open var clientMutationId: String? {
			return internalGetClientMutationId()
		}

		func internalGetClientMutationId(aliasSuffix: String? = nil) -> String? {
			return field(field: "clientMutationId", aliasSuffix: aliasSuffix) as! String?
		}

		open var userErrors: [ApiSchema.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(aliasSuffix: String? = nil) -> [ApiSchema.UserError] {
			return field(field: "userErrors", aliasSuffix: aliasSuffix) as! [ApiSchema.UserError]
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "clientMutationId":

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

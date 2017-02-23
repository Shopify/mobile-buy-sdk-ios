// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class CustomerUpdatePayloadQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func clientMutationId(aliasSuffix: String? = nil) -> CustomerUpdatePayloadQuery {
			addField(field: "clientMutationId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func customer(aliasSuffix: String? = nil, _ subfields: (CustomerQuery) -> Void) -> CustomerUpdatePayloadQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CustomerUpdatePayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class CustomerUpdatePayload: GraphQL.AbstractResponse
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

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CustomerUpdatePayload" }

		open var clientMutationId: String? {
			return internalGetClientMutationId()
		}

		func internalGetClientMutationId(aliasSuffix: String? = nil) -> String? {
			return field(field: "clientMutationId", aliasSuffix: aliasSuffix) as! String?
		}

		open var customer: ApiSchema.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(aliasSuffix: String? = nil) -> ApiSchema.Customer? {
			return field(field: "customer", aliasSuffix: aliasSuffix) as! ApiSchema.Customer?
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

				case "customer":

				return .Object

				case "userErrors":

				return .ObjectList

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "customer":
				return internalGetCustomer()

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
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "userErrors":
					internalGetUserErrors().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			})
			return response
		}

		open func responseObject() -> GraphQL.AbstractResponse {
			return self as GraphQL.AbstractResponse
		}
	}
}

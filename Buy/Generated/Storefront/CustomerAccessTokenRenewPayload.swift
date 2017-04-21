// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAccessTokenRenewPayloadQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func customerAccessToken(aliasSuffix: String? = nil, _ subfields: (CustomerAccessTokenQuery) -> Void) -> CustomerAccessTokenRenewPayloadQuery {
			let subquery = CustomerAccessTokenQuery()
			subfields(subquery)

			addField(field: "customerAccessToken", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CustomerAccessTokenRenewPayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class CustomerAccessTokenRenewPayload: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customerAccessToken":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAccessToken(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CustomerAccessTokenRenewPayload" }

		open var customerAccessToken: Storefront.CustomerAccessToken? {
			return internalGetCustomerAccessToken()
		}

		func internalGetCustomerAccessToken(aliasSuffix: String? = nil) -> Storefront.CustomerAccessToken? {
			return field(field: "customerAccessToken", aliasSuffix: aliasSuffix) as! Storefront.CustomerAccessToken?
		}

		open var userErrors: [Storefront.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(aliasSuffix: String? = nil) -> [Storefront.UserError] {
			return field(field: "userErrors", aliasSuffix: aliasSuffix) as! [Storefront.UserError]
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "customerAccessToken":

				return .Object

				case "userErrors":

				return .ObjectList

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "customerAccessToken":
				return internalGetCustomerAccessToken()

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
					case "customerAccessToken":
					if let value = internalGetCustomerAccessToken() {
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

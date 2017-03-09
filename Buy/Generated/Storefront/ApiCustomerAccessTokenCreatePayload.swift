// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ApiCustomerAccessTokenCreatePayloadQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func apiCustomerAccessToken(aliasSuffix: String? = nil, _ subfields: (ApiCustomerAccessTokenQuery) -> Void) -> ApiCustomerAccessTokenCreatePayloadQuery {
			let subquery = ApiCustomerAccessTokenQuery()
			subfields(subquery)

			addField(field: "apiCustomerAccessToken", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func clientMutationId(aliasSuffix: String? = nil) -> ApiCustomerAccessTokenCreatePayloadQuery {
			addField(field: "clientMutationId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> ApiCustomerAccessTokenCreatePayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class ApiCustomerAccessTokenCreatePayload: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "apiCustomerAccessToken":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ApiCustomerAccessToken(fields: value)

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

		open var typeName: String { return "ApiCustomerAccessTokenCreatePayload" }

		open var apiCustomerAccessToken: Storefront.ApiCustomerAccessToken? {
			return internalGetApiCustomerAccessToken()
		}

		func internalGetApiCustomerAccessToken(aliasSuffix: String? = nil) -> Storefront.ApiCustomerAccessToken? {
			return field(field: "apiCustomerAccessToken", aliasSuffix: aliasSuffix) as! Storefront.ApiCustomerAccessToken?
		}

		open var clientMutationId: String? {
			return internalGetClientMutationId()
		}

		func internalGetClientMutationId(aliasSuffix: String? = nil) -> String? {
			return field(field: "clientMutationId", aliasSuffix: aliasSuffix) as! String?
		}

		open var userErrors: [Storefront.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(aliasSuffix: String? = nil) -> [Storefront.UserError] {
			return field(field: "userErrors", aliasSuffix: aliasSuffix) as! [Storefront.UserError]
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "apiCustomerAccessToken":

				return .Object

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
				case "apiCustomerAccessToken":
				return internalGetApiCustomerAccessToken()

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
					case "apiCustomerAccessToken":
					if let value = internalGetApiCustomerAccessToken() {
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

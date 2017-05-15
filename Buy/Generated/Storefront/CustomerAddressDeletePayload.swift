// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAddressDeletePayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CustomerAddressDeletePayload

		@discardableResult
		open func deletedCustomerAddressId(aliasSuffix: String? = nil) -> CustomerAddressDeletePayloadQuery {
			addField(field: "deletedCustomerAddressId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CustomerAddressDeletePayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class CustomerAddressDeletePayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CustomerAddressDeletePayloadQuery

		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "deletedCustomerAddressId":
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

		open var typeName: String { return "CustomerAddressDeletePayload" }

		open var deletedCustomerAddressId: String? {
			return internalGetDeletedCustomerAddressId()
		}

		func internalGetDeletedCustomerAddressId(aliasSuffix: String? = nil) -> String? {
			return field(field: "deletedCustomerAddressId", aliasSuffix: aliasSuffix) as! String?
		}

		open var userErrors: [Storefront.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(aliasSuffix: String? = nil) -> [Storefront.UserError] {
			return field(field: "userErrors", aliasSuffix: aliasSuffix) as! [Storefront.UserError]
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "deletedCustomerAddressId":

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

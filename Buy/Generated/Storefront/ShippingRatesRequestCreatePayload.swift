// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ShippingRatesRequestCreatePayloadQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func clientMutationId(aliasSuffix: String? = nil) -> ShippingRatesRequestCreatePayloadQuery {
			addField(field: "clientMutationId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func shippingRatesRequest(aliasSuffix: String? = nil, _ subfields: (ShippingRatesRequestQuery) -> Void) -> ShippingRatesRequestCreatePayloadQuery {
			let subquery = ShippingRatesRequestQuery()
			subfields(subquery)

			addField(field: "shippingRatesRequest", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> ShippingRatesRequestCreatePayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class ShippingRatesRequestCreatePayload: GraphQL.AbstractResponse
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

				case "shippingRatesRequest":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShippingRatesRequest(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "ShippingRatesRequestCreatePayload" }

		open var clientMutationId: String? {
			return internalGetClientMutationId()
		}

		func internalGetClientMutationId(aliasSuffix: String? = nil) -> String? {
			return field(field: "clientMutationId", aliasSuffix: aliasSuffix) as! String?
		}

		open var shippingRatesRequest: Storefront.ShippingRatesRequest? {
			return internalGetShippingRatesRequest()
		}

		func internalGetShippingRatesRequest(aliasSuffix: String? = nil) -> Storefront.ShippingRatesRequest? {
			return field(field: "shippingRatesRequest", aliasSuffix: aliasSuffix) as! Storefront.ShippingRatesRequest?
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

				case "shippingRatesRequest":

				return .Object

				case "userErrors":

				return .ObjectList

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "shippingRatesRequest":
				return internalGetShippingRatesRequest()

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
					case "shippingRatesRequest":
					if let value = internalGetShippingRatesRequest() {
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

// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ShippingRatesRequestQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func errorMessage(aliasSuffix: String? = nil) -> ShippingRatesRequestQuery {
			addField(field: "errorMessage", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> ShippingRatesRequestQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func shippingRates(aliasSuffix: String? = nil, _ subfields: (ShippingRateQuery) -> Void) -> ShippingRatesRequestQuery {
			let subquery = ShippingRateQuery()
			subfields(subquery)

			addField(field: "shippingRates", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func state(aliasSuffix: String? = nil) -> ShippingRatesRequestQuery {
			addField(field: "state", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class ShippingRatesRequest: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "errorMessage":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "shippingRates":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShippingRate(fields: $0) }

				case "state":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return ShippingRatesRequestState(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "ShippingRatesRequest" }

		open var errorMessage: String? {
			return internalGetErrorMessage()
		}

		func internalGetErrorMessage(aliasSuffix: String? = nil) -> String? {
			return field(field: "errorMessage", aliasSuffix: aliasSuffix) as! String?
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var shippingRates: [Storefront.ShippingRate]? {
			return internalGetShippingRates()
		}

		func internalGetShippingRates(aliasSuffix: String? = nil) -> [Storefront.ShippingRate]? {
			return field(field: "shippingRates", aliasSuffix: aliasSuffix) as! [Storefront.ShippingRate]?
		}

		open var state: Storefront.ShippingRatesRequestState {
			return internalGetState()
		}

		func internalGetState(aliasSuffix: String? = nil) -> Storefront.ShippingRatesRequestState {
			return field(field: "state", aliasSuffix: aliasSuffix) as! Storefront.ShippingRatesRequestState
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "errorMessage":

				return .Scalar

				case "id":

				return .Scalar

				case "shippingRates":

				return .ObjectList

				case "state":

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
				case "shippingRates":
				return internalGetShippingRates() ?? []

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

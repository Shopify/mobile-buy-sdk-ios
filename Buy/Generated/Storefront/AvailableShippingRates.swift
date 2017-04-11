// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class AvailableShippingRatesQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func ready(aliasSuffix: String? = nil) -> AvailableShippingRatesQuery {
			addField(field: "ready", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func shippingRates(aliasSuffix: String? = nil, _ subfields: (ShippingRateQuery) -> Void) -> AvailableShippingRatesQuery {
			let subquery = ShippingRateQuery()
			subfields(subquery)

			addField(field: "shippingRates", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class AvailableShippingRates: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "ready":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "shippingRates":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShippingRate(fields: $0) }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "AvailableShippingRates" }

		open var ready: Bool {
			return internalGetReady()
		}

		func internalGetReady(aliasSuffix: String? = nil) -> Bool {
			return field(field: "ready", aliasSuffix: aliasSuffix) as! Bool
		}

		open var shippingRates: [Storefront.ShippingRate]? {
			return internalGetShippingRates()
		}

		func internalGetShippingRates(aliasSuffix: String? = nil) -> [Storefront.ShippingRate]? {
			return field(field: "shippingRates", aliasSuffix: aliasSuffix) as! [Storefront.ShippingRate]?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "ready":

				return .Scalar

				case "shippingRates":

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

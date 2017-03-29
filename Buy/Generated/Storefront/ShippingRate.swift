// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ShippingRateQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func handle(aliasSuffix: String? = nil) -> ShippingRateQuery {
			addField(field: "handle", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func price(aliasSuffix: String? = nil) -> ShippingRateQuery {
			addField(field: "price", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func title(aliasSuffix: String? = nil) -> ShippingRateQuery {
			addField(field: "title", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class ShippingRate: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "price":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "ShippingRate" }

		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(aliasSuffix: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: aliasSuffix) as! String
		}

		open var price: Decimal {
			return internalGetPrice()
		}

		func internalGetPrice(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "price", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(aliasSuffix: String? = nil) -> String {
			return field(field: "title", aliasSuffix: aliasSuffix) as! String
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "handle":

				return .Scalar

				case "price":

				return .Scalar

				case "title":

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

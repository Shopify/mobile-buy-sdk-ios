// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutLineItemQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CheckoutLineItem

		@discardableResult
		open func customAttributes(aliasSuffix: String? = nil, _ subfields: (AttributeQuery) -> Void) -> CheckoutLineItemQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "customAttributes", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> CheckoutLineItemQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func quantity(aliasSuffix: String? = nil) -> CheckoutLineItemQuery {
			addField(field: "quantity", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func title(aliasSuffix: String? = nil) -> CheckoutLineItemQuery {
			addField(field: "title", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func variant(aliasSuffix: String? = nil, _ subfields: (ProductVariantQuery) -> Void) -> CheckoutLineItemQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "variant", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class CheckoutLineItem: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CheckoutLineItemQuery

		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "quantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "variant":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ProductVariant(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CheckoutLineItem" }

		open var customAttributes: [Storefront.Attribute] {
			return internalGetCustomAttributes()
		}

		func internalGetCustomAttributes(aliasSuffix: String? = nil) -> [Storefront.Attribute] {
			return field(field: "customAttributes", aliasSuffix: aliasSuffix) as! [Storefront.Attribute]
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var quantity: Int32 {
			return internalGetQuantity()
		}

		func internalGetQuantity(aliasSuffix: String? = nil) -> Int32 {
			return field(field: "quantity", aliasSuffix: aliasSuffix) as! Int32
		}

		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(aliasSuffix: String? = nil) -> String {
			return field(field: "title", aliasSuffix: aliasSuffix) as! String
		}

		open var variant: Storefront.ProductVariant? {
			return internalGetVariant()
		}

		func internalGetVariant(aliasSuffix: String? = nil) -> Storefront.ProductVariant? {
			return field(field: "variant", aliasSuffix: aliasSuffix) as! Storefront.ProductVariant?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "customAttributes":

				return .ObjectList

				case "id":

				return .Scalar

				case "quantity":

				return .Scalar

				case "title":

				return .Scalar

				case "variant":

				return .Object

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "variant":
				return internalGetVariant()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				case "customAttributes":
				return internalGetCustomAttributes()

				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "customAttributes":
					internalGetCustomAttributes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "variant":
					if let value = internalGetVariant() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
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

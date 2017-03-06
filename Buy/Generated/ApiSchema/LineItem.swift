// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class LineItemQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func customAttributes(aliasSuffix: String? = nil, _ subfields: (AttributeQuery) -> Void) -> LineItemQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "customAttributes", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func quantity(aliasSuffix: String? = nil) -> LineItemQuery {
			addField(field: "quantity", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func title(aliasSuffix: String? = nil) -> LineItemQuery {
			addField(field: "title", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func variant(aliasSuffix: String? = nil, _ subfields: (ProductVariantQuery) -> Void) -> LineItemQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "variant", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class LineItem: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

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

		open var typeName: String { return "LineItem" }

		open var customAttributes: [ApiSchema.Attribute] {
			return internalGetCustomAttributes()
		}

		func internalGetCustomAttributes(aliasSuffix: String? = nil) -> [ApiSchema.Attribute] {
			return field(field: "customAttributes", aliasSuffix: aliasSuffix) as! [ApiSchema.Attribute]
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

		open var variant: ApiSchema.ProductVariant? {
			return internalGetVariant()
		}

		func internalGetVariant(aliasSuffix: String? = nil) -> ApiSchema.ProductVariant? {
			return field(field: "variant", aliasSuffix: aliasSuffix) as! ApiSchema.ProductVariant?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "customAttributes":

				return .ObjectList

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

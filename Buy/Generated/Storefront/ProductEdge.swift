// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ProductEdgeQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func cursor(aliasSuffix: String? = nil) -> ProductEdgeQuery {
			addField(field: "cursor", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func node(aliasSuffix: String? = nil, _ subfields: (ProductQuery) -> Void) -> ProductEdgeQuery {
			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "node", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class ProductEdge: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cursor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "node":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "ProductEdge" }

		open var cursor: String {
			return internalGetCursor()
		}

		func internalGetCursor(aliasSuffix: String? = nil) -> String {
			return field(field: "cursor", aliasSuffix: aliasSuffix) as! String
		}

		open var node: Storefront.Product {
			return internalGetNode()
		}

		func internalGetNode(aliasSuffix: String? = nil) -> Storefront.Product {
			return field(field: "node", aliasSuffix: aliasSuffix) as! Storefront.Product
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "cursor":

				return .Scalar

				case "node":

				return .Object

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "node":
				return internalGetNode()

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
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "node":
					response.append(internalGetNode())
					response.append(contentsOf: internalGetNode().childResponseObjectMap())

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

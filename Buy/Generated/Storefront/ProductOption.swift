// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ProductOptionQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func id(aliasSuffix: String? = nil) -> ProductOptionQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func name(aliasSuffix: String? = nil) -> ProductOptionQuery {
			addField(field: "name", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func values(aliasSuffix: String? = nil) -> ProductOptionQuery {
			addField(field: "values", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class ProductOption: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "values":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "ProductOption" }

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var name: String {
			return internalGetName()
		}

		func internalGetName(aliasSuffix: String? = nil) -> String {
			return field(field: "name", aliasSuffix: aliasSuffix) as! String
		}

		open var values: [String] {
			return internalGetValues()
		}

		func internalGetValues(aliasSuffix: String? = nil) -> [String] {
			return field(field: "values", aliasSuffix: aliasSuffix) as! [String]
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "id":

				return .Scalar

				case "name":

				return .Scalar

				case "values":

				return .ScalarList

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

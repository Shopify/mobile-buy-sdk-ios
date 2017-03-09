// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ShopPolicyQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func body(aliasSuffix: String? = nil) -> ShopPolicyQuery {
			addField(field: "body", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> ShopPolicyQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func title(aliasSuffix: String? = nil) -> ShopPolicyQuery {
			addField(field: "title", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func url(aliasSuffix: String? = nil) -> ShopPolicyQuery {
			addField(field: "url", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class ShopPolicy: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "body":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "ShopPolicy" }

		open var body: String {
			return internalGetBody()
		}

		func internalGetBody(aliasSuffix: String? = nil) -> String {
			return field(field: "body", aliasSuffix: aliasSuffix) as! String
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(aliasSuffix: String? = nil) -> String {
			return field(field: "title", aliasSuffix: aliasSuffix) as! String
		}

		open var url: String {
			return internalGetUrl()
		}

		func internalGetUrl(aliasSuffix: String? = nil) -> String {
			return field(field: "url", aliasSuffix: aliasSuffix) as! String
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "body":

				return .Scalar

				case "id":

				return .Scalar

				case "title":

				return .Scalar

				case "url":

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

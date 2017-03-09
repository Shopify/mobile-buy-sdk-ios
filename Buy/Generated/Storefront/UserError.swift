// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class UserErrorQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func field(aliasSuffix: String? = nil) -> UserErrorQuery {
			addField(field: "field", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func message(aliasSuffix: String? = nil) -> UserErrorQuery {
			addField(field: "message", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class UserError: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "field":
				if value is NSNull { return nil }
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "message":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "UserError" }

		open var field: [String]? {
			return internalGetField()
		}

		func internalGetField(aliasSuffix: String? = nil) -> [String]? {
			return field(field: "field", aliasSuffix: aliasSuffix) as! [String]?
		}

		open var message: String {
			return internalGetMessage()
		}

		func internalGetMessage(aliasSuffix: String? = nil) -> String {
			return field(field: "message", aliasSuffix: aliasSuffix) as! String
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "field":

				return .ScalarList

				case "message":

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

// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAccessTokenQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func accessToken(aliasSuffix: String? = nil) -> CustomerAccessTokenQuery {
			addField(field: "accessToken", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func expiresAt(aliasSuffix: String? = nil) -> CustomerAccessTokenQuery {
			addField(field: "expiresAt", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class CustomerAccessToken: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "accessToken":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "expiresAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CustomerAccessToken" }

		open var accessToken: String {
			return internalGetAccessToken()
		}

		func internalGetAccessToken(aliasSuffix: String? = nil) -> String {
			return field(field: "accessToken", aliasSuffix: aliasSuffix) as! String
		}

		open var expiresAt: Date {
			return internalGetExpiresAt()
		}

		func internalGetExpiresAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "expiresAt", aliasSuffix: aliasSuffix) as! Date
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "accessToken":

				return .Scalar

				case "expiresAt":

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

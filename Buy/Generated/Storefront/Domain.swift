// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class DomainQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func host(aliasSuffix: String? = nil) -> DomainQuery {
			addField(field: "host", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func sslEnabled(aliasSuffix: String? = nil) -> DomainQuery {
			addField(field: "sslEnabled", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func url(aliasSuffix: String? = nil) -> DomainQuery {
			addField(field: "url", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Domain: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "host":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "sslEnabled":
				guard let value = value as? Bool else {
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

		open var typeName: String { return "Domain" }

		open var host: String {
			return internalGetHost()
		}

		func internalGetHost(aliasSuffix: String? = nil) -> String {
			return field(field: "host", aliasSuffix: aliasSuffix) as! String
		}

		open var sslEnabled: Bool {
			return internalGetSslEnabled()
		}

		func internalGetSslEnabled(aliasSuffix: String? = nil) -> Bool {
			return field(field: "sslEnabled", aliasSuffix: aliasSuffix) as! Bool
		}

		open var url: String {
			return internalGetUrl()
		}

		func internalGetUrl(aliasSuffix: String? = nil) -> String {
			return field(field: "url", aliasSuffix: aliasSuffix) as! String
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "host":

				return .Scalar

				case "sslEnabled":

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

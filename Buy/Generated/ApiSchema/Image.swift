// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class ImageQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func altText(aliasSuffix: String? = nil) -> ImageQuery {
			addField(field: "altText", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> ImageQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func src(aliasSuffix: String? = nil) -> ImageQuery {
			addField(field: "src", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Image: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "altText":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "src":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Image" }

		open var altText: String? {
			return internalGetAltText()
		}

		func internalGetAltText(aliasSuffix: String? = nil) -> String? {
			return field(field: "altText", aliasSuffix: aliasSuffix) as! String?
		}

		open var id: GraphQL.ID? {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID? {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID?
		}

		open var src: String {
			return internalGetSrc()
		}

		func internalGetSrc(aliasSuffix: String? = nil) -> String {
			return field(field: "src", aliasSuffix: aliasSuffix) as! String
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "altText":

				return .Scalar

				case "id":

				return .Scalar

				case "src":

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

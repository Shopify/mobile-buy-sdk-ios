// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class CollectionQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func descriptionHtml(aliasSuffix: String? = nil) -> CollectionQuery {
			addField(field: "descriptionHtml", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func descriptionPlainSummary(aliasSuffix: String? = nil) -> CollectionQuery {
			addField(field: "descriptionPlainSummary", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func handle(aliasSuffix: String? = nil) -> CollectionQuery {
			addField(field: "handle", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> CollectionQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func image(aliasSuffix: String? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageQuery) -> Void) -> CollectionQuery {
			var args: [String] = []

			if let maxWidth = maxWidth {
				args.append("maxWidth:\(maxWidth)")
			}

			if let maxHeight = maxHeight {
				args.append("maxHeight:\(maxHeight)")
			}

			if let crop = crop {
				args.append("crop:\(crop.rawValue)")
			}

			if let scale = scale {
				args.append("scale:\(scale)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func products(aliasSuffix: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (ProductConnectionQuery) -> Void) -> CollectionQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductConnectionQuery()
			subfields(subquery)

			addField(field: "products", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func title(aliasSuffix: String? = nil) -> CollectionQuery {
			addField(field: "title", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func updatedAt(aliasSuffix: String? = nil) -> CollectionQuery {
			addField(field: "updatedAt", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Collection: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "descriptionHtml":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "descriptionPlainSummary":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "products":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ProductConnection(fields: value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Collection" }

		open var descriptionHtml: String {
			return internalGetDescriptionHtml()
		}

		func internalGetDescriptionHtml(aliasSuffix: String? = nil) -> String {
			return field(field: "descriptionHtml", aliasSuffix: aliasSuffix) as! String
		}

		open var descriptionPlainSummary: String {
			return internalGetDescriptionPlainSummary()
		}

		func internalGetDescriptionPlainSummary(aliasSuffix: String? = nil) -> String {
			return field(field: "descriptionPlainSummary", aliasSuffix: aliasSuffix) as! String
		}

		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(aliasSuffix: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: aliasSuffix) as! String
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var image: ApiSchema.Image? {
			return internalGetImage()
		}

		open func aliasedImage(aliasSuffix: String) -> ApiSchema.Image? {
			return internalGetImage(aliasSuffix: aliasSuffix)
		}

		func internalGetImage(aliasSuffix: String? = nil) -> ApiSchema.Image? {
			return field(field: "image", aliasSuffix: aliasSuffix) as! ApiSchema.Image?
		}

		open var products: ApiSchema.ProductConnection {
			return internalGetProducts()
		}

		open func aliasedProducts(aliasSuffix: String) -> ApiSchema.ProductConnection {
			return internalGetProducts(aliasSuffix: aliasSuffix)
		}

		func internalGetProducts(aliasSuffix: String? = nil) -> ApiSchema.ProductConnection {
			return field(field: "products", aliasSuffix: aliasSuffix) as! ApiSchema.ProductConnection
		}

		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(aliasSuffix: String? = nil) -> String {
			return field(field: "title", aliasSuffix: aliasSuffix) as! String
		}

		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: aliasSuffix) as! Date
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "descriptionHtml":

				return .Scalar

				case "descriptionPlainSummary":

				return .Scalar

				case "handle":

				return .Scalar

				case "id":

				return .Scalar

				case "image":

				return .Object

				case "products":

				return .Object

				case "title":

				return .Scalar

				case "updatedAt":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "image":
				return internalGetImage()

				case "products":
				return internalGetProducts()

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
					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "products":
					response.append(internalGetProducts())
					response.append(contentsOf: internalGetProducts().childResponseObjectMap())

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

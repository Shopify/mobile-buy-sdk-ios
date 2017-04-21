// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ProductQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func collections(aliasSuffix: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (CollectionConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CollectionConnectionQuery()
			subfields(subquery)

			addField(field: "collections", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func createdAt(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "createdAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func description(aliasSuffix: String? = nil, truncateAt: Int32? = nil) -> ProductQuery {
			var args: [String] = []

			if let truncateAt = truncateAt {
				args.append("truncateAt:\(truncateAt)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "description", aliasSuffix: aliasSuffix, args: argsString)
			return self
		}

		@discardableResult
		open func descriptionHtml(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "descriptionHtml", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func handle(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "handle", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func images(aliasSuffix: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

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

			let subquery = ImageConnectionQuery()
			subfields(subquery)

			addField(field: "images", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func options(aliasSuffix: String? = nil, first: Int32? = nil, _ subfields: (ProductOptionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductOptionQuery()
			subfields(subquery)

			addField(field: "options", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func productType(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "productType", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func publishedAt(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "publishedAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func tags(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "tags", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func title(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "title", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func updatedAt(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "updatedAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func variants(aliasSuffix: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (ProductVariantConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantConnectionQuery()
			subfields(subquery)

			addField(field: "variants", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func vendor(aliasSuffix: String? = nil) -> ProductQuery {
			addField(field: "vendor", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Product: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "collections":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CollectionConnection(fields: value)

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "description":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "descriptionHtml":
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

				case "images":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ImageConnection(fields: value)

				case "options":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try ProductOption(fields: $0) }

				case "productType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "publishedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "tags":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

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

				case "variants":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ProductVariantConnection(fields: value)

				case "vendor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Product" }

		open var collections: Storefront.CollectionConnection {
			return internalGetCollections()
		}

		open func aliasedCollections(aliasSuffix: String) -> Storefront.CollectionConnection {
			return internalGetCollections(aliasSuffix: aliasSuffix)
		}

		func internalGetCollections(aliasSuffix: String? = nil) -> Storefront.CollectionConnection {
			return field(field: "collections", aliasSuffix: aliasSuffix) as! Storefront.CollectionConnection
		}

		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var description: String {
			return internalGetDescription()
		}

		open func aliasedDescription(aliasSuffix: String) -> String {
			return internalGetDescription(aliasSuffix: aliasSuffix)
		}

		func internalGetDescription(aliasSuffix: String? = nil) -> String {
			return field(field: "description", aliasSuffix: aliasSuffix) as! String
		}

		open var descriptionHtml: String {
			return internalGetDescriptionHtml()
		}

		func internalGetDescriptionHtml(aliasSuffix: String? = nil) -> String {
			return field(field: "descriptionHtml", aliasSuffix: aliasSuffix) as! String
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

		open var images: Storefront.ImageConnection {
			return internalGetImages()
		}

		open func aliasedImages(aliasSuffix: String) -> Storefront.ImageConnection {
			return internalGetImages(aliasSuffix: aliasSuffix)
		}

		func internalGetImages(aliasSuffix: String? = nil) -> Storefront.ImageConnection {
			return field(field: "images", aliasSuffix: aliasSuffix) as! Storefront.ImageConnection
		}

		open var options: [Storefront.ProductOption] {
			return internalGetOptions()
		}

		open func aliasedOptions(aliasSuffix: String) -> [Storefront.ProductOption] {
			return internalGetOptions(aliasSuffix: aliasSuffix)
		}

		func internalGetOptions(aliasSuffix: String? = nil) -> [Storefront.ProductOption] {
			return field(field: "options", aliasSuffix: aliasSuffix) as! [Storefront.ProductOption]
		}

		open var productType: String {
			return internalGetProductType()
		}

		func internalGetProductType(aliasSuffix: String? = nil) -> String {
			return field(field: "productType", aliasSuffix: aliasSuffix) as! String
		}

		open var publishedAt: Date {
			return internalGetPublishedAt()
		}

		func internalGetPublishedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "publishedAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var tags: [String] {
			return internalGetTags()
		}

		func internalGetTags(aliasSuffix: String? = nil) -> [String] {
			return field(field: "tags", aliasSuffix: aliasSuffix) as! [String]
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

		open var variants: Storefront.ProductVariantConnection {
			return internalGetVariants()
		}

		open func aliasedVariants(aliasSuffix: String) -> Storefront.ProductVariantConnection {
			return internalGetVariants(aliasSuffix: aliasSuffix)
		}

		func internalGetVariants(aliasSuffix: String? = nil) -> Storefront.ProductVariantConnection {
			return field(field: "variants", aliasSuffix: aliasSuffix) as! Storefront.ProductVariantConnection
		}

		open var vendor: String {
			return internalGetVendor()
		}

		func internalGetVendor(aliasSuffix: String? = nil) -> String {
			return field(field: "vendor", aliasSuffix: aliasSuffix) as! String
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "collections":

				return .Object

				case "createdAt":

				return .Scalar

				case "description":

				return .Scalar

				case "descriptionHtml":

				return .Scalar

				case "handle":

				return .Scalar

				case "id":

				return .Scalar

				case "images":

				return .Object

				case "options":

				return .ObjectList

				case "productType":

				return .Scalar

				case "publishedAt":

				return .Scalar

				case "tags":

				return .ScalarList

				case "title":

				return .Scalar

				case "updatedAt":

				return .Scalar

				case "variants":

				return .Object

				case "vendor":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "collections":
				return internalGetCollections()

				case "images":
				return internalGetImages()

				case "variants":
				return internalGetVariants()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				case "options":
				return internalGetOptions()

				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "collections":
					response.append(internalGetCollections())
					response.append(contentsOf: internalGetCollections().childResponseObjectMap())

					case "images":
					response.append(internalGetImages())
					response.append(contentsOf: internalGetImages().childResponseObjectMap())

					case "options":
					internalGetOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "variants":
					response.append(internalGetVariants())
					response.append(contentsOf: internalGetVariants().childResponseObjectMap())

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

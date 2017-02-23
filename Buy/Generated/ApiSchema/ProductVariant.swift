// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class ProductVariantQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func available(aliasSuffix: String? = nil) -> ProductVariantQuery {
			addField(field: "available", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> ProductVariantQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func images(aliasSuffix: String? = nil, first: Int32? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageQuery) -> Void) -> ProductVariantQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
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

			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "images", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func price(aliasSuffix: String? = nil) -> ProductVariantQuery {
			addField(field: "price", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func product(aliasSuffix: String? = nil, _ subfields: (ProductQuery) -> Void) -> ProductVariantQuery {
			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "product", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func selectedOptions(aliasSuffix: String? = nil, _ subfields: (SelectedOptionQuery) -> Void) -> ProductVariantQuery {
			let subquery = SelectedOptionQuery()
			subfields(subquery)

			addField(field: "selectedOptions", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func title(aliasSuffix: String? = nil) -> ProductVariantQuery {
			addField(field: "title", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func weight(aliasSuffix: String? = nil) -> ProductVariantQuery {
			addField(field: "weight", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func weightUnit(aliasSuffix: String? = nil) -> ProductVariantQuery {
			addField(field: "weightUnit", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class ProductVariant: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "available":
				if value is NSNull { return nil }
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "images":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Image(fields: $0) }

				case "price":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "product":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				case "selectedOptions":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try SelectedOption(fields: $0) }

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "weight":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "weightUnit":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return WeightUnit(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "ProductVariant" }

		open var available: Bool? {
			return internalGetAvailable()
		}

		func internalGetAvailable(aliasSuffix: String? = nil) -> Bool? {
			return field(field: "available", aliasSuffix: aliasSuffix) as! Bool?
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var images: [ApiSchema.Image] {
			return internalGetImages()
		}

		open func aliasedImages(aliasSuffix: String) -> [ApiSchema.Image] {
			return internalGetImages(aliasSuffix: aliasSuffix)
		}

		func internalGetImages(aliasSuffix: String? = nil) -> [ApiSchema.Image] {
			return field(field: "images", aliasSuffix: aliasSuffix) as! [ApiSchema.Image]
		}

		open var price: NSDecimalNumber {
			return internalGetPrice()
		}

		func internalGetPrice(aliasSuffix: String? = nil) -> NSDecimalNumber {
			return field(field: "price", aliasSuffix: aliasSuffix) as! NSDecimalNumber
		}

		open var product: ApiSchema.Product {
			return internalGetProduct()
		}

		func internalGetProduct(aliasSuffix: String? = nil) -> ApiSchema.Product {
			return field(field: "product", aliasSuffix: aliasSuffix) as! ApiSchema.Product
		}

		open var selectedOptions: [ApiSchema.SelectedOption] {
			return internalGetSelectedOptions()
		}

		func internalGetSelectedOptions(aliasSuffix: String? = nil) -> [ApiSchema.SelectedOption] {
			return field(field: "selectedOptions", aliasSuffix: aliasSuffix) as! [ApiSchema.SelectedOption]
		}

		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(aliasSuffix: String? = nil) -> String {
			return field(field: "title", aliasSuffix: aliasSuffix) as! String
		}

		open var weight: Double? {
			return internalGetWeight()
		}

		func internalGetWeight(aliasSuffix: String? = nil) -> Double? {
			return field(field: "weight", aliasSuffix: aliasSuffix) as! Double?
		}

		open var weightUnit: ApiSchema.WeightUnit {
			return internalGetWeightUnit()
		}

		func internalGetWeightUnit(aliasSuffix: String? = nil) -> ApiSchema.WeightUnit {
			return field(field: "weightUnit", aliasSuffix: aliasSuffix) as! ApiSchema.WeightUnit
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "available":

				return .Scalar

				case "id":

				return .Scalar

				case "images":

				return .ObjectList

				case "price":

				return .Scalar

				case "product":

				return .Object

				case "selectedOptions":

				return .ObjectList

				case "title":

				return .Scalar

				case "weight":

				return .Scalar

				case "weightUnit":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "product":
				return internalGetProduct()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				case "images":
				return internalGetImages()

				case "selectedOptions":
				return internalGetSelectedOptions()

				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "images":
					internalGetImages().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "product":
					response.append(internalGetProduct())
					response.append(contentsOf: internalGetProduct().childResponseObjectMap())

					case "selectedOptions":
					internalGetSelectedOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
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

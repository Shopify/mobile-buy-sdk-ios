// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
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
		open func image(aliasSuffix: String? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageQuery) -> Void) -> ProductVariantQuery {
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

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "price":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

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

		open var image: Storefront.Image? {
			return internalGetImage()
		}

		open func aliasedImage(aliasSuffix: String) -> Storefront.Image? {
			return internalGetImage(aliasSuffix: aliasSuffix)
		}

		func internalGetImage(aliasSuffix: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: aliasSuffix) as! Storefront.Image?
		}

		open var price: Decimal {
			return internalGetPrice()
		}

		func internalGetPrice(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "price", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var product: Storefront.Product {
			return internalGetProduct()
		}

		func internalGetProduct(aliasSuffix: String? = nil) -> Storefront.Product {
			return field(field: "product", aliasSuffix: aliasSuffix) as! Storefront.Product
		}

		open var selectedOptions: [Storefront.SelectedOption] {
			return internalGetSelectedOptions()
		}

		func internalGetSelectedOptions(aliasSuffix: String? = nil) -> [Storefront.SelectedOption] {
			return field(field: "selectedOptions", aliasSuffix: aliasSuffix) as! [Storefront.SelectedOption]
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

		open var weightUnit: Storefront.WeightUnit {
			return internalGetWeightUnit()
		}

		func internalGetWeightUnit(aliasSuffix: String? = nil) -> Storefront.WeightUnit {
			return field(field: "weightUnit", aliasSuffix: aliasSuffix) as! Storefront.WeightUnit
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "available":

				return .Scalar

				case "id":

				return .Scalar

				case "image":

				return .Object

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
				case "image":
				return internalGetImage()

				case "product":
				return internalGetProduct()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
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
					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
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

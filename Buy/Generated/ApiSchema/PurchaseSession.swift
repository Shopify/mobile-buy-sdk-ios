// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class PurchaseSessionQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func createdAt(aliasSuffix: String? = nil) -> PurchaseSessionQuery {
			addField(field: "createdAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> PurchaseSessionQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func items(aliasSuffix: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (LineItemConnectionQuery) -> Void) -> PurchaseSessionQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = LineItemConnectionQuery()
			subfields(subquery)

			addField(field: "items", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func requiresShipping(aliasSuffix: String? = nil) -> PurchaseSessionQuery {
			addField(field: "requiresShipping", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func shippingAddress(aliasSuffix: String? = nil, _ subfields: (AddressQuery) -> Void) -> PurchaseSessionQuery {
			let subquery = AddressQuery()
			subfields(subquery)

			addField(field: "shippingAddress", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func shippingLine(aliasSuffix: String? = nil, _ subfields: (ShippingRateQuery) -> Void) -> PurchaseSessionQuery {
			let subquery = ShippingRateQuery()
			subfields(subquery)

			addField(field: "shippingLine", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func updatedAt(aliasSuffix: String? = nil) -> PurchaseSessionQuery {
			addField(field: "updatedAt", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class PurchaseSession: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "items":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try LineItemConnection(fields: value)

				case "requiresShipping":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Address(fields: value)

				case "shippingLine":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShippingRate(fields: value)

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "PurchaseSession" }

		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var items: ApiSchema.LineItemConnection {
			return internalGetItems()
		}

		open func aliasedItems(aliasSuffix: String) -> ApiSchema.LineItemConnection {
			return internalGetItems(aliasSuffix: aliasSuffix)
		}

		func internalGetItems(aliasSuffix: String? = nil) -> ApiSchema.LineItemConnection {
			return field(field: "items", aliasSuffix: aliasSuffix) as! ApiSchema.LineItemConnection
		}

		open var requiresShipping: Bool {
			return internalGetRequiresShipping()
		}

		func internalGetRequiresShipping(aliasSuffix: String? = nil) -> Bool {
			return field(field: "requiresShipping", aliasSuffix: aliasSuffix) as! Bool
		}

		open var shippingAddress: ApiSchema.Address? {
			return internalGetShippingAddress()
		}

		func internalGetShippingAddress(aliasSuffix: String? = nil) -> ApiSchema.Address? {
			return field(field: "shippingAddress", aliasSuffix: aliasSuffix) as! ApiSchema.Address?
		}

		open var shippingLine: ApiSchema.ShippingRate? {
			return internalGetShippingLine()
		}

		func internalGetShippingLine(aliasSuffix: String? = nil) -> ApiSchema.ShippingRate? {
			return field(field: "shippingLine", aliasSuffix: aliasSuffix) as! ApiSchema.ShippingRate?
		}

		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: aliasSuffix) as! Date
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "createdAt":

				return .Scalar

				case "id":

				return .Scalar

				case "items":

				return .Object

				case "requiresShipping":

				return .Scalar

				case "shippingAddress":

				return .Object

				case "shippingLine":

				return .Object

				case "updatedAt":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "items":
				return internalGetItems()

				case "shippingAddress":
				return internalGetShippingAddress()

				case "shippingLine":
				return internalGetShippingLine()

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
					case "items":
					response.append(internalGetItems())
					response.append(contentsOf: internalGetItems().childResponseObjectMap())

					case "shippingAddress":
					if let value = internalGetShippingAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingLine":
					if let value = internalGetShippingLine() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
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

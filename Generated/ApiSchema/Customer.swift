// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class CustomerQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func acceptsMarketing(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "acceptsMarketing", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func addresses(aliasSuffix: String? = nil, first: Int32? = nil, _ subfields: (AddressQuery) -> Void) -> CustomerQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = AddressQuery()
			subfields(subquery)

			addField(field: "addresses", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func createdAt(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "createdAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func defaultAddress(aliasSuffix: String? = nil, _ subfields: (AddressQuery) -> Void) -> CustomerQuery {
			let subquery = AddressQuery()
			subfields(subquery)

			addField(field: "defaultAddress", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func displayName(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "displayName", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func email(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "email", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func firstName(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "firstName", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func lastName(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "lastName", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func orders(aliasSuffix: String? = nil, first: Int32, after: String? = nil, sortKey: OrderSortKeys? = nil, reverse: Bool? = nil, query: String? = nil, _ subfields: (OrderConnectionQuery) -> Void) -> CustomerQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = OrderConnectionQuery()
			subfields(subquery)

			addField(field: "orders", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func updatedAt(aliasSuffix: String? = nil) -> CustomerQuery {
			addField(field: "updatedAt", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Customer: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "acceptsMarketing":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "addresses":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Address(fields: $0) }

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "defaultAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Address(fields: value)

				case "displayName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "firstName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lastName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "orders":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try OrderConnection(fields: value)

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Customer" }

		open var acceptsMarketing: Bool {
			return internalGetAcceptsMarketing()
		}

		func internalGetAcceptsMarketing(aliasSuffix: String? = nil) -> Bool {
			return field(field: "acceptsMarketing", aliasSuffix: aliasSuffix) as! Bool
		}

		open var addresses: [ApiSchema.Address] {
			return internalGetAddresses()
		}

		open func aliasedAddresses(aliasSuffix: String) -> [ApiSchema.Address] {
			return internalGetAddresses(aliasSuffix: aliasSuffix)
		}

		func internalGetAddresses(aliasSuffix: String? = nil) -> [ApiSchema.Address] {
			return field(field: "addresses", aliasSuffix: aliasSuffix) as! [ApiSchema.Address]
		}

		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var defaultAddress: ApiSchema.Address? {
			return internalGetDefaultAddress()
		}

		func internalGetDefaultAddress(aliasSuffix: String? = nil) -> ApiSchema.Address? {
			return field(field: "defaultAddress", aliasSuffix: aliasSuffix) as! ApiSchema.Address?
		}

		open var displayName: String {
			return internalGetDisplayName()
		}

		func internalGetDisplayName(aliasSuffix: String? = nil) -> String {
			return field(field: "displayName", aliasSuffix: aliasSuffix) as! String
		}

		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(aliasSuffix: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: aliasSuffix) as! String?
		}

		open var firstName: String? {
			return internalGetFirstName()
		}

		func internalGetFirstName(aliasSuffix: String? = nil) -> String? {
			return field(field: "firstName", aliasSuffix: aliasSuffix) as! String?
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var lastName: String? {
			return internalGetLastName()
		}

		func internalGetLastName(aliasSuffix: String? = nil) -> String? {
			return field(field: "lastName", aliasSuffix: aliasSuffix) as! String?
		}

		open var orders: ApiSchema.OrderConnection {
			return internalGetOrders()
		}

		open func aliasedOrders(aliasSuffix: String) -> ApiSchema.OrderConnection {
			return internalGetOrders(aliasSuffix: aliasSuffix)
		}

		func internalGetOrders(aliasSuffix: String? = nil) -> ApiSchema.OrderConnection {
			return field(field: "orders", aliasSuffix: aliasSuffix) as! ApiSchema.OrderConnection
		}

		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: aliasSuffix) as! Date
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "acceptsMarketing":

				return .Scalar

				case "addresses":

				return .ObjectList

				case "createdAt":

				return .Scalar

				case "defaultAddress":

				return .Object

				case "displayName":

				return .Scalar

				case "email":

				return .Scalar

				case "firstName":

				return .Scalar

				case "id":

				return .Scalar

				case "lastName":

				return .Scalar

				case "orders":

				return .Object

				case "updatedAt":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "defaultAddress":
				return internalGetDefaultAddress()

				case "orders":
				return internalGetOrders()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				case "addresses":
				return internalGetAddresses()

				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "addresses":
					internalGetAddresses().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "defaultAddress":
					if let value = internalGetDefaultAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "orders":
					response.append(internalGetOrders())
					response.append(contentsOf: internalGetOrders().childResponseObjectMap())

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

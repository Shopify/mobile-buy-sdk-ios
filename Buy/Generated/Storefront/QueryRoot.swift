// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class QueryRootQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func customer(aliasSuffix: String? = nil, _ subfields: (CustomerQuery) -> Void) -> QueryRootQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func node(aliasSuffix: String? = nil, id: GraphQL.ID, _ subfields: (NodeQuery) -> Void) -> QueryRootQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = NodeQuery()
			subfields(subquery)

			addField(field: "node", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func shop(aliasSuffix: String? = nil, _ subfields: (ShopQuery) -> Void) -> QueryRootQuery {
			let subquery = ShopQuery()
			subfields(subquery)

			addField(field: "shop", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class QueryRoot: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "node":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try UnknownNode.create(fields: value)

				case "shop":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Shop(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "QueryRoot" }

		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(aliasSuffix: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: aliasSuffix) as! Storefront.Customer?
		}

		open var node: Node? {
			return internalGetNode()
		}

		open func aliasedNode(aliasSuffix: String) -> Node? {
			return internalGetNode(aliasSuffix: aliasSuffix)
		}

		func internalGetNode(aliasSuffix: String? = nil) -> Node? {
			return field(field: "node", aliasSuffix: aliasSuffix) as! Node?
		}

		open var shop: Storefront.Shop {
			return internalGetShop()
		}

		func internalGetShop(aliasSuffix: String? = nil) -> Storefront.Shop {
			return field(field: "shop", aliasSuffix: aliasSuffix) as! Storefront.Shop
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "customer":

				return .Object

				case "node":

				return .Object

				case "shop":

				return .Object

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "customer":
				return internalGetCustomer()

				case "node":
				return internalGetNode()?.responseObject()

				case "shop":
				return internalGetShop()

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
					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "node":
					if let value = internalGetNode() {
						response.append(value as! GraphQL.AbstractResponse)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shop":
					response.append(internalGetShop())
					response.append(contentsOf: internalGetShop().childResponseObjectMap())

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

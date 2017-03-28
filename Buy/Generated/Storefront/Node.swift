// Generated from graphql_swift_gen gem
import Foundation

public protocol Node {
	var typeName: String { get }

	var id: GraphQL.ID { get }

	func childResponseObjectMap() -> [GraphQL.AbstractResponse]

	func responseObject() -> GraphQL.AbstractResponse
}

extension Storefront {
	open class NodeQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func id(aliasSuffix: String? = nil) -> NodeQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		@discardableResult
		open func onCheckout(subfields: (CheckoutQuery) -> Void) -> NodeQuery {
			let subquery = CheckoutQuery()
			subfields(subquery)
			addInlineFragment(on: "Checkout", subfields: subquery)
			return self
		}

		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> NodeQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		@discardableResult
		open func onMailingAddress(subfields: (MailingAddressQuery) -> Void) -> NodeQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)
			addInlineFragment(on: "MailingAddress", subfields: subquery)
			return self
		}

		@discardableResult
		open func onOrder(subfields: (OrderQuery) -> Void) -> NodeQuery {
			let subquery = OrderQuery()
			subfields(subquery)
			addInlineFragment(on: "Order", subfields: subquery)
			return self
		}

		@discardableResult
		open func onPayment(subfields: (PaymentQuery) -> Void) -> NodeQuery {
			let subquery = PaymentQuery()
			subfields(subquery)
			addInlineFragment(on: "Payment", subfields: subquery)
			return self
		}

		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> NodeQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		@discardableResult
		open func onProductOption(subfields: (ProductOptionQuery) -> Void) -> NodeQuery {
			let subquery = ProductOptionQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductOption", subfields: subquery)
			return self
		}

		@discardableResult
		open func onProductVariant(subfields: (ProductVariantQuery) -> Void) -> NodeQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductVariant", subfields: subquery)
			return self
		}

		@discardableResult
		open func onShopPolicy(subfields: (ShopPolicyQuery) -> Void) -> NodeQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)
			addInlineFragment(on: "ShopPolicy", subfields: subquery)
			return self
		}
	}

	open class UnknownNode: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return field(field: "__typename") as! String }

		open static func create(fields: [String: Any]) throws -> Node {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownNode.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Checkout":
				return try Checkout.init(fields: fields)

				case "Collection":
				return try Collection.init(fields: fields)

				case "MailingAddress":
				return try MailingAddress.init(fields: fields)

				case "Order":
				return try Order.init(fields: fields)

				case "Payment":
				return try Payment.init(fields: fields)

				case "Product":
				return try Product.init(fields: fields)

				case "ProductOption":
				return try ProductOption.init(fields: fields)

				case "ProductVariant":
				return try ProductVariant.init(fields: fields)

				case "ShopPolicy":
				return try ShopPolicy.init(fields: fields)

				default:
				return try UnknownNode.init(fields: fields)
			}
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "id":

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

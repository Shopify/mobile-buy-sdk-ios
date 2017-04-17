// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutLineItemUpdateInput {
		open var id: GraphQL.ID?

		open var variantId: GraphQL.ID?

		open var quantity: Int32?

		open var customAttributes: [AttributeInput]?

		public init(
			id: GraphQL.ID? = nil,

			variantId: GraphQL.ID? = nil,

			quantity: Int32? = nil,

			customAttributes: [AttributeInput]? = nil
		) {
			self.id = id

			self.variantId = variantId

			self.quantity = quantity

			self.customAttributes = customAttributes
		}

		func serialize() -> String {
			var fields: [String] = []

			if let id = id {
				fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")
			}

			if let variantId = variantId {
				fields.append("variantId:\(GraphQL.quoteString(input: "\(variantId.rawValue)"))")
			}

			if let quantity = quantity {
				fields.append("quantity:\(quantity)")
			}

			if let customAttributes = customAttributes {
				fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

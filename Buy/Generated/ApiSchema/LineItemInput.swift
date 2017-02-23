// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class LineItemInput {
		open var variantId: GraphQL.ID

		open var quantity: Int32

		open var customAttributes: [AttributeInput]?

		public init(
			variantId: GraphQL.ID,

			quantity: Int32,

			customAttributes: [AttributeInput]? = nil
		) {
			self.variantId = variantId

			self.quantity = quantity

			self.customAttributes = customAttributes
		}

		func serialize() -> String {
			var fields: [String] = []

			fields.append("variantId:\(GraphQL.quoteString(input: "\(variantId.rawValue)"))")

			fields.append("quantity:\(quantity)")

			if let customAttributes = customAttributes {
				fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

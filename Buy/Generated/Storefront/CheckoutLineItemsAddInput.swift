// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutLineItemsAddInput {
		open var clientMutationId: String?

		open var lineItems: [CheckoutLineItemInput]?

		open var checkoutId: GraphQL.ID

		public init(
			checkoutId: GraphQL.ID,

			clientMutationId: String? = nil,

			lineItems: [CheckoutLineItemInput]? = nil
		) {
			self.clientMutationId = clientMutationId

			self.lineItems = lineItems

			self.checkoutId = checkoutId
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			if let lineItems = lineItems {
				fields.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

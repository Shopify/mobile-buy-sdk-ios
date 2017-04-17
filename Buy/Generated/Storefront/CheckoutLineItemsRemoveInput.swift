// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutLineItemsRemoveInput {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		open var lineItemIds: [GraphQL.ID]

		public init(
			checkoutId: GraphQL.ID,

			lineItemIds: [GraphQL.ID],

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId

			self.lineItemIds = lineItemIds
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			fields.append("lineItemIds:[\(lineItemIds.map{ "\(GraphQL.quoteString(input: "\($0.rawValue)"))" }.joined(separator: ","))]")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

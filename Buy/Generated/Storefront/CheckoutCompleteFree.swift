// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutCompleteFree {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		public init(
			checkoutId: GraphQL.ID,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

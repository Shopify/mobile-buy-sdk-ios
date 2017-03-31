// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutEmailUpdateInput {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		open var email: String

		public init(
			checkoutId: GraphQL.ID,

			email: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId

			self.email = email
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			fields.append("email:\(GraphQL.quoteString(input: email))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

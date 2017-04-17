// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutCustomerAssociateInput {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		open var customerAccessToken: String

		public init(
			checkoutId: GraphQL.ID,

			customerAccessToken: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId

			self.customerAccessToken = customerAccessToken
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			fields.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

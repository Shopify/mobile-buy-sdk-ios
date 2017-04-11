// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAccessTokenDeleteInput {
		open var clientMutationId: String?

		open var customerAccessToken: String

		public init(
			customerAccessToken: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.customerAccessToken = customerAccessToken
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

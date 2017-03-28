// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAccessTokenRenewInput {
		open var clientMutationId: String?

		open var accessToken: String

		public init(
			accessToken: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.accessToken = accessToken
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("accessToken:\(GraphQL.quoteString(input: accessToken))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

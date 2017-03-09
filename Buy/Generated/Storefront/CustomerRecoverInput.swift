// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerRecoverInput {
		open var clientMutationId: String?

		open var email: String

		public init(
			email: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.email = email
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("email:\(GraphQL.quoteString(input: email))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

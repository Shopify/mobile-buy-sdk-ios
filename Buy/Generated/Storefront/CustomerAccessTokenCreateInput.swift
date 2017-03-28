// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAccessTokenCreateInput {
		open var clientMutationId: String?

		open var email: String

		open var password: String

		public init(
			email: String,

			password: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.email = email

			self.password = password
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("email:\(GraphQL.quoteString(input: email))")

			fields.append("password:\(GraphQL.quoteString(input: password))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

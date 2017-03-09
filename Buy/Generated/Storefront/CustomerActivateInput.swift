// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerActivateInput {
		open var clientMutationId: String?

		open var id: GraphQL.ID

		open var token: String

		open var password: String

		public init(
			id: GraphQL.ID,

			token: String,

			password: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.id = id

			self.token = token

			self.password = password
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			fields.append("token:\(GraphQL.quoteString(input: token))")

			fields.append("password:\(GraphQL.quoteString(input: password))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}

// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerResetInput {
		open var clientMutationId: String?

		open var id: GraphQL.ID

		open var resetToken: String

		open var password: String

		public init(
			id: GraphQL.ID,

			resetToken: String,

			password: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.id = id

			self.resetToken = resetToken

			self.password = password
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			fields.append("resetToken:\(GraphQL.quoteString(input: resetToken))")

			fields.append("password:\(GraphQL.quoteString(input: password))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
